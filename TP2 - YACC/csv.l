%{
#include "y.tab.h"	
%}

%option prefix ="csv"

%%
[a-zA-Z\_][a-zA-Z0-9\_\-]+			{ yylval.tipoString=strdup(yytext);
									  printf("estou aqui csv!\n");
				 			  		  return tipoString;}

[0-9]+								{ yylval.tipoInt=atoi(yytext);
									  printf("estou aqui csv!\n");
				 			  		  return tipoInt;}

%%