n := 12345;
m := 0;

while n > 0 do
begin
  r := n mod 10;
  n := n div 10;

  m := m * 10 + r
end;

writeln(m);
