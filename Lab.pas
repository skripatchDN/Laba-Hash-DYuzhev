unit Lab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, StdActns, ToolWin, ActnMan, ActnCtrls,
  XPStyleActnCtrls, ImgList, ExtCtrls, StdCtrls, ComCtrls;

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
    PanelTree: TPanel;
    SplitterMain: TSplitter;
    PanelInformation: TPanel;
    TreeView: TTreeView;
    MemoResult: TMemo;
    N1: TMenuItem;
    N2: TMenuItem;

    procedure act_exitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FIsSaved: boolean;
    FIsFileOpen: boolean;
    FFileName: string;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FIsSaved := true;
  FIsFileOpen := false;
  FFileName := '';
end;

procedure TFormMain.act_exitExecute(Sender: TObject);
begin
  Close;
end;

end.
