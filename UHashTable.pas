unit UHashTable;

interface
uses
  UList, UInfo, Grids, SysUtils;

const
  N = 101;

type
  TIndex = 0..N-1;
  TCell = TList;
  TTable = array[TIndex] of TCell;
  THashFunction = function(key: TKey): integer;

  THashTable = class
  private
    FTable: TTable;
    FCount: integer;
  protected
    function HashF(key: TKey): TIndex;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    function Add(info: TInfo): boolean; virtual;
    function Find(key: TKey; var info: TInfo): boolean;
    function Delete(key: TKey): boolean; virtual;
    function LoadFromFile(FileName: string): boolean;
    procedure AddRandom(n: integer);
    procedure SaveToFile(FileName: string);
    procedure View(SG: TStringGrid);
    property Count: integer read FCount;
  end;
implementation



{ THashTable }

// ���������� � �������, ���������� �������� �� �������
// info - ������ ����������� ����
function THashTable.Add(info: TInfo): boolean;
var
  pos: TIndex;
begin
  pos := HashF(info.key);
  Result := FTable[pos].Add(info);
  if Result then
    inc(Fcount);
end;

// ���������� n ��������� ������� � ������
procedure THashTable.AddRandom(n: integer);
var
  i: integer;
  info: TInfo;
begin
  for i:=1 to n do
    begin
      info := TInfo.Create;
      info.RandomInfo();
      Add(info);
    end;
end;

// ������� �������
procedure THashTable.Clear;
var
  i: integer;
begin
  if FCount > 0 then
    begin
      for i := 0 to N-1 do
      FTable[i].Clear;
      FCount := 0;
    end;
end;

// ����������� �������
constructor THashTable.Create;
var
  i: TIndex;
begin
  inherited Create;
  for i  := 0 to N-1 do
    FTable[i] := TList.Create;
  FCount := 0;
end;

// ������� �������, ���������: ������ ��
function THashTable.Delete(key: TKey): boolean;
begin
  Result := FTable[HashF(key)].Delete(Key);
  if Result then
    dec(FCount);end;

// ���������� �������
destructor THashTable.Destroy;
var
  i: TIndex;
begin
  for i:=0 to N-1 do
    FreeAndNil(FTable[i]);
  inherited;
end;

// ����� ����� key � �������,
// ���� ������ �� ���������� true � � info ���������� ��������
function THashTable.Find(key: TKey; var info: TInfo): boolean;
begin
  Result := FTable[HashF(key)].Find(key, info);
end;

// ���-�������, ���������� ������� �������� � �������
function THashTable.HashF(key: TKey): TIndex;
begin
  Result := TInfo.HF(key) mod N
end;


// ������ ���-������� �� �����, ���������, ������� �� ���������
// FileName - ��� ��������� �����
function THashTable.LoadFromFile(FileName: string): boolean;
var
  f: TextFile;
  info: TInfo;
begin
  Result := true;
  AssignFile(f, FileName);
  Reset(f);
  Clear;
  while (not eof(F) and Result) do
    begin
      info := TInfo.Create;
      if info.LoadFromFile(f) then
        Result := Add(info)
      else
        begin
          Result := false;
          info.Destroy;
        end;
    end;
  CloseFile(f);
end;
// ���������� ������� � ����
// FileName - ��� �����
procedure THashTable.SaveToFile(FileName: string);
var
  i: integer;
  f: TextFile;
begin
  AssignFile(f, FileName);
  Rewrite(f);
  if FCount > 0 then
    for i := 0 to N-1 do
      FTable[i].SaveToFile(f);
  CloseFile(f);
end;

// ����� ������� � StringGrid
procedure THashTable.View(SG: TStringGrid);
var
  i, index: integer;
begin

  with SG do
    for i:=0 to ColCount-1 do
      Cols[i].Clear;
  TInfo.ShowTitle(SG);
  if FCount = 0 then
    begin
      SG.RowCount := 2;
      SG.Rows[1].Clear;
    end
  else
    begin
      index := 0;
      SG.RowCount := FCount + 1;
      for i := 0 to N-1 do
        FTable[i].View(SG, index, i);

    end;
end;
end.
