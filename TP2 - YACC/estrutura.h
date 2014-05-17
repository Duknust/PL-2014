#ifndef _ESTRUTURAS
#define _ESTRUTURAS

#include "linked_list.h"
#include "csv.ger.h"

//No ficheiro de resultados csv
int idTotal;
int idIdentificador;
int idTempo;



ListaLinhas csvList;


List listaProvas; //Lista de listaLinhas que correspondem a todas as provas

List lista_Atletas; //Lista de Atletas -> Identificador,Nome(s),Pontos...
List lista_Resultados; //Lista da Lista de Resultados por prova -> Identificador,Pontos

/*
int compara2nomes(void* ,void * );
int compara2scores(void* ,void * );
char * getNcampo (List ,int );
void insere_Resultados(ListaLinhas , List );
void insere_atletas (List , ListaLinhas );
int pontuacao (int , int );
void print_ListaProvas();
void printaNome(void * ,void * );
void printl();
void procura_atleta(List ,char*);
int tempo2segundos(char * );
void print_ListaLinhas(ListaLinhas );
*/
#endif
