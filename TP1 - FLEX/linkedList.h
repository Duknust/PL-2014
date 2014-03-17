#ifndef LINKEDLIST
#define LINKEDLIST

#include <stdlib.h>


/**
 * Estrutura para cada nodo
 */
typedef struct node {
    void* data;		/**< Apontador para um tipo de dados*/
    struct node *next;	/**< Apontador para o próximo nodo*/
}Node;

/**
 * Estrutura para o controlo de uma lista ligada
 */
typedef struct list {
    int size;		/**< Número de elementos na lista ligada*/
    int (*compare) (void*,void*); /**< Apontador para a função de comparação*/
    size_t dataSize;	/**< Representa a quantidade de memória(sizeof) que um tipo de dados necessita*/
    Node *list;		/**< Apontador para o primeiro nodo da lista(cabeça)*/
}List;

/**
 *init
 *@brief Inicia a Lista Ligada a NULL 
 *@param dataSize Valor que cada nodo ocupa na memória
 *@param compare Apontador para a função de comparação
 *@return Apontador para a lista inicializada
 */
List* init(size_t dataSize,int (*compare) (void*,void*));
/**
 *insertHead
 *@brief Insere um novo nodo à cabeça da lista
 *@param l Apontador para a lista ligada sobre a qual se vai trabalhar
 *@param data Apontador para os dados a inserir no nodo
 *@return Apontador para o novo estado da lista ligada
 */
List* insertHead (List *l, void *data);
/**
 *search
 *@brief Pesquisa o nodo que contenha os dados passados como parâmetro
 *@param l Apontador para a lista ligada sobre a qual se vai trablhar
 *@param data Apontador para os dados que se pretende procurar
 *@return 0 caso encontre os dados e diferente 0 caso não encontre
 */
int search (List *l, void *data);
/**
 *listDestroy
 *@brief Elimina a lista ligada e tudo para o que esta aponta
 *@param l Apontador para a lista ligada que se pretende eliminar
 *@return 0 em caso de sucesso e -1 em caso contrário
 */
int listDestroy(List *l);
/**
 *sortedInsert
 *@brief Insere os dados ordenadamente (de acordo com a função compare)
 *@param l Apontador para a lista em que se pretende inserir dados
 *@param data Apontador para os dados que se quer inserir
 *@return Apontador para o novo estado da lista ligada
 */
List* sortedInsert (List *l, void *data);
/**
 *insertTail
 *@brief Insere os dados no fim da lista ligada
 *@param l Apontador para a lista ligada em que se pretende inserir dados
 *@param data Apontador para os dados que se quer inserir
 *@return Apontador para o novo estado da lista ligada
 */
List* insertTail (List *l, void *data);
/**
 *removeNode
 *@brief Remove o nodo da lista ligada que contenha os dados passados como parâmetro
 *@param l Apontador para a lista ligada em que se pretende remover o nodo
 *@param data Apontador para os dados com que se irá comparar
 *@return Apontador para o novo estado da lista
 */
List* removeNode (List*l, void *data);

void* pop(List* l);

#endif