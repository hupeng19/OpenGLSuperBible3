unit uOGLBase;

interface

uses
  Classes, SysUtils, OpenGL, Windows, Controls;

type

  TOGLSuperBible = class abstract
  strict private
    FHandle: HWND;
    FDC: HDC;
    FRC: HGLRC;
  public
    constructor Create(AHandle: HWND); virtual;
    destructor Destroy; virtual;
    /// <summary>渲染函数</summary>
    procedure Render; virtual;
    procedure SetRC; virtual;
    procedure ChangedSize(W, H: Integer); virtual;
    procedure MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer); virtual;
    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;

    public
    property Handle: HWND read FHandle;
  end;
  TOGLClass = class of TOGLSuperBible;

  /// <summary> 将新的绘制类添加到列表中</summary>
  procedure RegistDemo(const Path: string; const DemoClass: TOGLClass);
  function RegisterClasses: TStringList;

implementation

var
  GlobalRegisterDemos: TStringList = nil;

procedure RegistDemo(const Path: string; const DemoClass: TOGLClass);
begin
  GlobalRegisterDemos.AddObject(Path, Pointer(DemoClass));
end;

function RegisterClasses: TStringList;
begin
  Result := GlobalRegisterDemos;
end;

{ TOGLSuperBible }

procedure TOGLSuperBible.ChangedSize(W, H: Integer);
begin

end;

constructor TOGLSuperBible.Create(AHandle: HWND);
var
  pfd: TPIXELFORMATDESCRIPTOR;
  pixelFormat: Integer;
begin
  Fhandle := AHandle;
  FDC := GetDC(AHandle);
  inherited Create;
  With pfd do
  begin
    nSize := sizeof(TPIXELFORMATDESCRIPTOR); // size
    nVersion := 1; // version
    dwFlags := PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or PFD_DOUBLEBUFFER or PFD_STEREO_DONTCARE;
    // support double-buffering
    iPixelType := PFD_TYPE_RGBA; // color type
    cColorBits := 24; // preferred color depth
    cRedBits := 0;
    cRedShift := 0; // color bits (ignored)
    cGreenBits := 0;
    cGreenShift := 0;
    cBlueBits := 0;
    cBlueShift := 0;
    cAlphaBits := 0;
    cAlphaShift := 0; // no alpha buffer
    cAccumBits := 0;
    cAccumRedBits := 0; // no accumulation buffer,
    cAccumGreenBits := 0; // accum bits (ignored)
    cAccumBlueBits := 0;
    cAccumAlphaBits := 0;
    cDepthBits := 16; // depth buffer
    cStencilBits := 0; // no stencil buffer
    cAuxBuffers := 0; // no auxiliary buffers
    iLayerType := PFD_MAIN_PLANE; // main layer
    bReserved := 0;
    dwLayerMask := 0;
    dwVisibleMask := 0;
    dwDamageMask := 0;
  end;
  pixelFormat := ChoosePixelFormat(FDC, @pfd);
  if pixelFormat = 0 then
    Exit;
  if not SetPixelFormat(FDC, pixelFormat, @pfd) then
    Exit;
  FRC := wglCreateContext(FDC);
  wglMakeCurrent(FDC, FRC);
end;

destructor TOGLSuperBible.Destroy;
begin
  wglMakeCurrent(FDC, FRC);
  wglDeleteContext(FRC);
  ReleaseDC(FHandle, FDC);
end;

procedure TOGLSuperBible.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin

end;

procedure TOGLSuperBible.MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TOGLSuperBible.Render;
begin
  glFlush;
  SwapBuffers(FDC); // 交换双缓冲区内容，这将把刚绘制的图形翻印到屏幕上。
end;

procedure TOGLSuperBible.SetRC;
begin

end;

initialization
  GlobalRegisterDemos := TStringList.Create;

finalization
  FreeAndNil(GlobalNameSpace);

end.
