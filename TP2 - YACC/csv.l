%{
<<<<<<< HEAD
#include "csv.tab.h"	
=======

#include "csv.ger.h"	
#include "linked_list.h"
#include "csv.tab.h"

int total = 0;

>>>>>>> 112
%}

%option prefix ="csv"
%option noyywrap

%%
[a-zA-Z0-9\_\-\ ]+			{ /*csvlval.tipoString=strdup(yytext);*/
							  //printf("estou aqui csv!\n");
				 			  return c_string;
				 			}

<<<<<<< HEAD
\n+ 						{//printf("SL!\n");
							 return SEPL;
							}

\; 							{//printf("SC!\n");
                             return SEPC;
                            }

.							return 33;
=======
\n+ 						{total++;
							 //printf("\nSL! %d\n",total);
							 return SEPL;
							}

\; 							{//printf(" SC ");
                             return SEPC;
                            }
                            
<<EOF>>   			{ return '$';}
>>>>>>> 112

%%

