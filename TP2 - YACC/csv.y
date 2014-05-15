%{
#include <stdio.h>	
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <assert.h>
int yylex(void);
int yyerror(char* s);
#include "linked_list.h"

#define _NUMLINHAS 100
#define _NUMCOLUNAS 20
#define _CELULA 40

char matriz [_NUMLINHAS][_NUMCOLUNAS][_CELULA];

List csv_list;

char *** m2;
int h=0,l=0,hh=0,ll=0;

void print_matriz(){
		int i,j;
		printf("h=%d,l=%d\n",h,l);
		for(i=0;i<h;i++){
			for(j=0;j<l;j++)
				{printf("%s_",matriz[i][j]);}
			printf("\n");
			}
	}
	
void print_lista(List lista){
	//printf("%d\n", csv_list->totalCount);
	List x = lista;
	while(x->elems!=NULL){
		List y = (List)x->elems->data;//printf(":%d\n", y->totalCount);
		while(y->elems!=NULL){
			printf("%s_",(char*)y->elems->data );
			y->elems=y->elems->next;
		}x->elems=x->elems->next;printf("\n");
	}

}	

void Ato3P(){
		int i,j;
		
		m2 = malloc(_NUMLINHAS * sizeof(char **));
    assert(m2 != NULL);
    for (i = 0; i < _NUMLINHAS; ++i)
    {
        m2[i] = malloc(_NUMCOLUNAS * sizeof(char *));
        assert(m2[i] != NULL);
        for (j = 0; j < _NUMCOLUNAS; ++j)
        {
            m2[i][j] = malloc(_CELULA);
            assert(m2[i][j] != NULL);
        }
    }}


void AtoLL(){
	//printf("ATOLL \n");
    int i,j;
    csv_list = List_Create(NULL,NULL,NULL);
    
    
    for(i=0;i<h;i++){
    	List l2 = List_Create(NULL,NULL,NULL);
    	List_Push(csv_list,l2);
        for(j=0;j<l;j++){
        	List_Push(l2,matriz[i][j]);//printf("%d_", l2->totalCount);
        }//printf("\n");
    }

	}
	
%}

%token SEPL SEPC c_string

%union{
	char* tipoString;
	List tipoLista;
	int tipoInt;
	char *** tipo3C;
}

%type <tipoString>  c_string 
%type <tipoLista>  '$'  Linha ListaLinhas Csv

%start Csv

%%

Csv : ListaLinhas '$' {printf("_FIM_\n");
						//print_matriz(); 
						//if($$!=NULL)
							printf("\nCHEGUEIII\n");
						//Ato3P();
							AtoLL();
							//printf(".....Print da csv_list\n");print_lista(csv_list);printf(".....\n");
						return csv_list;} ;

ListaLinhas : ListaLinhas SEPL Linha {
					 int i = 0;
					 //List t = (List)$$;
					 //l = t->totalCount;
					 //printf("l=%d h=%d\n",t->totalCount,h);
					 
					 h++;
					 hh++;ll=0;}
			| Linha {
					 int i = 0;
					 //List t = (List)$$;
					 //l = t->totalCount;
					 //printf("l=%d h=%d\n",t->totalCount,h);
					 l=ll;
					 h++;
					 hh++;ll=0;}
			;

Linha : Linha SEPC c_string {/*printf("_%s_",$3);*/strcpy(matriz[hh][ll],(char*)$3);ll++;}
	  | c_string { /*printf("_I%s_",$1);*/ strcpy(matriz[hh][ll],(char*)$1);ll++;}
	  ;


%%

int yyerror(char *s){
	fprintf(stderr,"ERRO:%s",s);
	return -1;
}
/*
int main(){
//fflush(stdin);
//int fd = open("output.txt",O_CREAT | O_WRONLY | O_TRUNC, 0666);
 //dup2(fd,1);
 
	
 
	yyparse();
	
	return total;
}
*/
