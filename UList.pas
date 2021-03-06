unit UList;

interface

uses UInfo, Grids, SysUtils;

type
  TPointer = ^TNode;
  TNode = record
    info: TInfo;
    next: TPointer;
  end;

  TList = class
    private
      FHead: TPointer;
    protected
      function AddNode(var p: TPointer; inf: TInfo): TPointer;
      procedure DelNode(var p: TPointer);
      function GetNode(key: TKey; var p: TPointer): TPointer;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Clear;
      function Add(inf: TInfo): boolean;
      function Find(key: TKey; var inf: TInfo): boolean;
      function Delete(key: TKey): boolean;
      procedure SaveToFile(var f: TextFile);
      procedure View(SG: TStringGrid; var index: integer; i: integer);
  end;

implementation


{ TList }

// ���������� �������� � ������
// ����������, �������� �� �������
function TList.Add(inf: TInfo): boolean;
var
  t, p: TPointer;
begin
  t := GetNode(inf.key, p);
  Result := t = nil;
  if Result then
    if FHead = nil then
      AddNode(FHead, inf)
    else
      AddNode(p.next, inf);
end;

// ���������� ���� ����� p
// ���������� ��������� �� ��������� ����
// p ����� ���������� ������� ��������� �� ����������� ���� ��� ��������
function TList.AddNode(var p: TPointer; inf: TInfo): TPointer;
begin
  new(result);
  result.info := inf;
  result.next := p;
  p := result;
end;

// ������� ������
procedure TList.Clear;
begin
  while FHead <> nil do
    DelNode(FHead)
end;

// �������� ������
constructor TList.Create;
begin
  FHead := nil;
end;

// �������� ����� �� ������
// ����������, ������ �� ����
function TList.Delete(key: TKey): boolean;
var
  t, p: TPointer;
begin
  t := GetNode(key, p);
  Result := t <> nil;
  if Result then
    if p = nil then
      DelNode(FHead)
    else
      DelNode(p.next);
end;

// ������� ���� ������
procedure TList.DelNode(var p: TPointer);
var t: TPointer;
begin
  t:= p;
  p:= p.Next;
  t.info.Destroy;
  dispose(t);
end;

// ����������� ������
destructor TList.Destroy;
begin
  Clear;
  inherited;
end;

// ����� �����
// ���� ������, ���������� true � ������ ���� � inf
function TList.Find(key: TKey; var inf: TInfo): boolean;
var
  t, p: TPointer;
begin
  t := GetNode(key, p);
  result := t <> nil;
  if result then
    inf := t.info;
end;

// ���������� ���� �� �����, p - ���������� ���� ������,
// ����������� �� ���� � ������
function TList.GetNode(key: TKey; var p: TPointer): TPointer;
var
  ok: boolean;
begin
  p := nil;
  Result := FHead;
  ok := false;
  while (Result <> nil) and (not ok) do
    if Result.info.IsEqualKey(key) then
      ok := true
    else
      begin
        p := Result;
        Result := Result.next;
      end;
end;

// ���������� ������ � ����
procedure TList.SaveToFile(var f: TextFile);
var
  t: TPointer;
begin
  t := FHead;
  while t <> nil do
    begin
      t.info.SaveToFile(f);
      t := t.next;
    end;
end;

// ����� ������ � TStringGrid
procedure TList.View(SG: TStringGrid; var index: integer; i: integer);
var
  t: TPointer;
begin
  t:= FHead;
  if t <> nil then
    begin
      inc(index);
      SG.Rows[index].Add(IntToStr(i));
      t.info.ShowInfo(SG.Rows[index]);
      t:= t^.next;

    end;
  while t <> nil do
    begin
      inc(index);
      SG.Rows[index].Add('');
      t.info.ShowInfo(SG.Rows[index]);
      t:= t^.next;
    end;
end;

end.
