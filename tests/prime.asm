100
store m
2
store n
load n
load m
gt
not
jz 50
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
gt
not
and
jz 38
load n
load i
mod
0
eq
jz 33
0
store p
jmp 33
load i
1
+
store i
jmp 13
load p
1
eq
jz 45
load n
writeln
jmp 45
load n
1
+
store n
jmp 4
