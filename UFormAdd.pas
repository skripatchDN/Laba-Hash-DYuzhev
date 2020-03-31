unit UFormAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UStaticInfo, UInfo;

type
  TFormAddInfo = class(TForm)
    LabeledEditKey: TLabeledEdit;
    LabeledEditName: TLabeledEdit;
    LabeledEditSalary: TLabeledEdit;
    ButtonAdd: TButton;
    ButtonCancel: TButton;
    procedure ButtonAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAddInfo: TFormAddInfo;

implementation

{$R *.dfm}

procedure TFormAddInfo.ButtonAddClick(Sender: TObject);
var
  info: TInfo;
  tmpKey, tmpSalary: integer;
  tmpName, tmp: string;
begin
  UStaticInfo.IsValid := TryStrToInt(LabeledEditKey.Text, tmpKey) and (tmpKey >= 0);
  if UStaticInfo.IsValid then
    begin
      tmpName := LabeledEditName.Text;
      UStaticInfo.IsValid := (tmpName <> '');
      if UStaticInfo.IsValid then
        begin
          tmp := LabeledEditSalary.Text;
          UStaticInfo.IsValid := (tmp <> '') and
                        TryStrToInt(tmp, tmpSalary) and
                        (tmpSalary >= 0);
        end;
    end;
  if not UStaticInfo.IsValid then
    ShowMessage('¬ведено некорректное значение')
  else
    begin
      info := TInfo.Create();
      info.Key := tmpKey;
      info.Name := tmpName;
      info.Salary := tmpSalary;
      UStaticInfo.info := info;
      isValid := true;
      Close;
    end;
end;

procedure TFormAddInfo.FormCreate(Sender: TObject);
begin
  FreeAndNil(UStaticInfo.info);
  UStaticInfo.info := TInfo.Create();
  isValid := false;
end;

procedure TFormAddInfo.ButtonCancelClick(Sender: TObject);
begin
  isValid := false;
  Close;
end;

procedure TFormAddInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LabeledEditKey.Text := '';
  LabeledEditName.Text := '';
  LabeledEditSalary.Text := '';
end;

end.
