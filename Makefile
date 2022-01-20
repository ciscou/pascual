all: pascual

pascual.tab.c pascual.tab.h:	pascual.y
	bison -t -v -d pascual.y

lex.yy.c: pascual.l pascual.tab.h
	flex pascual.l

pascual: lex.yy.c pascual.tab.c pascual.tab.h
	gcc -o pascual pascual.tab.c lex.yy.c -ll

clean:
	rm -rf pascual pascual.tab.c lex.yy.c pascual.tab.h pascual.output
