unit uSomeSameCode;

interface

uses
  uOGLBase, OpenGL, Controls, Classes, Windows;

type
  TGLOrtho = class(TOGLSuperBible)
  public
    LastX, LastY: Integer;
    XRot, YRot, ZRot: GLfloat;
    XMove, YMove, ZMove: GLfloat;
  public
    constructor Create(AHandle: HWND); override;
    procedure ChangedSize(W, H: Integer); override;
    procedure MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
  end;

implementation

{ TGLOrtho }

procedure TGLOrtho.ChangedSize(W, H: Integer);
var
  NRange: GLfloat;
begin
  inherited;
  NRange := 80;
  if H = 0 then
    H := 1;

  glViewport(0, 0, W, H);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();

  if W <= H then
    glOrtho(-NRange, NRange, -NRange * H / W, NRange * H / W, -NRange, NRange)
  else
    glOrtho(-NRange * W / H, NRange * W / H, -NRange, NRange, -NRange, NRange);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
end;

constructor TGLOrtho.Create(AHandle: HWND);
begin
  inherited;
  XRot := 0;
  YRot := 0;
  glEnable(GL_DEPTH_TEST);	// Hidden surface removal
  glEnable(GL_CULL_FACE);		// Do not calculate inside of jet
  glFrontFace(GL_CCW);		// Counter clock-wise polygons face out
  glEnable(GL_DOUBLEBUFFER);
end;

procedure TGLOrtho.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  LastX := X;
  LastY := Y;
end;

procedure TGLOrtho.MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if [ssLeft] = Shift then
  begin
    XRot := XRot + (X - LastX ) mod 50;
    YRot := YRot + (Y - LastY) mod 50;
    Render;
    LastX := X;
    LastY := Y;
  end;
end;

end.
