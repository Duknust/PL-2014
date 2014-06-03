%{
#include "consola.tab.h"	
#include "estrutura.h"	

extern int compara2scores(void*,void*);
%}

%option prefix ="consola"
%option noyywrap
%%
"load"				return LOAD;

"save"			return SAVE;

"ranking"			return RANKING;

"exit"				return EXIT;

"listing"			return LISTING;

"info"				return INFO;

"conf"				return CONF;

"db"				return DB;

"result"			return RESULT;

"provas"			return PROVAS;

"atletas"		return ATLETAS;

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
	listaProvas = List_Create(NULL,NULL);
	lista_Atletas = List_Create(NULL,NULL);
	lista_Resultados = List_Create(NULL,*compara2scores);
	lista_Ranking = List_Create(NULL,NULL);
	Historico = List_Create(NULL,NULL);
	
	
	idTotal = 13;//vai sair daqui e vai ser quando for lido o CONF
	idTempo = 12;
	idIdentificador = 3;
	idNome = 5;
	
	nPontos=2;
	numeroProvas=3;
	numeroMelhorProvas=2;

	estado = INICIADO;
	titulo = strdup("Campeonato da Festa");

    consolaparse();
    yylex();
    //yyin = fopen("z.txt", "r");
    //consolaparse();
    //yylex();
    fclose(yyin);
    return 1;
}
