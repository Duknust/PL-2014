Origanizer : estrutura.o linked_list.o lex.csv.o csv.tab.o csv.ger.o lex.consola.o consola.tab.o lex.conf.o conf.tab.o
	gcc -o Origanizer estrutura.o linked_list.o conf.tab.o csv.tab.o csv.ger.o lex.csv.o lex.consola.o consola.tab.o lex.conf.o 



lex.consola.c : consola.l
	flex consola.l

lex.conf.c : conf.l
	flex conf.l

lex.conf.o : lex.conf.c conf.tab.h
	gcc -c -g lex.conf.c

conf.tab.c conf.tab.h : linked_list.o estrutura.o conf.y
	yacc -d -b "conf" -p "conf" conf.y

conf.tab.o : conf.tab.c conf.tab.h
	gcc -c -g conf.tab.c

lex.csv.c : csv.ger.h csv.l
	flex csv.l

csv.ger.o : csv.ger.c csv.ger.h
	gcc -c -g csv.ger.c

csv.tab.c csv.tab.h : csv.y
	yacc -d -b "csv" -p "csv" csv.y

csv.tab.o : csv.tab.c csv.tab.h
	gcc -c -g csv.tab.c

consola.tab.o : consola.tab.c consola.tab.h
	gcc -c -g consola.tab.c


consola.tab.c consola.tab.h : estrutura.o consola.y
	yacc -d -b "consola" -p "consola" consola.y

lex.consola.o : lex.consola.c consola.tab.h
	gcc -c -g lex.consola.c

lex.csv.o : lex.csv.c csv.tab.h
	gcc -c -g lex.csv.c


estrutura.o : linked_list.h estrutura.c estrutura.h
	gcc -c -g estrutura.c

linked_list.o : linked_list.c linked_list.h
	gcc -c -g linked_list.c





clean:
	rm -f *.o consola.tab.* lex.consola.* csv.tab* lex.csv* Origanizer conf.tab.* lex.conf.*
