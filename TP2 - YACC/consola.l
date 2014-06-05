%{
#include "consola.tab.h"	
#include "estrutura.h"	

extern int compara2scores(void*,void*);
%}

%option prefix ="consola"
%option noyywrap
%%
"load"				return LOAD;

"save"				return SAVE;

"ranking"			return RANKING;

"exit"				return EXIT;

"listing"			return LISTING;

"info"				return INFO;

"conf"				return CONF;

"db"				return DB;

"result"			return RESULT;

"provas"			return PROVAS;

"atletas"			return ATLETAS;

"prova"				return PROVA;

"torneio"			return TORNEIO;

\"[a-zA-Z0-9\ \.\_]*\"		{ consolalval.tipoficheiro=strdup(yytext);
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
	listaListaLinhas = List_Create();
	lista_Atletas = List_Create();
	lista_Resultados = List_Create();
	lista_Ranking = List_Create();
	lista_nomesProvas= List_Create();
	lista_IdnomesAtletas= List_Create();
	lista_IdExtras= List_Create();
	lista_NomeExtras= List_Create();
	Historico = List_Create();
	confActual=NULL;
	estado = INICIADO;
	
	
	
	/*
	idTotal = 13;
	idTempo = 12;
	idIdentificador = 3;
	idNome = 5;
	
	nPontos=2;
	numeroProvas=3;
	numeroMelhorProvas=2;
	titulo = strdup("Campeonato da Festa");
*/

    consolaparse();
    yylex();
    //yyin = fopen("z.txt", "r");
    //consolaparse();
    //yylex();
    fclose(yyin);
    return 1;
}
