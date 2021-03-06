{
������ 4b �����������
����� ����� ������� ��������� ���������: ��������� �����, ���, ���������� �����.
�� ���������� ������ ����� ��������� ��������.

� ����� ������� ��� ���� ���� ��� ������������: test.txt
}
unit FormMainLab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, StdActns, ToolWin, ActnMan, ActnCtrls,
  XPStyleActnCtrls, ImgList, ExtCtrls, StdCtrls, ComCtrls, UInfo, UHashTable,
  Grids, UStaticInfo, UFormAdd;

type
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    mi_file: TMenuItem;
    mi_edit: TMenuItem;
    mi_search: TMenuItem;
    mi_task: TMenuItem;
    mi_new: TMenuItem;
    mi_open: TMenuItem;
    mi_save: TMenuItem;
    mi_saveas: TMenuItem;
    mi_close: TMenuItem;
    mi_exit: TMenuItem;
    mi_add: TMenuItem;
    mi_delete: TMenuItem;
    mi_clear: TMenuItem;
    ActionList: TActionList;
    act_new: TAction;
    act_open: TAction;
    act_save: TAction;
    act_saveAs: TAction;
    act_close: TAction;
    act_exit: TAction;
    act_add: TAction;
    act_delete: TAction;
    act_clear: TAction;
    act_search: TAction;
    act_task: TAction;
    ImageList: TImageList;
    ActionManager: TActionManager;
    ActionToolBar: TActionToolBar;
    mi_separator2: TMenuItem;
    mi_separator1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StringGrid: TStringGrid;
    act_addRandom: TAction;
    N1: TMenuItem;

    function TrySaveAndContinue: boolean;
    procedure FormCreate(Sender: TObject);
    procedure act_exitExecute(Sender: TObject);
    procedure act_openExecute(Sender: TObject);
    procedure act_saveExecute(Sender: TObject);
    procedure act_saveAsExecute(Sender: TObject);
    procedure act_newExecute(Sender: TObject);
    procedure act_closeExecute(Sender: TObject);
    procedure act_addExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure act_clearExecute(Sender: TObject);
    procedure act_searchExecute(Sender: TObject);
    procedure act_deleteExecute(Sender: TObject);
    procedure act_taskExecute(Sender: TObject);
    procedure act_addRandomExecute(Sender: TObject);

  protected
    procedure SetIsSaved(value: boolean);
    procedure SetIsFileOpen(value: boolean);

  private
    FIsSaved: boolean;
    FIsFileOpen: boolean;
    FFileName: string;
    FTable: THashTable;

  public
    property IsSaved: boolean read FIsSaved write SetIsSaved;
    property IsFileOpen: boolean read FIsFileOpen write SetIsFileOpen;
  end;


const
  DEFAULT_FILENAME = '����������.txt';

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

// ������ ��� ��������� IsSaved
procedure TFormMain.SetIsSaved(value: boolean);
begin
  FIsSaved := value;
  act_save.Enabled := not value;
end;

// ������ ��� ��������� IsFileOpen, ������������� ����������� �����
procedure TFormMain.SetIsFileOpen(value: boolean);
begin
  FIsFileOpen := value;
  act_save.Enabled := value;
  act_saveAs.Enabled := value;
  act_close.Enabled := value;
  act_add.Enabled := value;
  act_addRandom.Enabled := value;
  act_delete.Enabled := value;
  act_clear.Enabled := value;
  act_search.Enabled := value;
  act_task.Enabled := value;
end;

{
���������, �������� �� ����, ����� ���������� �������� (������� ����� ����,
������� ��������� � �.�.). ���� ���� �� �������� � ������������ ����� �������
��� ������, �� FALSE. ���� ���� ��� ��������/������������ �� ������� ���������/
���� ����������, �� TRUE
}
function TFormMain.TrySaveAndContinue: boolean;
var
  responce: integer;
begin
  if IsSaved then
    Result := true
  else
    begin
      Result := false;
      responce := MessageDlg('�� ������ ��������� ���������?',
                              mtConfirmation,
                              mbYesNoCancel,
                              0);
      case responce of
        mrNo:
          Result := true;
        mrYes:
          if SaveDialog.Execute then
            begin
              FFileName := SaveDialog.FileName;
              FTable.SaveToFile(FFileName);
              Result := true;
            end
      end;
    end;
