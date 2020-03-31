{
������ 4b �����������
����� ����� ������� ��������� ���������: ��������� �����, ���, ���������� �����.
�� ���������� ������ ����� ��������� ��������.

� ����� ������� ��� ���� ���� ��� ������������: test.txt
}
unit UInfo;

interface

uses Classes, SysUtils, Grids;

const
  NAMES: array[0..11] of string = ('��������', '��������', '�����',
                                    '������', '��������', '����������',
                                    '�����', '����������', '�������',
                                    '�������', '��������', '������');
  SECOND_NAMES: array[0..11] of string = ('��������', '�����', '�����',
                                    '�������', '���������', '��������',
                                    '����', '����', '������',
                                    '�������', '����', '����');
  PATRONYMICS: array[0..11] of string = ('�������������', '����������', '�����������',
                                    '���������', '���������', '����������',
                                    '���������', '����������', '����������',
                                    '���������', '������������', '����������');

type
  TKey = integer;
  TInfo = class
    FKey : TKey;         // ��������� �����
    FName : string;      // ���
    FSalary: integer;    // ���������� �����

    class function HF(key: TKey): integer;
    function IsEqualKey (k2 : TKey) : boolean;
    procedure SaveToFile(var f : TextFile);
    function LoadFromFile(var f : TextFile) : boolean;
    class procedure ShowTitle(SG: TStringGrid);
    procedure ShowInfo(Row : TStrings);
    constructor Create(key: TKey = 0; name: string = 'a'; salary: integer = 0);
    destructor Destroy(); override;
    procedure RandomInfo;

    property Key: TKey read FKey write FKey;
    property Name: string read FName write FName;
    property Salary: integer read FSalary write FSalary;

  end;



implementation

// ���-�������
class function TInfo.HF(key: TKey): integer;
begin
  Result := key;     // ������ �������� ��������� �����, ������� ������ ��������
                      // ������� ������������� ��� � ������������ � �������� h(k)
end;

// ��������� � ������ k2
function TInfo.IsEqualKey (k2 : TKey) : boolean;
begin
  Result := FKey = k2;
end;

// �������� ���� �� �����
// f - ��������� ����, info - ���� �������� ��������� ������
// ����������, ������� �� ������� ������
function TInfo.LoadFromFile(var f: TextFile): boolean;
var
  tmp: string;
begin
  Result := not eof(f);
  if Result then
    begin
      readln(f, tmp);
      while (tmp = '') and not eof(f) do
        readln(f, tmp);
      Result := TryStrToInt(tmp, FKey) and
                (FKey >= 0) and
                not eof(f);
      if Result then
        begin
          readln(f, FName);
          Result := (FName <> '') and not eof(f);
          if Result then
            begin
              readln(f, tmp);
              Result := (tmp <> '') and
              TryStrToInt(tmp, FSalary) and
              (FSalary >= 0);
            end;
        end;
    end;
end;

// ���������� ���� � ����
// f - ��������� ����, info - ������
procedure TInfo.SaveToFile(var f: TextFile);
begin
  writeln(f, FKey);
  writeln(f, FName);
  writeln(f, FSalary);
  writeln(f);
end;

// ���������� ���� � TStrings
procedure TInfo.ShowInfo(Row: TStrings);
begin
  Row.Add(IntToStr(FKey));
  Row.Add(FName);
  Row.Add(IntToStr(FSalary));
end;

// ���������� ���� �� ������
constructor TInfo.Create(key: TKey = 0; name: string = 'a'; salary: integer = 0);
begin
  inherited Create;
  FKey := key;
  FName := name;
  FSalary := salary;
end;

procedure TInfo.RandomInfo;
begin
  randomize();
  FKey := random(1000) + 1;
  FName := NAMES[random(12)] + ' ' +
                SECOND_NAMES[random(12)] + ' ' +
                PATRONYMICS[random(12)];
  FSalary := (random(30) + 3) * 5000;

end;

destructor TInfo.Destroy;
begin
  inherited;
end;

class procedure TInfo.ShowTitle(SG: TStringGrid);
var
  i: integer;
begin
  SG.Cells[0, 0] := '����� � �������';
  SG.Cells[1, 0] := '��������� �����';
  SG.Cells[2, 0] := '���';
  SG.Cells[3, 0] := '��������';
end;

end.
