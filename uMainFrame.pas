 unit uMainFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uOGLBase, ComCtrls, ExtCtrls;

type
  TForm5 = class(TForm)
    TreeView1: TTreeView;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    Fnewdemo: TOGLSuperBible;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.FormCreate(Sender: TObject);
var
  I, J: Integer;
  NewNode: TTreeNode;
  Path, Entry: String;
  ParentNode: TTreeNode;

  function FindNode(const ParentNode: TTreeNode; const Text: String): TTreeNode;
  var
    I: Integer;
  begin
    if Assigned(ParentNode) then
    begin
      for I := 0 to ParentNode.Count - 1 do
      begin
        Result := ParentNode[I];
        if SameText(Result.Text, Text) then
          Exit;
      end;
    end
    else
    begin
      for I := 0 to TreeView1.Items.Count - 1 do
      begin
        Result := TreeView1.Items[I];
        if SameText(Result.Text, Text) then
          Exit;
      end;
    end;
    Result := nil;
  end;

begin
  TreeView1.Items.BeginUpdate;
  TreeView1.Items.Clear;
  for I := 0 to RegisterClasses.Count - 1 do
  begin
    Path := RegisterClasses[I];
    ParentNode := nil;
    while True do
    begin
      J := Pos('\', Path);
      if (J = 0) then
        Break;
      Entry := Copy(Path,1, J - 1);
      NewNode := FindNode(ParentNode, Entry);
      if (NewNode = nil) then
        NewNode := TreeView1.Items.AddChild(ParentNode, Entry);
      ParentNode := NewNode;
      Delete(Path, 1, J);
    end;
    NewNode := TreeView1.Items.AddChild(ParentNode, Path);
    NewNode.Data := RegisterClasses.Objects[I];
  end;
  TreeView1.Items.EndUpdate;
end;

procedure TForm5.FormPaint(Sender: TObject);
begin
  if Assigned(Fnewdemo) then
    Fnewdemo.Render;
end;

procedure TForm5.FormResize(Sender: TObject);
begin
  if Assigned(Fnewdemo) then
    Fnewdemo.ChangedSize(Panel1.Width, Panel1.Height);
end;

procedure TForm5.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Assigned(Fnewdemo) then
    Fnewdemo.MouseDown(Sender, Button, Shift, X, Y);
end;

procedure TForm5.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(Fnewdemo) then
    Fnewdemo.MouseMove(Sender, Shift, X, Y);
end;

procedure TForm5.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  DemoClass: TOGLClass;
begin
  if Assigned(Node) then
  begin
    DemoClass := node.Data;
    if Assigned(DemoClass) then
    begin
      if Assigned(Fnewdemo) then
        FreeAndNil(Fnewdemo);
      Fnewdemo := DemoClass.Create(Panel1.Handle);
      Caption := Fnewdemo.ClassName;
      Fnewdemo.ChangedSize(Panel1.Width, Panel1.Height);
      Invalidate;
    end;
  end;
end;

end.
