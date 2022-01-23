100
store max
2
store num
load num
load max
lte
jz 48
1
store is_prime
2
store divisor
load is_prime
1
eq
load divisor
load num
2
/
lte
and
jz 36
load num
load divisor
mod
0
eq
jz 31
0
store is_prime
jmp 31
load divisor
1
+
store divisor
jmp 12
load is_prime
1
eq
jz 43
load num
writeln
jmp 43
load num
1
+
store num
jmp 4
