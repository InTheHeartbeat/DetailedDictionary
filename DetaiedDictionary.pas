program DetailedDictionary;

  var words            : array of string;
      wordBases        : array of string;
      wordTypes        : array of string;
      wordPrepos       : array of string;
      wordSingleVocal  : array of char;    
      wordPluralVocal  : array of char;    
      
      vocals           : array of char;
      separators       : array of char;
   

procedure PrintCharArray(var arr: array of char);
  var i : integer;
begin
    for i := 0 to arr.Length - 1 do
        Writeln(arr[i]);
end;

procedure PrintStringArray(var arr: array of string);
  var i : integer;
begin
    for i := 0 to arr.Length - 1 do
        Writeln(arr[i]);
end;


procedure AddCharToArray(var arr: array of char; ch: char);
begin
    SetLength(arr, arr.Length + 1);
    arr[arr.Length - 1] := ch;
end;


procedure AddStringToArray(var arr: array of string; str: string);
begin
    SetLength(arr, arr.Length + 1);
    arr[arr.Length - 1] := str;
end;


function CharArrayContains(var arr: array of char; c: char) : boolean;
  var i : integer;
begin
    for i := 0 to arr.Length - 1 do
    begin
        if arr[i] = c then
        begin
            CharArrayContains := true;
            Break;
        end;
    end;
end;


function StringArrayContains(var arr: array of string; str: string) : boolean;
  var i : integer;
begin
    for i := 0 to arr.Length - 1 do
    begin
        if CompareStr(arr[i], str) = 0 then
        begin
            StringArrayContains := true;
            Break;
        end;
    end;
end;
   
   
function IsVocal(c: char) :  boolean;
begin
    IsVocal := CharArrayContains(vocals, c);
end;
   
   
function LastCharOf(str: string) : char;
begin
    if str.Length <> 0 then
        LastCharOf := str[str.Length];
end;
   
   
procedure InitializeVocals();
begin
    SetLength(vocals, 0);
    AddCharToArray(vocals, 'à');
    AddCharToArray(vocals, 'ó');
    AddCharToArray(vocals, 'û');
    AddCharToArray(vocals, 'å');
end;

procedure InitializeSeparators();
begin
    SetLength(separators, 0);
    AddCharToArray(separators, ',');
    AddCharToArray(separators, '.');
    AddCharToArray(separators, '!');
    AddCharToArray(separators, '?');
    AddCharToArray(separators, '/');
    AddCharToArray(separators, ':');
    AddCharToArray(separators, ';');
    AddCharToArray(separators, ' ');
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
    InitializeSeparators();
    InitializeStorage();
end;


function IsSeparator(ch: char) : boolean;
  var i : integer;
begin
    IsSeparator := false;
    for i := 0 to separators.Length - 1 do
    begin
        if separators[i] = ch then 
        begin
            IsSeparator := true;
            Break;
        end;
    end;    
end;


function WordIsMeaningful(currentWord : string) : boolean;
  var i : integer;
begin
    WordIsMeaningful := true;    
    for i := 1 to currentWord.Length do
    begin 
        if IsSeparator(currentWord[i]) then
        begin
            WordIsMeaningful := false;
            break;
        end;
    end;
end;


function DetectWordBase(currentWord: string) : string;
  var wordBase : string;
begin
    wordBase := currentWord;

    if IsVocal(LastCharOf(currentWord)) then
    begin
        wordBase := Copy(currentWord, 1, currentWord.Length - 1);
    end;
    
    DetectWordBase := wordBase;
end;


procedure NormalizeAndFlushWord(currentWord: string);
  var wordBase : string;
begin
    wordBase := DetectWordBase(currentWord);
    if not StringArrayContains(wordBases, wordBase) then
    begin
        AddStringToArray(wordBases, wordBase);
    end;
end;


procedure ParseStringToWords(data: string);
  var currentWord  : string;
      currentChar  : char;
      dataPosition : integer;
begin
    currentWord := '';
    currentChar := ' ';
    
    for dataPosition := 1 to data.Length do
    begin
        currentChar := data[dataPosition];
    
        if IsSeparator(currentChar) then
        begin
            if WordIsMeaningful(currentWord) then
                NormalizeAndFlushWord(currentWord);
                
            currentWord := '';
        end
        else
        begin
            currentWord := Concat(currentWord, currentChar);
        end;
    end;
    
    if WordIsMeaningful(currentWord) then
        NormalizeAndFlushWord(currentWord);
end;


procedure ParseUserInputToWords();
  var inputString : string;
begin
    Writeln('Please, type the text to parse:');  
    Readln(inputString);
    ParseStringToWords(inputString);
end;


//Main module
begin
    Initialize();
    ParseUserInputToWords();
    PrintStringArray(wordBases);
end.

