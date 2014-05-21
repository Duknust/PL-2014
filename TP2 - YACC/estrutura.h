#ifndef _ESTRUTURAS
#define _ESTRUTURAS

#include "linked_list.h"
#include "csv.ger.h"

//No ficheiro de resultados csv
int idTotal;//total de identificadores nos resultados
int idIdentificador;//indice do Identificador de Atleta
int idTempo;//indice do tempo da prova do atleta


int nPontos;
int numeroProvas;//quantas provas sao ao todo
int numeroMelhorProvas;//quantos melhores resultados das provas contam

char * titulo;

ListaLinhas csvList;


List listaProvas; //Lista de listaLinhas que correspondem a todas as provas

List lista_Atletas; //Lista de Atletas -> Identificador,Nome(s),Pontos...
List lista_Resultados; //Lista da Lista de Resultados por prova -> Identificador,Pontos
List lista_ResTotal; //Lista Ordenada da Pontuacao Final -> Identificador,Pontos


int compara2Int(void* d1,void * d2);
int compara2nomes(void* ,void * );
int compara2scores(void* ,void * );
int compara2scoresSoma(void* ,void * );
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



#endif
