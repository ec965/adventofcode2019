program Day1;

uses sysutils;

var 
  f: text;
  line: string;
  nLine: LongInt;
  total: LongInt;

begin
  total := 0;
  assign(f, './inputs/day1.txt');
  reset(f);
  while not eof(f) do
  begin
    readln(f, line);
    nLine := (StrToInt(line) div 3)  - 2;
    total += nLine;
  end;

  writeln(total);
end.