end;

// ������������� �����
procedure TFormMain.FormCreate(Sender: TObject);
begin
  IsFileOpen := false;
  IsSaved := true;
  FFileName := DEFAULT_FILENAME;
  FTable := THashTable.Create;
end;

// ����� �� ���������
procedure TFormMain.act_exitExecute(Sender: TObject);
begin
  Close;
end;

// ������� ����
procedure TFormMain.act_openExecute(Sender: TObject);
begin
  if TrySaveAndContinue and OpenDialog.Execute then
    begin
      FFileName := OpenDialog.FileName;
      FTable.LoadFromFile(FFileName);
      FTable.View(StringGrid);
      IsFileOpen := true;
      IsSaved := true;
    end;

end;

// ���������
procedure TFormMain.act_saveExecute(Sender: TObject);
begin
  FTable.SaveToFile(FFileName);
  IsSaved := true;
end;

// ��������� ���...
procedure TFormMain.act_saveAsExecute(Sender: TObject);
begin
  if SaveDialog.Execute then
    begin
      FFileName := SaveDialog.FileName;
      FTable.SaveToFile(FFileName);
      IsSaved := true;
    end;
end;

// ������� ����� ����
procedure TFormMain.act_newExecute(Sender: TObject);
begin
  if TrySaveAndContinue then
    begin
      FFileName := DEFAULT_FILENAME;
      FTable.Clear;
      FTable.View(StringGrid);
      IsFileOpen := true;
      IsSaved := true;
    end;
end;

// ������� ����
procedure TFormMain.act_closeExecute(Sender: TObject);
begin
  if TrySaveAndContinue then
    begin
      FFileName := DEFAULT_FILENAME;
      FTable.Clear;
      FTable.View(StringGrid);
      IsFileOpen := false;
      IsSaved := true;
    end;
end;

// ���������� ������ � ���-�������
procedure TFormMain.act_addExecute(Sender: TObject);
begin

  UFormAdd.FormAddInfo.ShowModal;

  if UStaticInfo.IsValid then
    begin
      if not FTable.Add(UStaticInfo.info) then
        ShowMessage('������ �� ���������')
      else
        begin
          FTable.View(StringGrid);
          IsSaved := false;
        end;
    end;
end;

// ��� �������� �����
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if TrySaveAndContinue then
    begin
      FTable.Clear;
    end
  else
    Action := caNone
end;

// �������� �������
procedure TFormMain.act_clearExecute(Sender: TObject);
var
  responce: integer;
begin
  responce := MessageDlg('�������� �������?',
                              mtConfirmation,
                              mbYesNoCancel,
                              0);
  if responce = mrYes then
    begin
      FTable.Clear;
      FTable.View(StringGrid);
      IsSaved := false;
    end;
end;

// ����� �����
procedure TFormMain.act_searchExecute(Sender: TObject);
var
  key: TKey;
  info: TInfo;
begin
  key := StrToInt(InputBox('����� ������',
                            '������� ��������� �����', ''));
  if not FTable.Find(key, info) then
    ShowMessage('������ �� �������')
  else
    ShowMessage('��������� �����: ' + IntToStr(info.key) + #13#10 +
                '���: ' + info.name + #13#10 +
                '���������� �����: ' + IntToStr(info.salary));

end;

// �������� �����
procedure TFormMain.act_deleteExecute(Sender: TObject);
var
  key: integer;
begin
  key := StrToInt(InputBox('�������� ������',
                  '������� ��������� ����� ������, ������� ������ �������', ''));
  if FTable.Delete(key) then
    begin
      FTable.View(StringGrid);
      IsSaved := false;
      ShowMessage('������ �������');
    end
  else
    ShowMessage('������ �� �������')
end;

// �������� ������
procedure TFormMain.act_taskExecute(Sender: TObject);
begin
  act_searchExecute(Sender);
end;


procedure TFormMain.act_addRandomExecute(Sender: TObject);
var
  n: integer;
  tmp: string;
begin
  tmp := InputBox('�������� ��������� ������',
                  '������� ���������� �������, ������� ������ ��������', '');


  if (tmp <> '') then
    begin
      n := StrToInt(tmp);
      if n > 0 then
        begin
          FTable.AddRandom(n);
          FTable.View(StringGrid);
        end;
    end;
end;

end.
