#ifndef _ESTRUTURAS
#define _ESTRUTURAS

#include "linked_list.h"
#include "csv.ger.h"
#include <stdio.h>

#define NAO_INICIADO 1
#define INICIADO 2
#define FINALIZADO 3

typedef struct sAtleta{
	char * Nome;
	char * Identificador;
	List lista;
}*Atleta, NodoAtleta;



typedef struct sProva{
	char * nome;//Nome da Prova
	List listaResultados;//Lista dos Resultados da Prova Ordenados por Pontuacao
}*Prova, NodoProva;


typedef struct sResultado{
	Atleta atleta;//Aponta para um Atleta na Lista de Atletas
	char * tempo;//Tempo
	char * pontos;//Pontos obtidos	
}*Resultado, NodoResultado;


int estado;
int saveActualizado;//Saber se o programa esta gravado


//No ficheiro de resultados csv
int idTotal;//total de identificadores nos resultados
int idIdentificador;//indice do Identificador de Atleta
int idTempo;//indice do tempo da prova do atleta
int idNome;//indice do Nome

int nPontos;
int numeroProvas;//quantas provas sao ao todo
int numeroMelhorProvas;//quantos melhores resultados das provas contam

char * titulo;

ListaLinhas csvList;


List listaProvas; //Lista de listaLinhas que correspondem a todas as provas

List lista_Atletas; //Lista de Atletas -> Identificador,Nome(s),Pontos...
List lista_Resultados; //Lista da Lista de Resultados por prova -> Identificador,Pontos
List lista_Ranking; //Lista Ordenada da Pontuacao Final -> Identificador,Pontos

Atleta getAtletabyId(List lista, char* id);
char * getNomeAtletabyId(List lista, char* id);
char * calcPontosAtleta(Atleta a, int maxP);
int compara2scoresResultados(void* d1,void * d2);
int compara2Int(void* d1,void * d2);
int compara2nomes(void* ,void * );
int compara2scores(void* ,void * );
int compara2IdsAtleta(void* d1,void * d2);
int compara2scoresAtleta(void*,void*);
int compara2scoresChar(void* ,void * );
char * getNcampo (List ,int );
void insere_Resultados(ListaLinhas , List );
void insere_atletas (List , ListaLinhas );
int pontuacao (int , int );
void print_ListaProvas();
void print_Prova(Prova p);
void print_ListaResultados();
void printaNome(void * ,void * );
void printl();
void print_info();
int procura_atleta(List lAtletas,char*atleta);
int tempo2segundos(char * );
void print_ListaLinhas(ListaLinhas );
void update_Ranking();
Prova getNProva (List lista,int n);


void print_ProvaHTML(Prova ,FILE *);
void initHTML (FILE * , char * );

void vazio();


#endif
