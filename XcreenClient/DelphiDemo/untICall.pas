unit untICall;

interface

uses
  Windows;

type
  TGetRealWindow = function(ptCursor: TPoint): HWND; stdcall;
  TGetWord = function(hWndCap: HWND; ptCursor: TPoint; str: PWideChar; nBufLen: Integer;
                      var nCursorPos: Integer): Boolean; stdcall;
  TGetRectWord = function(hWndCap: HWND; left: Integer; top: Integer; right: Integer; bottom: Integer;
                          str: PWideChar; nBufLen: Integer): Boolean; stdcall;
  TSetCapWndWidth = procedure(nWidth: Integer); stdcall;
  TGetWordEnableCap = function(bEnable: Boolean): Boolean; stdcall;
  TGetWordIsCapEnable = function(): Boolean; stdcall;
  TSetMouseHook = function(hWndNotify: HWND): Boolean; stdcall;
  TRemoveMouseHook = function(): Boolean; stdcall;
  TMouseEnableCap = function(bEnable: Boolean): Boolean; stdcall;
  TMouseSetDelay = procedure(uMilliSec: Cardinal);stdcall;
  TGetHighlightText = function(hWndNotify: Integer; var str: WideString): Boolean; stdcall;

var
  GetRealWindow: TGetRealWindow;
  GetWord: TGetWord;
  GetRectWord: TGetRectWord;
  SetCapWndWidth: TSetCapWndWidth;
  GetWordEnableCap: TGetWordEnableCap;
  GetWordIsCapEnable: TGetWordIsCapEnable;
  SetMouseHook: TSetMouseHook;
  RemoveMouseHook: TRemoveMouseHook;
  MouseEnableCap: TMouseEnableCap;
  MouseSetDelay: TMouseSetDelay;
  GetHighlightText: TGetHighlightText;

function LoadICallLib: Boolean;
function FreeICallLib: Boolean;

implementation

var
  hICallInst: THandle;
  
function LoadICallLib: Boolean;
begin
  Result := False;

	hICallInst := LoadLibrary('ICall.dll');
	if hICallInst = 0 then
    Exit;

  GetRealWindow := GetProcAddress(hICallInst, 'GetRealWindow');
	if @GetRealWindow = nil then
		Exit;

	GetWord := GetProcAddress(hICallInst, 'GetWord');
	if @GetWord = nil then
		Exit;

  GetRectWord := GetProcAddress(hICallInst, 'GetRectWord');
	if @GetRectWord = nil then
		Exit;

	SetCapWndWidth := GetProcAddress(hICallInst, 'SetCapWndWidth');
	if @SetCapWndWidth = nil then
    Exit;

	GetWordEnableCap := GetProcAddress(hICallInst, 'GetWordEnableCap');
	if @GetWordEnableCap = nil then
    Exit;

	GetWordIsCapEnable := GetProcAddress(hICallInst, 'GetWordIsCapEnable');
	if @GetWordIsCapEnable = nil then
    Exit;

	SetMouseHook := GetProcAddress(hICallInst, 'SetMouseHook');
	if @SetMouseHook = nil then
    Exit;

	RemoveMouseHook := GetProcAddress(hICallInst, 'RemoveMouseHook');
	if @RemoveMouseHook = nil then
    Exit;

	MouseEnableCap := GetProcAddress(hICallInst, 'MouseEnableCap');
	if @MouseEnableCap = nil then
    Exit;

	MouseSetDelay := GetProcAddress(hICallInst, 'MouseSetDelay');
	if @MouseSetDelay = nil then
    Exit;

  GetHighlightText := GetProcAddress(hICallInst, 'GetHighlightText');
	if @GetHighlightText = nil then
		Exit;

	Result := True;
end;

function FreeICallLib: Boolean;
begin
	if hICallInst <> 0 then
	begin
		FreeLibrary(hICallInst);
		hICallInst := 0;
		Result := True;
	end
  else
    Result := False;
end;

end.
