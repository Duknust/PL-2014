%{
#include <stdio.h>	
#include <stdlib.h>
int yylex(void);
int yyerror(char* s);
%}

%token SEPN LOAD SAVE RANKING EXIT LISTING INFO CONF DB RESULT PROVAS 
%token PARTICIPANTES PROVA TORNEIO ficheiro prova

%union{
	char* tipoficheiro;
	int tiponProva;
}

%type <tipoficheiro> ficheiro Inst
%type <tiponProva> prova



%start Consola

%%
Consola : ListaInstrucoes '$';


ListaInstrucoes : ListaInstrucoes SEPN Inst
				| Inst
				;

Inst : LOAD Comando_load ficheiro {printf("LOAD! Ficheiro lido com o nome: %s\n",$3);}
	 | SAVE ficheiro {$$=$2; printf("SAVE! Ficheiro gravado com o nome: %s\n",$2);}
	 | RANKING ficheiro {$$=$2;}
	 | EXIT {printf("---Até à proxima!---\n"); return;/*exit(0);*/}
	 | LISTING Comando_list
	 | INFO
	 ;

Comando_load : CONF
			 | DB
			 | RESULT
			 ;

Comando_list : PROVAS
			 | PARTICIPANTES prova {printf("PARTICIPANTES DA PROVA: %d\n",$2);}
			 | PROVA
			 | TORNEIO
			 ;

%%

int yyerror(char *s){
	fprintf(stderr,"%s",s);
	return -1;
}
/*
int main(){
	yyparse();
	return 0;
}*/

