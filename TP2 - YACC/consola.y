%{
#include "estrutura.h"	
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE * csvin;
int yylex(void);
int yyerror(char* s);
extern List csvparse();

#define _CONF 1000
#define _DB 1001
#define _RESULT 1002

int comando_flag = -1;




//----------------------------------------------






//-----------------------------------------------


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

Inst : LOAD Comando_load ficheiro {$3++; ; 
								   $3[strlen($3)-1]='\0';
								   printf("LOAD! Ficheiro lido com o nome: %s\n",$3);
								   csvin = fopen($3, "r");


									switch(comando_flag){
										case _RESULT : printf("RESULT\n");
														(void)csvparse();
														printf("Push na Lista\n");
														ListaLinhas ll = csvList;
														if(ll!=NULL)
															List_Push(listaProvas,ll);
														else
															break;//discutir isto
															
														printf("\ncount da listaProvas=%d\n",listaProvas->totalCount);
														
														
														insere_atletas(lista_Atletas,csvList);
														
														insere_Resultados(csvList,lista_Resultados);
															
														//print_ListaLinhas(csvList);
														print_ListaProvas();
														print_ListaResultados();
														//printl();
														csvList = NULL;
														break;
										case _CONF :printf("CONF\n");break;
										case _DB : printf("DB\n");break;
									}
								   }
								   
	 | SAVE ficheiro {$$=$2; printf("SAVE! Ficheiro gravado com o nome: %s\n",$2);}
	 | RANKING ficheiro {$$=$2;}
<<<<<<< HEAD
	 | EXIT {printf("---Até à proxima!---\n"); return 0; /*exit(0);*/}
=======
	 | EXIT {printf("---Até à proxima!---\n"); return 0;/*exit(0);*/}
>>>>>>> 112
	 | LISTING Comando_list
	 | INFO
	 | '$' {return 0;}
	 ;

Comando_load : CONF {comando_flag = _CONF;}
			 | DB {comando_flag = _DB;}
			 | RESULT {comando_flag = _RESULT;}
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

