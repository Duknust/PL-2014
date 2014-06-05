%{
#include <stdio.h>	
#include <stdlib.h>
#include "estrutura.h"

int yylex(void);
int yyerror(char* s);
%}

%token SEPL SEPC TITULO NPROVAS NUM CAMPO PROVAS DEFNOME DEFID DEFTEMPO c_string

%union{
	char* texto;
}

%type <texto> c_string

%start Conf

%%

Conf : ListaLinhas '$' {return 0;}
     ; 

ListaLinhas : ListaLinhas SEPL Linha
            | Linha
            ;

Linha : TITULO c_string {titulo = strdup($2);}
      | NPROVAS c_string {numeroMelhorProvas = atoi($2);}
      | NUM c_string {numeroProvas = atoi($2);}
      | CAMPO c_string {camposTemp = strdup($2);}
      | PROVAS c_string {provasTemp = strdup($2);}
      | DEFNOME c_string {defNomeTemp = strdup($2);}
      | DEFID c_string {idIdentificador = atoi($2);}
      | DEFTEMPO c_string {idTempo = atoi($2);}
      ;

%%

int yyerror(char *s){
	fprintf(stderr,"%s",s);
	return -1;
}
