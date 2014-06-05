%{
#include "estrutura.h"	
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>

extern FILE * csvin;
extern FILE * confin;
int yylex(void);
int yyerror(char* s);

extern List csvparse();
extern int confparse();


#define _CONF 1000
#define _DB 1001
#define _RESULT 1002

#define KGRN  "\x1B[32m"
#define KRED  "\x1b[31m"
#define KNRM  "\x1B[0m"
#define KNEG  "\033[1;30m"  


int comando_flag = -1;
char buffer[2]={'\0','\0'};
char save[20]="";






%}

%token SEPN LOAD SAVE RANKING EXIT LISTING INFO CONF DB RESULT PROVAS 
%token ATLETAS PROVA TORNEIO ficheiro prova


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

Inst : LOAD Comando_load ficheiro {
								   $3++;
								   $3[strlen($3)-1]='\0';
								   switch(comando_flag){
										case _RESULT : load_c_result($3);
														break;

										case _CONF :	confin=fopen($3, "r");
														(void)confparse();
														free(confActual);
														confActual=strdup($3);
														reload_total();
														break;
										case _DB : load_db($3);break;
									}
								   }
	 | SAVE ficheiro { $2++;$2[strlen($2)-1]='\0';save_db($2); $$=$2;}
	 | RANKING ficheiro {ranking($2);
						 $$=$2;} 
	 | EXIT {if(saveActualizado==1){
	 			printf("---Até à proxima!---\n"); 
	 			return 0;
	 			}
	 		 else{
	 		 	printf("As informações não se encontram gravadas\n");
	 		    printf("Pretende gravar antes de sair? [Y/n]\n");
	 		    read(0,buffer,1);

	 		    if((strcmp(buffer,"y")==0) || (strcmp(buffer,"Y")==0)) {
	 		   		printf("Indique o nome do ficheiro onde pretende gravar\n");
	 		   		printf("> ");
	 		   		scanf("%s",save);
	 		   			 		    
	 		   			 		    	//GRAVAR!!

	 		    	printf(KGRN "O estado foi gravado em ");
	 		    	printf(KGRN "%s\n",save);
	 		    	printf(KNRM "---Até à proxima!---\n"); 
	 				return 0;
	 				}
	 			else {
	 				printf(KRED "O estado não foi gravado\n");
	  		    	printf(KNRM "---Até à proxima!---\n"); 
	 				return 0;
	 				}
	 		    }
	 		}
	 | LISTING Comando_list
	 | INFO {print_info();}
	 | '$' {return 0;}
	 ;

Comando_load : CONF {saveActualizado=0; comando_flag = _CONF;}
			 | DB {saveActualizado=0; comando_flag = _DB;}
			 | RESULT {saveActualizado=0; comando_flag = _RESULT;}
			 ;

Comando_list : PROVAS {print_listaListaLinhas();}
			 | ATLETAS {printf("\nATLETAS\n\n");print_lAtletas();}
			 | PROVA prova {print_Prova(getNProva(lista_Resultados,$2));}
			 | TORNEIO
			 ;

%%




/*
int main(){
	yyparse();
	return 0;
}*/


int yyerror(char *s){
	fprintf(stderr,"%s",s);
	return -1;
}
