4
store cap
load cap
mkarray nums
0
2
storearr nums
1
11
storearr nums
2
7
storearr nums
3
15
storearr nums
9
store target
0
store i
load i
load cap
lt
jz 55
load i
1
+
store j
load j
load cap
lt
jz 50
load i
loadarr nums
load j
loadarr nums
+
load target
eq
jz 45
load i
writeln
load j
writeln
jmp 45
load j
1
+
store j
jmp 28
load i
1
+
store i
jmp 20
