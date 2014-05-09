#ifndef _LINKED_LIST_H

#define _LINKED_LIST_H 1

/**
 * Elemento de uma lista
 */
typedef struct list_elem {
	void *data;             /**< Dados do elemento */
	struct list_elem *next; /**< Proximo elemento */
} *ListElem;

/**
 * Estrutura de uma lista ligada
 */
typedef struct list {
	ListElem elems;                         /**< Lista de elementos */
	long long int (*getKey)(void *);                   /**< Funcao que extrai a chave */
	int (*compareFunction)(void *, void *); /**< Funcao de comparacao */
	int (*igualFunction)(void *,void *); /**< Funcao para valores repetidos */
	int totalCount;                              /**< Contagem de elementos */
} *List;

/**
 * @fn List_Create
 * @brief Cria uma nova lista
 * 
 * @param compareFunction Funcao de comparacao para insercao ordenada
 * @return Lista criada
 */
List List_Create(long long int (*getKey)(void *), int (*compareFunction)(void *, void *),int (*igualFunction)(void *, void *));

/**
 * @fn List_Push
 * @brief Insere um elemento no fim da lista
 *
 * @param list Lista a usar
 * @param newData dados a inserir
 * @return 0 em caso de sucesso
 */
int List_Push(List list, void *newData);

/**
 * @fn List_Pushinicio
 * @brief Insere um elemento no topo da lista
 *
 * @param list Lista a usar
 * @param newData dados a inserir
 * @return 0 em caso de sucesso
 */
int List_PushInicio(List list, void *newData);


/**
 * @fn List_Pop
 * @brief Retorna um elemento do topo da lista, removendo-o
 *
 * @param list List a usar
 * @return Dados retirados
 */
void *List_Pop(List list);

/**
 * @fn List_InsertOrd
 * @brief Insere ordenadamente na lista
 * 
 * @param list Lista a usar
 * @param newData Apontador para os dados a inserir
 * @return 0 em caso de sucesso
 */
int List_InsertOrd(List list, void *newData,int (*compareFunction)(void *, void *),int (*igualFunction)(void *, void *));

/**
 * @fn List_Search
 * @brief Procura um elemento numa lista cmo base numa funcao de procura
 * 
 * @param list Lista a procurar
 * @param searchFunction Funcao usada para decidir se os dados actuais sao ou nao os desejados
 * @return 0 em caso de sucesso
 */
void *List_Search(List list, int (*searchFunction)(void *, void *), void *params);


/**
 * @fn List_Delete
 * @brief Elimina toda a lista
 * 
 * @param list Lista a eliminar
 * @return 0 em caso de sucesso
 */
int List_Delete(List list);

/**
 * @fn List_ClearAll
 * @brief Elimina todos os elementos da lista
 * 
 * @param list Lista dos elementos a eliminar
 * @return 0 em caso de sucesso
 */
int List_ClearAll(List list);

/**
 * @fn List_ApplyToAll
 * @brief Aplica uma funcao a todos os elementos da lista
 * 
 * @param list Lista a usar
 * @param function Funcao a aplicar
 * @param params Parametros a enviar a funcao
 */
void List_ApplyToAll(List list, void (*function)(void *, void *), void *params);

#endif
