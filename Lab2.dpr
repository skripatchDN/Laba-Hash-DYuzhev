{
Задача 4b Хеширование
Задан набор записей следующей структуры: табельный номер, ФИО, заработная плата.
По табельному номеру найти остальные сведения.

В папке проекта уже есть файл для тестирования: test.txt
}
program Lab2;

uses
  Forms,
  FormMainLab in 'FormMainLab.pas' {FormMain},
  UInfo in 'UInfo.pas',
  UList in 'UList.pas',
  UHashTable in 'UHashTable.pas',
  UFormAdd in 'UFormAdd.pas' {FormAddInfo},
  UStaticInfo in 'UStaticInfo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAddInfo, FormAddInfo);
  Application.Run;
end.
