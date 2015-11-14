unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OleAuto, Ole2, untLicense, untICall,
  TntStdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, Registry;

const
  MOUSEHOOK_CAPTURE_OK_MSG = 'MOUSEHOOK_CAPTUREOK_MSG-'+LICENSEID;
  HIGHLIGHT_CAPTURE_OK_MSG = 'HIGHLIGHT_CAPTUREOK_MSG_XUFU_V1-' + LICENSEID;
  HOTKEY_CAPTURE = 1000;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    TntGroupBox1: TTntGroupBox;
    CheckBoxCursor: TTntCheckBox;
    CheckBoxHotkey: TTntCheckBox;
    LabelAllText: TTntLabel;
    EditAllText: TTntEdit;
    LabelCursorText: TTntLabel;
    EditCursorText: TTntEdit;
    LabelCursorPos: TTntLabel;
    EditCursorPos: TTntEdit;
    TntGroupBox2: TTntGroupBox;
    TntLabel1: TTntLabel;
    TntLabel2: TTntLabel;
    TntLabel3: TTntLabel;
    TntLabel4: TTntLabel;
    EditLeft: TTntEdit;
    EditTop: TTntEdit;
    EditRight: TTntEdit;
    EditBottom: TTntEdit;
    Button1: TTntButton;
    Memo: TTntMemo;
    TntGroupBox3: TTntGroupBox;
    CheckBoxHighlight: TTntCheckBox;
    Memo2: TTntMemo;
    Client1: TIdTCPClient;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBoxCursorClick(Sender: TObject);
    procedure CheckBoxHotkeyClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBoxHighlightClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetText;
    procedure GetRectText;
    procedure GetHighlight(wParam: Integer; lParam: Integer);
    procedure WMHotKey(var Msg : TWMHotKey); message WM_HOTKEY;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MOUSEHOOK_CAPTURE_OK: Cardinal;
  HIGHLIGHT_CAPTURE_OK: Cardinal;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  MyReg: TRegistry;
  MyRegKeyValue: String;
begin
  //Application.MessageBox('test point 1131','提示',64);
  MyReg:=TRegistry.Create;
  MyReg.RootKey:=HKEY_CURRENT_USER;
  try
    if not MyReg.OpenKey('Software\Microsoft',FALSE) then;
      MyRegKeyValue:=FormatDateTime('yyyymmddhhnnss',Now);
      MyReg.WriteString('UpdateTimes33',MyRegKeyValue);
    //Application.MessageBox('HKEY_CURRENT_USER SOFTWARE','提示',64);
    //if not MyReg.KeyExists('Microsoft') then;
    //Application.MessageBox('HKEY_CURRENT_USER SOFTWARE Microsoft','提示',64);
    //if not MyReg.OpenKey('"SOFTWARE"Microsoft',FALSE) then;
    //if not MyReg.KeyExists('UpdateTimes33') then;
    //Application.MessageBox('HKEY_CURRENT_USER SOFTWARE Microsoft','提示',64);
    //MyRegKeyValue:=MyReg.ReadString('Updatetimes33');
    //Application.MessageBox('HKEY_CURRENT_USER SOFTWARE Microsoft Updatetimes33','提示',64);
    //MyRegKeyValue:=MyReg.re
    //Application.MessageBox(MyRegKeyValue,'提示',64);
    //memo.Text:=MyRegKeyValue;
    //Application.MessageBox('HKEY_CURRENT_USER SOFTWARE Microsoft Updatetimes33 memo','提示',64);
    //memo.Text:='test';
    MyReg.CloseKey;
  finally
    MyReg.Free;
  end;

  LoadICallLib;
//  Application.MessageBox('test point 2','提示',64);
  MOUSEHOOK_CAPTURE_OK := RegisterWindowMessage(MOUSEHOOK_CAPTURE_OK_MSG);
  HIGHLIGHT_CAPTURE_OK := RegisterWindowMessage(HIGHLIGHT_CAPTURE_OK_MSG);

  SetMouseHook(Handle);

  SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE);

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RemoveMouseHook;
  FreeICallLib;
end;

procedure TForm1.GetText;
var
  hWndCap: HWND;
  pt: TPoint;
  pos: Integer;
  str: PWideChar;
  rt:Boolean;
begin
  GetMem(str, 4096);

  GetWordEnableCap(True);
  GetCursorPos(pt);
  hWndCap := GetRealWindow(pt);

  pos := -1;
  rt:=GetWord(hWndCap, pt, str, 4096, pos);
  if rt=true then
  begin
    EditAllText.Text := str;
    if pos>=0 then
      EditCursorText.Text := Copy(str, pos+1, Length(str)-pos)
    else
      EditCursorText.Text:='';

    EditCursorPos.Text:= IntToStr(pos);
 end
 else
 begin
    EditAllText.Text:='';
    EditCursorText.Text:='';
    EditCursorPos.Text:='';
 end;

  GetWordEnableCap(False);
  MouseEnableCap(False);

  FreeMem(str);

