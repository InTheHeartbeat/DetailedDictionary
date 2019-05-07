program DetailedDictionary;

  var words            : array of string;
      wordBases        : array of string;
      wordTypes        : array of string;
      wordPrepos       : array of string;  
      
      vocals           : array of char;
      separators       : array of char;
   

procedure PrintCharArray(var arr: array of char);
begin
    for i : integer := 0 to arr.Length - 1 do
        Writeln(arr[i]);
end;

procedure PrintStringArray(var arr: array of string);
begin
    for i : integer := 0 to arr.Length - 1 do
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
begin
    for i : integer := 0 to arr.Length - 1 do
    begin
        if arr[i] = c then
        begin
            CharArrayContains := true;
            Break;
        end;
    end;
end;


function StringArrayContains(var arr: array of string; str: string) : boolean;
begin
    for i : integer := 0 to arr.Length - 1 do
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
  var cx : integer;  
begin
    cx := Ord(ch);
    IsSeparator := true;
    IsSeparator := not (((cx >= 65) and (cx <= 90)) or ((cx >= 97) and (cx <= 122)) or ((cx >= 912) and (cx <= 1135)));
end;


function WordIsMeaningful(currentWord : string) : boolean;
begin
    WordIsMeaningful := false;    
    for i : integer := 1 to currentWord.Length do
    begin 
        if not IsSeparator(currentWord[i]) then
        begin
            WordIsMeaningful := true;
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
        AddStringToArray(words, currentWord);
        AddStringToArray(wordBases, wordBase);
    end;
end;


procedure ParseStringToWords(data: string);
  var currentWord  : string;
      currentChar  : char;
begin
    if not WordIsMeaningful(data) then
      exit;

    currentWord := '';
    currentChar := ' ';
    
    for dataPosition : integer := 1 to data.Length do
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


procedure RequestFirstUnknownWordInfo();
  var unknownWordIndex : integer;  
      unknownWordBase : string;
      unknownWordContext : string;
      unknownWordType : string;
      unknownWordPrepositions : string;
begin
    unknownWordIndex := wordTypes.Length;
    unknownWordBase := wordBases[unknownWordIndex];
    unknownWordContext := words[unknownWordIndex];
    
    Writeln();
    Writeln('The word base "', unknownWordBase, '" found in context of "', unknownWordContext, '".');
    Write('Enter the base word construction (single, named): ');
    Readln(unknownWordContext); 
    Writeln();
    Write('Enter the word type: ');
    Readln(unknownWordType);
    Writeln();
    Write('Enter all the prepositions splitted with space: ');
    Readln(unknownWordPrepositions);
    Writeln();
    
    words[unknownWordIndex] := unknownWordContext;
    AddStringToArray(wordTypes, unknownWordType);
    AddStringToArray(wordPrepos, unknownWordPrepositions);
    
    Writeln('Record completed');
    Writeln();
end;


procedure RequestUnknownWordsInfo();
begin
    while wordBases.Length > wordTypes.Length do
    begin
        RequestFirstUnknownWordInfo();
    end;
    Writeln('Currently, all the words are recorded');
end;


procedure FillDictionary();
begin
    ParseUserInputToWords();
    RequestUnknownWordsInfo();
end;


function GetUserSelection(): char;
  var selection: char;
begin
    Writeln();
    Writeln('Main menu');
    Writeln('1 - Enter and parse text');
    Writeln('2 - Search');
    Writeln('3 - Print entire dictionary');
    Writeln('Any other key - exit');
    Write('Select option: ');
    Readln(selection);
    Writeln(selection);
    Writeln();

    if (selection = '1') or (selection = '2') or (selection = '3') then
    begin
        GetUserSelection := selection;
    end
    else
        GetUserSelection := '-';
end;

procedure PrintWordWithDetailsByIndex(index: integer);
begin
    Writeln(index, ': "', words[index], '" , base "', wordBases[index], '", type of ,', wordTypes[index], ', prepositions list: ', wordPrepos[index]);
    Writeln();
end;

procedure PrintEntireDictionary();
begin
    for i : integer := 0 to words.Length - 1 do
        PrintWordWithDetailsByIndex(i);
end;

procedure FindUserWord();
begin

end;

procedure UserMenu();
  var selection : char;
begin  
    selection := '-';
    repeat   
        selection := GetUserSelection();
        if selection = '1' then
        begin
          FillDictionary();
        end
        else if selection = '2' then
        begin
          FindUserWord();
        end
        else if selection = '3' then
        begin
          PrintEntireDictionary();
        end
        else
          Break;
    until selection = '-';
    
    Writeln('User exit: program terminated.');
end;

//Main module
begin
    Initialize();
    UserMenu();
end.

