%{
#include <stdio.h>	
#include <stdlib.h>
#include "estrutura.h"

int yylex(void);
int yyerror(char* s);
%}

%token SEPL SEPC TITULO NPROVAS NUM CAMPO PROVAS DEFNOME DEFID c_string

%union{
	char* texto;
      List lista;
}

%type <texto> c_string
%type <lista> ListaLinhas

%start Conf

%%

Conf : ListaLinhas '$' 
     ; 

ListaLinhas : ListaLinhas SEPL Linha
            | Linha
            ;

Linha : TITULO c_string {titulo = strdup($2);}
      | NPROVAS c_string {numeroProvas = atoi($2);}
      | NUM c_string {numeroMelhorProvas = atoi($2);}
      | CAMPO c_string {camposTemp = strdup($2);}
      | PROVAS c_string {provasTemp = strdup($2);}
      | DEFNOME c_string {defNomeTemp = strdup($2);}
      | DEFID c_string {defIdTemp = strdup($2);}
      |
      ;

%%

int yyerror(char *s){
	fprintf(stderr,"%s",s);
	return -1;
}