100
store m
2
store n
load n
load m
lte
jz 48
1
store p
2
store i
load p
1
eq
load i
load n
2
/
lte
and
jz 36
load n
load i
mod
0
eq
jz 31
0
store p
jmp 31
load i
1
+
store i
jmp 12
load p
1
eq
jz 43
load n
writeln
jmp 43
load n
1
+
store n
jmp 4
