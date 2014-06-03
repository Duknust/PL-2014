Origanizer : estrutura.o linked_list.o lex.consola.o consola.tab.o lex.conf.o conf.tab.o lex.csv.o csv.tab.o csv.ger.o
	gcc -o Origanizer estrutura.o linked_list.o lex.consola.o consola.tab.o lex.conf.o conf.tab.o lex.csv.o csv.tab.o csv.ger.o


estrutura.o : linked_list.h estrutura.c estrutura.h
	gcc -c estrutura.c

linked_list.o : linked_list.c linked_list.h
	gcc -c linked_list.c

lex.consola.c : consola.l
	flex consola.l

lex.consola.o : lex.consola.c
	gcc -c lex.consola.c

lex.conf.c : conf.l
	flex conf.l

lex.conf.o : lex.conf.c 
	gcc -c lex.conf.c

conf.tab.c conf.tab.h : linked_list.o estrutura.o conf.y
	yacc -d -b "conf" -p "conf" conf.y

conf.tab.o : conf.tab.c conf.tab.h
	gcc -c conf.tab.c

lex.csv.c : csv.ger.h csv.l
	flex csv.l

lex.csv.o : lex.csv.c
	gcc -c lex.csv.c

csv.ger.o : csv.ger.c csv.ger.h
	gcc -c csv.ger.c

csv.tab.c csv.tab.h : csv.y
	yacc -d -b "csv" -p "csv" csv.y

csv.tab.o : csv.tab.c csv.tab.h
	gcc -c csv.tab.c

consola.tab.c consola.tab.h : estrutura.o consola.y
	yacc -d -b "consola" -p "consola" consola.y

consola.tab.o : consola.tab.c consola.tab.h
	gcc -c consola.tab.c



clean:
	rm -f *.o consola.tab.* lex.consola.* csv.tab* lex.csv* Origanizer conf.*
