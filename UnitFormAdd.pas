unit UnitFormAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormAddInfo = class(TForm)
    LabeledEditKey: TLabeledEdit;
    LabeledEditName: TLabeledEdit;
    LabeledEditSalary: TLabeledEdit;
    ButtonAdd: TButton;
    ButtonCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAddInfo: TFormAddInfo;

implementation

{$R *.dfm}

end.
