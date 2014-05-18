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


void print_ListaLinhas(ListaLinhas l){
	ListaLinhas lis = l;
	Linha linha;
	char * x ;
	linha = l->u.d2.s1;
	char * texto;
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			//printf("listaflag=%d\n",lis->flag);
			linha = lis->u.d1.s2;
				
				while(linha->flag!=PScons_csv_Linha_Fim){
					
					//printf("linhaflag=%d\n",linha->flag);
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);
					printf("%s_",texto);
					linha = linha->u.d1.s1;					
					}
				x = (char*)linha->u.d2.s1;
				texto=strdup(x);
				printf("%s_\n",texto);
					
				
			lis = lis->u.d1.s1;	
			}
			
		linha = lis->u.d2.s1;
			
		while(linha->flag!=PScons_csv_Linha_Fim){
			
			//printf("linhaflag=%d\n",linha->flag);
			x = (char*)linha->u.d1.s2;
			texto=strdup(x);
			printf("%s_",texto);
			linha = linha->u.d1.s1;					
			}
		x = (char*)linha->u.d2.s1;
		texto=strdup(x);
		printf("%s_\n",texto);
				
			
		
		
		
	
}


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


									if (comando_flag == _CONF){
										(void)csvparse();
										printf("Push na Lista\n");
										List_Push(listaProvas,csvList);
										if(listaProvas==NULL)
											printf("lista NULL\n");
										else
											printf("\ncount da listaProvas=%d\n",listaProvas->totalCount);
											
										print_ListaLinhas(csvList);
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

