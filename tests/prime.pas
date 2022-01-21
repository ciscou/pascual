m := 100;
n := 0;

while not n > m do
begin
  p := 1;
  i := 2;

  while p = 1 and not (i > n / 2) do
  begin
    if n mod i = 0 then
      p := 0
    else
    begin end;

    i := i + 1
  end;

  if p = 1 then writeln(n) else begin end;

  n := n + 1
end
