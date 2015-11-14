unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, IdTCPServer, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, ComCtrls, IdPOP3Server, IdMessageClient,
  IdPOP3, StdCtrls, Buttons, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Client1: TIdTCPClient;
    Server1: TIdTCPServer;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button2: TButton;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    Memo2: TMemo;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Edit3: TEdit;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    XMLDocument1: TXMLDocument;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Server1Connect(AThread: TIdPeerThread);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  strKeywordsList: TStringList;
  strTipList: TStringList;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
begin
  Server1.Active := True;
  StatusBar1.Panels[3].Text := FormatDateTime('yyyy-mm-dd',Now);
  //xml-test
  XMLDocument1.LoadFromFile('d:\xcreenconfig.xml');
  strKeywordsList:=TStringList.Create;
  strTipList:=TStringList.Create;
      //ShowMessage(XMLDocument1.DocumentElement.ChildNodes[0].ChildNodes['keywords'].Text);
  for i:=0 to XMLDocument1.DocumentElement.ChildNodes.Count-1 do
  begin
    //strKeywordList:=TStringList.Create;
    strKeywordsList.Add(XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['keywords'].Text);
    strTipList.Add(XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes['tip'].Text);
  end;
  //ShowMessage(IntToStr(XMLDocument1.DocumentElement.ChildNodes.Count));
    //strKeywordsList.Add(XMLDocument1.DocumentElement.ChildNodes[1].ChildNodes['keywords'].Text);
    //strTipList.Add(XMLDocument1.DocumentElement.ChildNodes[1].ChildNodes['tip'].Text);
  //ShowMessage(strKeywordsList[0]);
  //xml-test
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
  text:String;
begin
  //ShowMessage(strKeywordsList[0]); //xml-test
  Client1.Host := Trim(Edit1.Text);
  Client1.Port := 1001;
  with Client1 do
  begin
    If Client1.Connected = False then
      Client1.Connect;
    For i := 0 to Memo1.Lines.Count-1 do
      Client1.WriteLN(Memo1.Lines[i]);

    text:= Client1.ReadLn();
    Memo1.Text:=text;
    //Application.MessageBox('对方已读!','提示',64);
    Client1.Disconnect;
  end;
  Memo1.Clear;
end;

procedure TForm1.Server1Connect(AThread: TIdPeerThread);
var
  text: String;
  strReply: String;
  i: integer;
begin
  //Application.MessageBox('来了新邮件.','提示',64);
  text := Athread.Connection.Readln;
  strReply :='无对应解析';
  //Athread.Connection.WriteLn('对方已读');
  for i:=0 to strKeywordsList.Count-1 do
  begin
    if  text=strKeywordsList[i] then
        begin
          strReply:=strTipList[i];
          break;
        end;
    //else
    //end;

  end;

  //if text=strKeywordsList[0] then
    //begin
      //strReply:=text+strTipList[0]
    //end
  //else
  //strReply:=text+strTipList[1];

  Athread.Connection.WriteLn(strReply);
  //text := Athread.Connection.Readln;
  Edit3.Text := FormatDateTime('hh-mm-ss',Now);
  while Trim(Text)<>'' do
  begin
   //memo2.Lines.Add(text);
   //memo2.Lines.
   text := Athread.Connection.Readln;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Edit3.Clear;
  Memo2.Clear;
end;

end.
