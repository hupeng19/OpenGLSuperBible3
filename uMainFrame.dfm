object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Form5'
  ClientHeight = 643
  ClientWidth = 605
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 161
    Height = 643
    Align = alLeft
    Indent = 19
    TabOrder = 0
    OnChange = TreeView1Change
  end
  object Panel1: TPanel
    Left = 161
    Top = 0
    Width = 444
    Height = 643
    Align = alClient
    Caption = 'Panel1'
    DoubleBuffered = False
    ParentDoubleBuffered = False
    ShowCaption = False
    TabOrder = 1
    OnMouseDown = Panel1MouseDown
    OnMouseMove = Panel1MouseMove
  end
end
