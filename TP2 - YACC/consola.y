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
										case _RESULT : printf("RESULT\n");//HTML
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
														update_Ranking();
														
														//HTML
														vazio();
														int nprova = listaProvas->totalCount;
														char *c=(char*)malloc(sizeof(3));
														sprintf(c,"%d",nprova);
														char* nome = (char*)malloc(strlen(titulo)+35);
														strcpy(nome,titulo);
														strcat(nome,"_res");
														strcat(nome,c);
														strcat(nome,".html");
														FILE * html_file = fopen(nome, "w+");
														if(html_file < 0)
															printf("ERRO AO CRIAR O FICHEIRO: %s\n",nome);
														else
															{initHTML(html_file,titulo);
															 print_ProvaHTML(getNProva(lista_Resultados,nprova),html_file);
															 fclose(html_file);}
														csvList = NULL;
														break;
										case _CONF :printf("CONF\n");break;
										case _DB : printf("DB\n");break;
									}
								   }
								   
	 | SAVE ficheiro {$$=$2; printf("SAVE! Ficheiro gravado com o nome: %s\n",$2);}
	 | RANKING ficheiro {print_Ranking(lista_Ranking);$$=$2;} //HTML
	 | EXIT {printf("---Até à proxima!---\n"); return 0;/*exit(0);*/}
	 | LISTING Comando_list
	 | INFO {print_info();}
	 | '$' {return 0;}
	 ;

Comando_load : CONF {comando_flag = _CONF;}
			 | DB {comando_flag = _DB;}
			 | RESULT {comando_flag = _RESULT;}
			 ;

Comando_list : PROVAS {print_ListaProvas();}
			 | PARTICIPANTES prova {printf("PARTICIPANTES DA PROVA: %d\n",$2);}
			 | PROVA prova {print_Prova(getNProva(lista_Resultados,$2));}
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

