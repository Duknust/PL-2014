%{
#include <stdio.h>	
#include <stdlib.h>
<<<<<<< HEAD
int yylex(void);
int yyerror(char* s);
=======
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <assert.h>
#include "estrutura.h"

int yylex(void);
int yyerror(char* s);	
>>>>>>> 112
%}

%token SEPL SEPC c_string

%union{
	char* tipoString;
<<<<<<< HEAD
}

%type <tipoString> ListaAtributos c_string
=======
	ListaLinhas listalinhas;
	Linha linha;
}

%type <listalinhas> Csv ListaLinhasC 
%type <linha> LinhaC
%type <tipoString> c_string
>>>>>>> 112

%start Csv

%%

<<<<<<< HEAD
Csv : ListaAtributos SEPL ListaLinhas '$'

ListaAtributos : ListaAtributos SEPC c_string
			   | c_string
			   ;

ListaLinhas : ListaLinhas SEPL Linha
			| Linha
			;

Linha : Linha SEPC c_string
	  | c_string
=======
Csv : ListaLinhasC '$' {$$ = $1; valorzinho=1;csvList = $$; YYACCEPT;}
    ;

ListaLinhasC : ListaLinhasC SEPL LinhaC {$$ = cons_csv_ListaLinhas($1, $3);}
			| LinhaC {$$ = cons_csv_ListaLinhas_Fim($1);}
			;

LinhaC : LinhaC SEPC c_string {$$ = cons_csv_Linha($1, $3);}
	  | c_string {$$ = cons_csv_Linha_Fim($1);}
>>>>>>> 112
	  ;


%%

int yyerror(char *s){
	fprintf(stderr,"%s",s);
	return -1;
}
<<<<<<< HEAD

//int main(){
//	yyparse();
//	return 0;
//}
=======
>>>>>>> 112
