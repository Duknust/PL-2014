%{
#include <stdio.h>	
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <assert.h>
#include "estrutura.h"

int yylex(void);
int yyerror(char* s);	
%}

%token SEPL SEPC c_string

%union{
	char* tipoString;
	ListaLinhas listalinhas;
	Linha linha;
}

%type <listalinhas> Csv ListaLinhasC 
%type <linha> LinhaC
%type <tipoString> c_string

%start Csv

%%

Csv : ListaLinhasC '$' {$$ = $1; valorzinho=1;csvList = $$; YYACCEPT;}
    ;

ListaLinhasC : ListaLinhasC SEPL LinhaC {$$ = cons_csv_ListaLinhas($1, $3);}
			| LinhaC {$$ = cons_csv_ListaLinhas_Fim($1);}
			;

LinhaC : LinhaC SEPC c_string {$$ = cons_csv_Linha($1, $3);}
	  | c_string {$$ = cons_csv_Linha_Fim($1);}
	  ;


%%

int yyerror(char *s){
	fprintf(stderr,"ERRO:%s",s);
	return -1;
}
