%{
#include "csv.tab.h"	
%}

%option prefix ="csv"
%option noyywrap

%%
[a-zA-Z0-9\_\-\ \:]+			{ csvlval.tipoString=strdup(yytext);
							  printf("cena ");
				 			  return c_string;
				 			}

\n* 						{printf("SL!\n");
							 return SEPL;
							}

\; 							{printf("SC ");
                             return SEPC;
                            }
                            
<<EOF>>   			return '$';

%%

