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
int m=50,n=20,p=20;
char matriz [50][20][20];
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
	
	

void Ato3P(){
		int i,j;
		
		m2 = malloc(m * sizeof(char **));
    assert(m2 != NULL);
    for (i = 0; i < m; ++i)
    {
        m2[i] = malloc(n * sizeof(char *));
        assert(m2[i] != NULL);
        for (j = 0; j < n; ++j)
        {
            m2[i][j] = malloc(p);
            assert(m2[i][j] != NULL);
        }
    }
       
printf("ALOCOU\n");
		for(i=0;i<h;i++){
			for(j=0;j<l;j++)
				strcpy(m2[i][j],matriz[i][j]);
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
%type <tipoLista>  '$'  Linha ListaLinhas
%type <tipo3C>  Csv 

%start Csv

%%

Csv : ListaLinhas '$' {printf("_FIM_\n");
						//print_matriz(); 
						//if($$!=NULL)
							printf("\nCHEGUEIII\n");
						Ato3P();
						return m2;} ;

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
