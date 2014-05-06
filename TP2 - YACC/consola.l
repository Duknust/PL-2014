%{
#include "consola.tab.h"	

%}

%option prefix ="consola"
%option noyywrap
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

\"[a-zA-Z0-9\ \.]*\"		{ consolalval.tipoficheiro=strdup(yytext);
					  printf("estou aqui tex!\n");
				 	  return ficheiro;}

[0-9]+				{ consolalval.tiponProva=atoi(yytext);
					  printf("estou aqui num!\n");
				 	  return prova;}

\n					return SEPN;

[ \t]	;

<<EOF>>   			return '$';

.					;			

%%


int main(int argc, char *argv[])
{
    consolaparse();
    yylex();
    yyin = fopen("f.txt", "r");
    consolaparse();
    yylex();
    fclose(yyin);
    return 1;
}
