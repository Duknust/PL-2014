%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yyin;
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

Inst : LOAD Comando_load ficheiro {$3++; ; $3[strlen($3)-1]='\0';printf("LOAD! Ficheiro lido com o nome: %s\n",$3); /*yyin = fopen($3, "r");consolaparse();yylex()*/;printf("xx\n");/*if($2==CONF){printf("CONFIG lido!\n");}*/}
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

