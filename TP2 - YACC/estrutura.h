//#ifndef _ESTRUTURAS
//#define _ESTRUTURAS

#include "linked_list.h"
#include "csv.ger.h"
#include <stdio.h>

#define NAO_INICIADO 1
#define INICIADO 2
#define FINALIZADO 3

typedef struct sAtleta{
	char * Nome;
	char * Identificador;
	List lista;//usada por exemplo para guardar lista de pontos para o Ranking
	List listaExtra;//Lista de campos extra para print de Resultados
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
int idTotal;//total de identificadores/campos nos resultados
int idIdentificador;//indice do Identificador de Atleta
int idTempo;//indice do tempo da prova do atleta

//int nPontos;
int numeroProvas;//quantas provas sao ao todo
int numeroMelhorProvas;//quantos melhores resultados das provas contam

char *titulo; //nome do campeonato ou conjunto de provas
char *provasTemp; //variavel temporaria para guardar o nome das provas
char *camposTemp; //variavel temporaria para guardar os campos de interesse
char *defNomeTemp; //variavel temporaria para guardar os campos do nome
char *defIdTemp; //variavel temporaria para guardar a posicao do ID

char * confActual; //Nome do ficheiro de Configuracao actual


ListaLinhas csvList;


List listaListaLinhas; //Lista de listaLinhas que correspondem a todas as provas

List lista_Atletas; //Lista de Atletas -> Identificador,Nome(s),Pontos...
List lista_Resultados; //Lista da Lista de Resultados por prova -> Identificador,Pontos

List lista_Ranking; //Lista Ordenada da Pontuacao Final -> Identificador,Pontos
List lista_IdnomesAtletas;//Lista dos Indices dos Nomes dos Atletas
List lista_IdExtras;//Lista dos Indices dos Extras para Resultados
List lista_NomeExtras;//Lista dos Nomes dos Extras para a Tabela nos Resultados
List lista_nomesProvas;//Lista dos Nomes das Provas
List Historico; //Lista com os ficheiros lidos para preservar dados


Atleta getAtletabyId(List lista, char* id);
char * getNomeAtletabyId(List lista, char* id);
char * calcPontosAtleta(Atleta a, int maxP);
int compara2scoresResultados(void* d1,void * d2);
int compara2Int(void* d1,void * d2);
int compara2scores(void* ,void * );
int compara2IdsAtleta(void* d1,void * d2);
int compara2scoresAtleta(void*,void*);
int compara2scoresChar(void* ,void * );
void insere_Resultados(ListaLinhas , List );
void insere_atletas (List , ListaLinhas );
int pontuacao (int , int );
void print_listaListaLinhas();
void print_Prova(Prova p);
void print_ListaResultados();
void printaNome(void * ,void * );
void print_info();
int procura_atleta(List lAtletas,char*atleta);
int tempo2segundos(char * );
void print_ListaLinhas(ListaLinhas );
void set_NomesExtras(ListaLinhas);


void update_Ranking();
Prova getNProva (List lista,int n);
char * getNnomeProva (List lista,int n);

void print_ProvaHTML(Prova ,FILE *);
void print_RankingHTML(List ,FILE *);


void initHTML (FILE * , char * );
void fimHTML(FILE * );
List split(char* mensagem, char* sep); //Parte uma string por um determinado token
void print_lAtletas();
void popUpdateHistorico();//Insere e faz Pop no Historico, para fazer reset
void print_Historico();

void load_c_result(char * );
void save_db(char * nome);
void load_db(char * nome);
void ranking (char *);

void set_idTotal(ListaLinhas ll);
void reload_total();
//#endif