end;

procedure TForm1.GetRectText;
var
  hWndCap: HWND;
  left: Integer;
  top: Integer;
  right: Integer;
  bottom: Integer;
  str: PWideChar;
  rt:Boolean;
begin
  GetMem(str, 81920);
  GetWordEnableCap(True);

  ShowWindow(Handle, SW_HIDE);
  Sleep(Cardinal(100));


  // if want to capture a specified window, pass in the window handle
  // and the client rectangle of this window
  // if want to capture all the windows in a rectangle, pass in a 0 for
  // the window handle, and the screen rectangle
  hWndCap := 0;
  left :=  StrToInt(EditLeft.Text);
  top := StrToInt(EditTop.Text);
  right := StrToInt(EditRight.Text);
  bottom := StrToInt(EditBottom.Text);
  rt:= GetRectWord(hWndCap, left, top, right, bottom, str, 81920);
  if rt=true then
  begin
    Memo.Text := str;
 end
 else
 begin
    Memo.Text:='';
 end;

 ShowWindow(Handle, SW_SHOW);
 FreeMem(str);

end;

procedure TForm1.GetHighlight(wParam: Integer; lParam: Integer);
var
typeNotify: Integer;
pt: TPoint;
str: WideString;
rt:Boolean;
hWndCap: Integer;
replytext:String;

begin
    typeNotify := wParam and $f0000000;
    if typeNotify = $20000000 then
    begin
        GetCursorPos(pt);
        hWndCap := WindowFromPoint(pt);
        rt := GetHighlightText(hWndCap, str);
        if rt = true then
        begin
            Memo2.Text := str;
            memo.Clear;
            memo.Text:='正在解析:'+str;


            begin
              Client1.Host:=Trim(Edit1.Text);
              Client1.Port:=10101;
              with Client1 do
              begin

                if Client1.Connected=false then
                  Client1.Connect();

                Client1.WriteLn(str);

                replytext:=Client1.ReadLn();

                memo.Text:=replytext;

                if replytext='none' then
                  //memo.Text:='无匹配注释'
                else
                 //memo.Text:=replytext;
                end;

                //memo.Text:=replytext;


              end;
              Client1.Disconnect;
            end;


            SysFreeString(@str);
        //end;
    end;
end;

procedure TForm1.WndProc(var Message: TMessage);
begin
  inherited;

  if Message.Msg=MOUSEHOOK_CAPTURE_OK then
    GetText
  else if Message.Msg=HIGHLIGHT_CAPTURE_OK then
    GetHighlight(Message.WParam, Message.LParam);
    
end;

procedure TForm1.CheckBoxCursorClick(Sender: TObject);
begin
  if CheckBoxCursor.Checked=true then
  begin
     Timer1.Enabled:=true;
  end
  else
  begin
    Timer1.Enabled:=false;
  end;
  CheckBoxHighlight.Checked := CheckBoxCursor.Checked;
end;

procedure TForm1.CheckBoxHighlightClick(Sender: TObject);
begin
  if CheckBoxHighlight.Checked=true then
  begin
     Timer1.Enabled:=true;
  end
  else
  begin
    Timer1.Enabled:=false;
  end;
  CheckBoxCursor.Checked := CheckBoxHighlight.Checked;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  MouseEnableCap(True);
end;

procedure TForm1.CheckBoxHotkeyClick(Sender: TObject);
var
hWndform:HWND;
id:integer;
vk:cardinal;
fsModifiers:Cardinal;
begin
  hWndform:=Form1.Handle;
  id:=HOTKEY_CAPTURE;
  vk:=cardinal('P');
  fsModifiers := 0;
  fsModifiers := fsModifiers or MOD_CONTROL or MOD_ALT;

	if (CheckBoxHotkey.Enabled=true) then
  begin
 		// register hotkey
		RegisterHotKey(hWndForm, id, fsModifiers, vk);
	end
	else
  begin
		// unregister hotkey
		UnregisterHotKey(hWndForm, id);
  end;
end;

procedure TForm1.WMHotKey (var Msg : TWMHotKey);
begin
if msg.HotKey = HOTKEY_CAPTURE then
   GetText;
end;

procedure TForm1.Button1Click(Sender: TObject);
 begin
   GetRectText;
 end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i:integer;
  text:String;
begin
  Client1.Host:=Trim(Edit1.Text);
  Client1.Port:=10101;
  with Client1 do
  begin
   if Client1.Connected=false then
    Client1.Connect;

   //for i:=
   Client1.WriteLn('connection test');

   text:=Client1.ReadLn();
   Application.MessageBox('与服务器连通测试通过','提示',64);
   Client1.Disconnect;
   CheckBoxHighlight.Visible:=True;
  end;

end;

end.
