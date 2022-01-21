all: pascual

pascual.tab.c pascual.tab.h:	pascual.y
	bison -t -v -d pascual.y

lex.yy.c: pascual.l pascual.tab.h
	flex pascual.l

pascual: lex.yy.c pascual.tab.c pascual.tab.h
	gcc -o pascual pascual.tab.c lex.yy.c -ll

test: pascual
	cd tests ; for i in *.pas ; do basename=$$(basename $$i .pas) ; ../pascual < $$basename.pas > $$basename.asm ; ruby ../pascual.rb < $$basename.asm > $$basename.txt ; done

clean:
	rm -rf pascual pascual.tab.c lex.yy.c pascual.tab.h pascual.output tests/*.asm tests/*.txt
