{
������ 4b �����������
����� ����� ������� ��������� ���������: ��������� �����, ���, ���������� �����.
�� ���������� ������ ����� ��������� ��������.

� ����� ������� ��� ���� ���� ��� ������������: test.txt
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
