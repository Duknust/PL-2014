%{
#include <stdio.h>	
#include <stdlib.h>
#include "linked_list2elems.h"
int yylex(void);
int yyerror(char* s);
List *listaLigada;
%}

%token SEPL SEPC TITULO NPROVAS NUM CAMPO PROVAS c_string

%union{
	char* texto;
	int numero;
}

%type <texto> ListaCampos Linha c_string

%start Conf

%%

Conf : ListaLinhas '$' ; {$$=$1;}

ListaLinhas : ListaLinhas SEPL Linha
            | Linha
            ;

Linha : TITULO c_string
      | NPROVAS c_string
      | NUM c_string
      | CAMPO ListaCampos
      | PROVAS ListaCampos
      ;

ListaCampos : ListaCampos SEPC c_string {push($1, $3);}
			| c_string {List tmp = listCreate(NULL,NULL,NULL); push(tmp, $1);}
			;

%%

int yyerror(char *s){
	fprintf(stderr,"%s",s);
	return -1;
}

//int main(){
//	yyparse();
//	return 0;
//}
