%{
#include <stdio.h>	
#include <stdlib.h>
int yylex(void);
int yyerror(char* s);
%}

%token SEPL SEPC c_string

%union{
	char* tipoString;
}

%type <tipoString> ListaAtributos c_string

%start Csv

%%

Csv : ListaAtributos SEPL ListaLinhas '$'

ListaAtributos : ListaAtributos SEPC c_string
			   | c_string
			   ;

ListaLinhas : ListaLinhas SEPL Linha
			| Linha
			;

Linha : Linha SEPC c_string
	  | c_string
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
