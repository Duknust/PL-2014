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
%type <lista> ListaCampos ListaLinhas

%start Conf

%%

Conf : ListaLinhas '$' 
     ; 

ListaLinhas : ListaLinhas SEPL Linha
            | Linha
            ;

Linha : TITULO c_string
      | NPROVAS c_string
      | NUM c_string
      | CAMPO ListaCampos
      | PROVAS ListaCampos
      | DEFNOME ListaCampos
      | DEFID c_string
      |
      ;

ListaCampos : ListaCampos SEPC c_string 
		| c_string 
		;

%%

int yyerror(char *s){
	fprintf(stderr,"%s",s);
	return -1;
}