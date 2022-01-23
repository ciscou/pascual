10
store cap
load cap
mkarray arr
0
0
storearr arr
1
1
-1
*
storearr arr
2
42
storearr arr
3
69
storearr arr
4
420
-1
*
storearr arr
5
17
storearr arr
6
1
storearr arr
7
23
storearr arr
8
100
storearr arr
9
33
storearr arr
0
loadarr arr
store min
0
loadarr arr
store max
0
store i
load i
load cap
lt
jz 73
load i
loadarr arr
load min
lt
jz 59
load i
loadarr arr
store min
jmp 59
load i
loadarr arr
load max
gt
jz 68
load i
loadarr arr
store max
jmp 68
load i
1
+
store i
jmp 46
load min
writeln
load max
writeln
