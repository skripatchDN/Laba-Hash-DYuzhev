{
Задача 4b Хеширование
Задан набор записей следующей структуры: табельный номер, ФИО, заработная плата.
По табельному номеру найти остальные сведения.

В папке проекта уже есть файл для тестирования: test.txt
}
unit UInfo;

interface

uses Classes, SysUtils, Grids;

const
  NAMES: array[0..11] of string = ('Волчуков', 'Деркачев', 'Дюжев',
                                    'Зайцев', 'Карташов', 'Кустовинов',
                                    'Лейба', 'Макатовчук', 'Малюгин',
                                    'Микляев', 'Михайлов', 'Наумов');
  SECOND_NAMES: array[0..11] of string = ('Анатолий', 'Антон', 'Борис',
                                    'Виталий', 'Владислав', 'Григорий',
                                    'Егор', 'Иван', 'Никита',
                                    'Николай', 'Олег', 'Петр');
  PATRONYMICS: array[0..11] of string = ('Александрович', 'Алексеевич', 'Анатольевич',
                                    'Андреевич', 'Антонович', 'Аркадьевич',
                                    'Артемович', 'Бедросович', 'Богданович',
                                    'Борисович', 'Валентинович', 'Васильевич');

type
  TKey = integer;
  TInfo = class
    FKey : TKey;         // табельный номер
    FName : string;      // ФИО
    FSalary: integer;    // заработная плата

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

// хэш-функция
class function TInfo.HF(key: TKey): integer;
begin
  Result := key;     // ключом является табельный номер, который обычно уникален
                      // поэтому целесообразно его и использовать в качестве h(k)
end;

// сравнение с ключом k2
function TInfo.IsEqualKey (k2 : TKey) : boolean;
begin
  Result := FKey = k2;
end;

// загрузка инфы из файла
// f - текстовый файл, info - туда кладется считанная запись
// возвращает, удалось ли считать запись
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

// сохранение инфы в файл
// f - текстовый файл, info - запись
procedure TInfo.SaveToFile(var f: TextFile);
begin
  writeln(f, FKey);
  writeln(f, FName);
  writeln(f, FSalary);
  writeln(f);
end;

// добавление инфы в TStrings
procedure TInfo.ShowInfo(Row: TStrings);
begin
  Row.Add(IntToStr(FKey));
  Row.Add(FName);
  Row.Add(IntToStr(FSalary));
end;

// возвращает инфу по данным
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
  SG.Cells[0, 0] := 'Номер в таблице';
  SG.Cells[1, 0] := 'Табельный номер';
  SG.Cells[2, 0] := 'ФИО';
  SG.Cells[3, 0] := 'Зарплата';
end;

end.
