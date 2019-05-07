program DetailedDictionary;

  var words            : array of string;
      wordBases        : array of string;
      wordTypes        : array of string;
      wordPrepos       : array of string;
      wordSingleVocal  : array of char;    
      wordPluralVocal  : array of char;    
      
      vocals           : array of char;
      separators       : array of char;
   

procedure PrintArray(arr: array of char);
  var i : integer;
begin
    for i := 0 to arr.Length - 1 do
        Writeln(arr[i]);
end;


procedure AddCharToArray(arr: array of char; ch: char);
begin
    SetLength(arr, arr.Length + 1);
    arr[arr.Length - 1] := ch;
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
    InitializeStorage();
end;


function IsSeparator(ch: char) : boolean;
  var i : integer;
begin
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
    for i := 0 to currentWord.Length - 1 do
    begin 
        if not IsSeparator(currentWord[i]) then
        begin
            WordIsMeaningful := true;
        end;
    end;
end;


procedure NormalizeAndFlushWord(currentWord: string);
begin

end;


procedure ParseStringToWords(data: string);
  var currentWord  : string;
      currentChar  : char;
      dataPosition : integer;
begin
    currentWord := '';
    currentChar := ' ';
    
    for dataPosition := 0 to data.Length - 1 do
    begin
        currentChar := data[dataPosition];
    
        if IsSeparator(currentChar) and WordIsMeaningful(currentWord) then
        begin
            NormalizeAndFlushWord(currentWord);
        end
        else
        begin
            currentWord := Concat(currentWord, currentChar);
        end;
    end
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
end.

