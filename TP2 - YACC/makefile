objects=list.o y.tab.o lex.yy.o -ll list.o

cons : $(objects)
	gcc -o cons $(objects)

y.tab.o : y.tab.h y.tab.c
	gcc -c y.tab.c

lex.yy.o : lex.yy.c y.tab.h
	gcc -c lex.yy.c

y.tab.h y.tab.c : consola.y
	yacc -d consola.y

lex.yy.c : consola.l
	flex consola.l

list.o : list.c list.h
	gcc -c list.c


clean:
	rm -f *.o
