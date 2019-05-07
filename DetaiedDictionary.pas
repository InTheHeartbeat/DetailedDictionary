program DetailedDictionary;

var words            : array of string;
    wordBases        : array of string;
    wordTypes        : array of string;
    wordPrepos       : array of string;
    endings          : array of string;
    vocals           : array of char;
   
procedure PrintArray(arr: array of char);
var i : integer;
begin
    for i := 0 to arr.Length - 1 do
      Writeln(arr[i]);
end;

procedure AddCharToArray(ch: char);
begin
    SetLength(vocals, vocals.Length + 1);
    vocals[vocals.Length - 1] := ch;
end;
   
procedure InitializeVocals();
begin
    SetLength(vocals, 0);
    AddCharToArray('à');
    AddCharToArray('ó');
    AddCharToArray('û');
    AddCharToArray('å');
end;
   
procedure InitializeEndings();
begin
    SetLength(endings, 0);
end;

procedure InitializeStorage();
begin
    SetLength(words, 0);
    SetLength(wordBases, 0);
    SetLength(wordTypes, 0);
    SetLength(wordPrepos, 0);
end;

procedure Initialize();
begin
  InitializeVocals();
  InitializeEndings();
  InitializeStorage();
end;

begin
  Initialize();
end.

