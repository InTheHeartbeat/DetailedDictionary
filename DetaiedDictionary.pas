program DetailedDictionary;

var words            : array[0..100] of string;
    wordsLength      : integer;

    endings          : array[0..2]   of string;
    endingsLength    : integer;
    
procedure InitializeEndings();
begin
  endings[0] := 'ed';
  endings[1] := 'es';
  endings[2] := 's';
end;

procedure Initialize();
begin
  InitializeEndings();
end;

begin
  Initialize();
end.

