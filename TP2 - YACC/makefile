objects=lex.consola.o csv.tab.o consola.tab.o lex.csv.o linked_list.o -ll

cons : $(objects)
	gcc -o cons $(objects)



csv.tab.o : csv.tab.h csv.tab.c
	gcc -c csv.tab.c

lex.csv.o : lex.csv.c csv.tab.h
	gcc -c lex.csv.c

csv.tab.h csv.tab.c : csv.y linked_list.h
	yacc -d -b "csv" -p "csv" csv.y

lex.csv.c : csv.l
	flex csv.l


consola.tab.o : consola.tab.h consola.tab.c
	gcc -c consola.tab.c


lex.consola.o : lex.consola.c consola.tab.h
	gcc -c lex.consola.c


lex.consola.c : consola.l
	flex consola.l
	
	
consola.tab.h consola.tab.c : consola.y linked_list.o
	yacc -d -b "consola" -p "consola" consola.y
	
linked_list.o: linked_list.h
		gcc -c linked_list.c


clean:
	rm -f *.o consola.tab.* lex.consola.* csv.tab* lex.csv* cons
