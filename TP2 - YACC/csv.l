%{
#include "csv.tab.h"	
%}

%option prefix ="csv"
%option noyywrap

%%
[a-zA-Z\_][a-zA-Z0-9\_\-]+			{ csvlval.tipoString=strdup(yytext);
									  printf("estou aqui csv!\n");
				 			  		  return c_string;}

[0-9]+								{ csvlval.tipoInt=atoi(yytext);
									  printf("estou aqui csv!\n");
				 			  		  return c_inteiro;}

%%
