objects=lex.consola.o csv.tab.o consola.tab.o lex.csv.o linked_list.o csv.ger.o estrutura.o -ll

cons : $(objects)
	gcc -o cons $(objects) -g 



csv.tab.o : csv.tab.h csv.tab.c
	gcc -c csv.tab.c

lex.csv.o : lex.csv.c csv.tab.h csv.ger.h
	gcc -c lex.csv.c

csv.tab.h csv.tab.c : csv.y linked_list.h estrutura.h csv.ger.h
	yacc -d -b "csv" -p "csv" csv.y

lex.csv.c : csv.l
	flex csv.l

csv.ger.o : csv.ger.h csv.ger.c
	gcc -c csv.ger.c

consola.tab.o : consola.tab.h consola.tab.c
	gcc -c consola.tab.c -g

lex.consola.o : lex.consola.c consola.tab.h
	gcc -c lex.consola.c

lex.consola.c : consola.l
	flex consola.l
	
consola.tab.h consola.tab.c : consola.y linked_list.o estrutura.h
	yacc -d -b "consola" -p "consola" consola.y 
	
linked_list.o: linked_list.h estrutura.c
		gcc -c linked_list.c

estrutura.o: estrutura.h estrutura.c linked_list.h csv.ger.h
		gcc -c estrutura.c


clean:
	rm -f *.o consola.tab.* lex.consola.* csv.tab* lex.csv* cons
