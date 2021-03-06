%{
#include "linked_list.h"
#include "conf.tab.h"	

%}

%option prefix ="conf"
%option noyywrap

%%
"=titulo= "					return TITULO;

"=nprovas= "				return NPROVAS;

"=N= "						return NUM;

"=campos= "					return CAMPO;

"=prova= "					return PROVAS;

"=defNOME= "				return DEFNOME;

"=defID= "					return DEFID;

"=defTempo="				return DEFTEMPO;

[a-zA-Z0-9\_\-\ \,]+		{ conflval.texto=strdup(yytext);
				 			  return c_string;
				 			}

\n 							return SEPL;

\; 							return SEPC;

<<EOF>>						return '$';

%%

