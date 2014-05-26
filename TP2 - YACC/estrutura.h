#ifndef _ESTRUTURAS
#define _ESTRUTURAS

#include "linked_list.h"
#include "csv.ger.h"

typedef struct sAtleta{
	char * Nome;
	char * Identificador;
	List listaOrdPontos;
}*Atleta, NodoAtleta;


//No ficheiro de resultados csv
int idTotal;//total de identificadores nos resultados
int idIdentificador;//indice do Identificador de Atleta
int idTempo;//indice do tempo da prova do atleta
int idNome;//indice do Nome

int nPontos;
int numeroProvas;//quantas provas sao ao todo
int numeroMelhorProvas;//quantos melhores resultados das provas contam

char *titulo; //nome do campeonato ou conjunto de provas
char *provasTemp; //variavel temporaria para guardar o nome das provas
char *camposTemp; //variavel temporaria para guardar os campos de interesse
char *defNomeTemp; //variavel temporaria para guardar os campos do nome
char *defIdTemp; //variavel temporaria para guardar a posicao do ID

ListaLinhas csvList;


List listaProvas; //Lista de listaLinhas que correspondem a todas as provas

List lista_Atletas; //Lista de Atletas -> Identificador,Nome(s),Pontos...
List lista_Resultados; //Lista da Lista de Resultados por prova -> Identificador,Pontos
List lista_ResTotal; //Lista Ordenada da Pontuacao Final -> Identificador,Pontos


char * getNomeAtletabyId(List lista, char* id);
char * calcPontosAtleta(Atleta a, int maxP);
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
void print_Lista(List lr);
void print_ListaResultados();
void printaNome(void * ,void * );
void printl();
int procura_atleta(List lAtletas,char*atleta);
int tempo2segundos(char * );
void print_ListaLinhas(ListaLinhas );
void update_ListaResultados();
List getNProva (List lista,int n);
List split(char* mensagem, char* sep); //Parte uma string por um determinado token



#endif
