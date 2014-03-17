#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "linkedList.h"

List* init(size_t dataSize,int (*compare) (void*,void*)) {
    
    List *l = (List *) malloc (sizeof(List));
    l->size = 0;
    l->dataSize = dataSize;
    l->compare = compare;
    l->list = NULL;
    
    return l;
}

List* insertHead (List *l, void *data) { 
    
    if (l == NULL)
        return l;
    
    if(l->list == NULL) {
        l->list = (Node*) malloc (sizeof(Node));
        l->list->data = malloc(l->dataSize); 
        memcpy(l->list->data,data,l->dataSize);
        l->list->next = NULL;
        l->size++;
    }
    else {
        Node *aux = (Node*) malloc(sizeof(Node));
        aux->data = malloc(l->dataSize);
        memcpy(aux->data,data,l->dataSize);
        aux->next = l->list;
        l->list = aux;
        l->size++;
    }
    
    return l;
}

List* insertTail (List *l, void *data) {
    
    if (l == NULL)
        return l;
    
    if (l->list == NULL) {
        l->list = (Node*) malloc(sizeof(Node));
        l->list->data = malloc(l->dataSize);
        memcpy(l->list->data, data, l->dataSize);
        l->list->next = NULL;
        l->size++;
    }
    else {
        Node *head = l->list;
        Node *prev = l->list;
        l->list = l->list->next;
        
        while (l->list) {
            l->list = l->list->next;
            prev = prev->next;
        }
        
        l->list = (Node*) malloc (sizeof(Node));
        l->list->data = malloc(l->dataSize);
        memcpy(l->list->data, data, l->dataSize);
        prev->next = l->list;
        l->list->next = NULL;
        l->size++;
        l->list = head;
    }
    return l;
    
}

List* sortedInsert (List *l, void *data) {
    
    if (l == NULL)
        return l;
    
    if (l->list == NULL) 
       l = insertHead(l, data);
    
    else {
        int cmp = l->compare(data,l->list->data);
        int inserted = 0;

        if(cmp == -1) { 
            l = insertHead(l, data);
            inserted = 1;
        }
        
        Node *head = l->list;
        Node *prev = l->list;
        l->list = l->list->next;
        
        
        while (l->list && !inserted) {
            cmp = l->compare (data,l->list->data);
            if (cmp == -1) {
                Node *new = (Node*) malloc(sizeof(Node));
                new->data = malloc(l->dataSize);
                memcpy(new->data, data, l->dataSize);
                prev->next = new;
                new->next = l->list;
                l->size++;
                inserted = 1;
            }
            prev = prev->next;
            l->list = l->list->next;
        }
        if(l->list == NULL && !inserted) {
            l->list = head;
            l = insertTail(l, data);
        }
        l->list = head;
    }
    return l;
}

List* removeNode (List* l, void *data) {
    
    int found = l->compare (data,l->list->data);
    
    if(found == 0) { 
        Node *tmp = l->list;
        l->list = l->list->next;
        free(tmp->data); 
        free(tmp);
        l->size--;
    }
    else {
        Node *prev = l->list;
        Node *head = l->list;
        
        while(l->list && found != 0) { 
            l->list = l->list->next;
            found = l->compare(data,l->list->data);
                
            if(found == 0) {
                prev->next = l->list->next;
                free(l->list->data);
                free(l->list);
                l->size--;
            }
            prev = prev->next;
        }
        l->list = head;
    }
    return l;
}
    

int search (List *l, void *data) {
    
    int cmp = -1;
    
    while (l->list) {
        cmp = l->compare(data,l->list->data);
        if (cmp == 0)
            return 0;
        l->list = l->list->next;
    }
    return cmp;
}


int listDestroy (List *l){

    
    if(!l)
        return -1;
    
    Node *aux = l->list;
    Node *prev;
    
    while(aux) {
        prev = aux;
        aux = aux->next;
            free(prev->data);
            free(prev);
        
    }
    
    return 0;
}

void* pop(List* l){
    Node* node = l->list;
    void* res = node->data;
    l->list=l->list->next;
    free(node);
    l->size--;
    return res;         
}
