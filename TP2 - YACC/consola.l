%{
#include "consola.tab.h"	
#include "estrutura.h"	

extern int compara2scores(void*,void*);
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
					  //printf("estou aqui tex!\n");
				 	  return ficheiro;}

[0-9]+				{ consolalval.tiponProva=atoi(yytext);
					  //printf("estou aqui num!\n");
				 	  return prova;}

\n					return SEPN;

[ \t]	;

<<EOF>>   			return '$';

.					;			

%%


int main(int argc, char *argv[])
{
	listaProvas = List_Create(NULL,NULL,NULL);
	lista_Atletas = List_Create(NULL,NULL,NULL);
	lista_Resultados = List_Create(NULL,*compara2scores,NULL);
	idTotal = 13;//vai sair daqui e vai ser quando for lido o CONF
	idTempo = 12;
	idIdentificador = 3;
    consolaparse();
    yylex();
    //yyin = fopen("z.txt", "r");
    //consolaparse();
    //yylex();
    fclose(yyin);
    return 1;
}
