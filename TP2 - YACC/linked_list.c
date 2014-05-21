#include <stdlib.h>
#include <stdio.h>
#include "linked_list.h"


List List_Create(long long int (*getKey)(void *), int (*compareFunction)(void *, void *)) {
    List newList = (List) malloc(sizeof (struct list));
    newList->elems = NULL;
    newList->compareFunction = compareFunction;
    newList->getKey = getKey;
    newList->totalCount = 0;

    return newList;
}

int List_Push(List list, void *newData) {
	
	if(list==NULL)
		list = List_Create(NULL,NULL);
		
    ListElem newElem = malloc(sizeof(struct list_elem));
		struct list_elem *ptrlist;
		ptrlist=list->elems;
		
	if(list->elems!=NULL)
{
	while(ptrlist->next!=NULL)
		ptrlist=ptrlist->next;
		
    newElem->data = newData;
    newElem->next = NULL;
    ptrlist->next = newElem;

}else
{
    newElem->data = newData;
    newElem->next = NULL;
    list->elems = newElem;

}

    list->totalCount++;

    return 0;
}


int List_PushInicio(List list, void *newData) {
    ListElem newElem = malloc(sizeof(struct list_elem));

    newElem->data = newData;
    newElem->next = list->elems;
    list->elems = newElem;

    list->totalCount++;

    return 0;
}


void *List_Pop(List list) {
    if (list->totalCount == 0)
        return NULL;
    
    void *data = list->elems->data;
    ListElem newList = list->elems->next;
    free(list->elems);
    list->elems = newList;

    list->totalCount--;

    return data;
}

int List_InsertOrd(List list, void *newData) {
    ListElem *aux = &(list->elems);

    while (*aux != NULL && list->compareFunction((*aux)->data, newData)<0) {
        aux = &((*aux)->next);        
    }
    
    if (*aux !=NULL)
    {
		if (list->compareFunction((*aux)->data, newData)==0)	
			{return 0;}
		else
			{
			ListElem newElem;
			if (!(newElem = (ListElem) malloc(sizeof (struct list_elem))))
				return 2;
			newElem->next = *aux;
			newElem->data = newData;
			*aux = newElem;

			list->totalCount++;
			
			
			return 0;
			}
		return -1;
	}
	else{
   
    ListElem newElem;
    if (!(newElem = (ListElem) malloc(sizeof (struct list_elem))))
        return 2;
    newElem->next = *aux;
    newElem->data = newData;
    *aux = newElem;

    list->totalCount++;
	
    return 0;}
}

void *List_Search(List list, int (*searchFunction)(void *, void *), void *params) {
    ListElem aux = list->elems;

    while (aux != NULL) {
        if (searchFunction(aux->data, params))
            return aux->data;
        aux = aux->next;
    }

    return NULL;
}

void List_RemoveElem(List list, long long int key) {
    ListElem *elem = &(list->elems);
    ListElem aux;

    while (*elem != NULL && list->getKey((*elem)->data) != key) {
        elem = &((*elem)->next);
    }

    if (*elem != NULL) {
        aux = *elem;
        *elem = (*elem)->next;
        free(aux);
        list->totalCount--;
    }

}

int List_Delete(List list) {
    ListElem aux;

    while (list->elems != NULL) {
        aux = list->elems;
        list->elems = list->elems->next;
        free(aux);
    }

    free(list);

    return 0;
}


int List_ClearAll(List list) {
    ListElem aux;

    while (list->elems != NULL) {
        aux = list->elems;
        list->elems = list->elems->next;
        free(aux);
    }

    

    return 0;
}

void List_ApplyToAll(List list, void (*function)(void *, void *), void *params) {
    ListElem aux = list->elems;

    while (aux != NULL) {
        function(aux->data, params);
        aux = aux->next;
    }
}
