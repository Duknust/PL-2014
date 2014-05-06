%{
#include <stdio.h>	
#include <stdlib.h>
int yylex(void);
int yyerror(char* s);
%}

%token SEPL SEPC c_string c_inteiro

%union{
	char* tipoString;
	int tipoInt;
}

%type <tipoString> ListaAtributos
%type <tipoInt> Campo Linha

%start Csv

%%

Csv : ListaAtributos SEPL ListaLinhas '$'

ListaAtributos : ListaAtributos SEPC c_string
			   | c_string
			   ;

ListaLinhas : ListaLinhas SEPL Linha
			| Linha
			;

Linha : Linha SEPC Campo
	  | Campo
	  ;

Campo : c_string
      | c_inteiro
      ;

%%

int yyerror(char *s){
	fprintf(stderr,"%s",s);
	return -1;
}
