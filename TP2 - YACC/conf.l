%{
//#include "conf.tab.h"	
#include "y.tab.h"	
%}

	//%option prefix ="conf"
%option noyywrap

%%
"=titulo= "					{printf(" lTIT ");return TITULO;}

"=nprovas= "				{printf(" lNP ");return NPROVAS;}

"=N= "						{printf(" lN ");return NUM;}

"=campos= "					{printf(" lCMP ");return CAMPO;}

"=prova= "					{printf(" lPROVS ");return PROVAS;}

[a-zA-Z0-9\_\-\ ]+			{ yylval.texto=strdup(yytext);
							  //printf("estou aqui csv!\n");
							  printf(" cena ");
				 			  return c_string;
				 			}

\n 							{printf("SL!\n");
							 return SEPL;
							}

\; 							{printf(" SC! ");
                             return SEPC;
                            }

.							return '$';

%%

