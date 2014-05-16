%{

#include "csv.ger.h"	
#include "linked_list.h"
#include "csv.tab.h"

int total = 0;

%}

%option prefix ="csv"
%option noyywrap

%%
[a-zA-Z0-9\_\-\ \:]+			{ 	csvlval.tipoString=strdup(yytext);
									//printf("cena ");
									return c_string;
								}

\n+ 						{total++;
							 printf("\nSL! %d\n",total);
							 return SEPL;
							}

\; 							{printf(" SC ");
                             return SEPC;
                            }
                            
<<EOF>>   			{ return '$';}

%%

