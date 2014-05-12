%{
#include "csv.tab.h"	
%}

%option prefix ="csv"
%option noyywrap

%%
[a-zA-Z0-9\_\-\ ]+			{ /*csvlval.tipoString=strdup(yytext);*/
							  //printf("estou aqui csv!\n");
				 			  return c_string;
				 			}

\n+ 						{//printf("SL!\n");
							 return SEPL;
							}

\; 							{//printf("SC!\n");
                             return SEPC;
                            }

.							return 33;

%%

