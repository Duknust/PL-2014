%{
#include "y.tab.h"	
%}

%%
"load"				return LOAD;

"save_db"			return SAVE;

"ranking"			return RANKING;

"exit"				return EXIT;

"listing"			return LISTING;

"info"				return INFO;

"conf"				return CONF;

"db"				return DB;

"result"			return RESULT;

"provas"			return PROVAS;

"participantes"		return PARTICIPANTES;

"prova"				return PROVA;

"torneio"			return TORNEIO;

\"[a-z\ \.]*\"		{ yylval.tipoficheiro=strdup(yytext);
					  printf("estou aqui tex!\n");
				 	  return ficheiro;}

[0-9]+				{ yylval.tiponProva=atoi(yytext);
					  printf("estou aqui num!\n");
				 	  return prova;}

\n					return SEPN;

[ \t]	;

<<EOF>>   			return '$';

.					;			

%%