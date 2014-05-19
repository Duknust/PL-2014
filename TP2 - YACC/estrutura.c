#include "estrutura.h"





void print_ListaLinhas(ListaLinhas l){
	ListaLinhas lis = l;
	Linha linha;
	char * x ;
	linha = l->u.d2.s1;
	char * texto;
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			//printf("listaflag=%d\n",lis->flag);
			linha = lis->u.d1.s2;

				while(linha->flag!=PScons_csv_Linha_Fim){
					
					//printf("linhaflag=%d\n",linha->flag);
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);
					printf("%s_",texto);
					linha = linha->u.d1.s1;					
					}
				x = (char*)linha->u.d2.s1;
				texto=strdup(x);
				printf("%s_\n",texto);
					
				
			lis = lis->u.d1.s1;	
			}
			
		linha = lis->u.d2.s1;
			
		while(linha->flag!=PScons_csv_Linha_Fim){
			
			//printf("linhaflag=%d\n",linha->flag);
			x = (char*)linha->u.d1.s2;
			texto=strdup(x);
			printf("%s_",texto);
			linha = linha->u.d1.s1;					
			}
		x = (char*)linha->u.d2.s1;
		texto=strdup(x);
		printf("%s_\n\n",texto);
					
}

void insere_atletas (List lAtletas, ListaLinhas prova){//Vai inserir atletas novos caso não estejam na Lista
   
    ListaLinhas lis = prova;
	Linha linha;
	char * x ;
	char * texto;
	int nLinha=1,nColuna=1;
	//linha = lis->u.d2.s1;
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			linha = lis->u.d1.s2;

				while(linha->flag!=PScons_csv_Linha_Fim){
					
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);
					if(idTotal-nColuna==idIdentificador)
						if(procura_atleta(lAtletas,texto)==0)
							List_Push(lAtletas,texto);
					linha = linha->u.d1.s1;	
					nColuna++;				
					}
				x = (char*)linha->u.d2.s1;
				texto=strdup(x);
				if(idTotal-nColuna==idIdentificador)
					if(procura_atleta(lAtletas,texto)==0)
						List_Push(lAtletas,texto);
				nColuna=1;
				
			lis = lis->u.d1.s1;	
			nLinha++;
			}
			
			
			
		//falta fazer parse à ultima linha, linha essa que é a do cabeçalho portanto ignoramos
		

}


void printaNome(void * n1,void * n2){
	printf("nome=%s\n",(char*)n1);
}

int compara2nomes(void* d1,void * d2){
     
    char* c1 = (char* )d1;
    char* c2 = (char* )d2;
     
    int compare = strcmp(c1,c2);
     
    if (compare == 0)
        return 1;
    else
        return 0;
     
}

int procura_atleta(List lAtletas,char*atleta){
	char * nome = List_Search(lAtletas,*compara2nomes,atleta);
	if(nome==NULL)
		return 0;
	else
		return 1;	
}


	
void printl(){
	
	ListElem aux = lista_Atletas->elems;

    while (aux != NULL) {
        printf("%s\n",(char*)aux->data);
        aux = aux->next;
    }
	
}
	
	
void print_ListaProvas(){
	
	ListElem aux = listaProvas->elems;

    while (aux != NULL) {
        print_ListaLinhas((ListaLinhas)aux->data);
        aux = aux->next;
    }
	
}	


	
void print_ListaResultados(){
	
	ListElem aux = lista_Resultados->elems;
	printf("l=%d\n",lista_Resultados->totalCount);
		
    while (aux != NULL) {
		List l = (List)aux->data;
		ListElem le2 = l->elems;	
		while (le2 != NULL) {
			List l2 = (List)le2->data;	
		
			//FALTA O MEGA IF PARA QUANDO O IDENTIFICADOR APARECER DEPOIS DO TEMPO
		
			//printf("ll=%d\n",l->totalCount);
			ListElem le1=l2->elems;
			char * pontos = (char*) le1->data;
			le1=le1->next;
			char * id = (char*)le1->data;
			
			printf("id=%s,pontos=%s\n",id,pontos);
			le2=le2->next;}printf("\n--------------\n");
        
        aux = aux->next;
    }
	
}	
	

int tempo2segundos(char * tempo){
	int horas,minutos,segundos;
	
	int s = sscanf(tempo,"%d:%d:%d",&horas,&minutos,&segundos);
	
	segundos+=horas*3600 + minutos*60;
	
	if(s>0)
		return segundos;
	else
		return -1;
}

int pontuacao (int tempo_melhor, int tempo_atleta){
	
	float f = (float)tempo_melhor / tempo_atleta * 100;
	//printf("%d-%d-%2f\n",tempo_melhor,tempo_atleta,f);
	return (int)f;
	
}

char * getNcampo (List l,int n){
	int count = 1;
	ListElem aux = l->elems;

    while (aux != NULL) {
        if(count == n)
			return (char*)aux->data;
        count++;
    }
	return NULL;
}

int compara2scores(void* d1,void * d2){
     
    List l1 = (List)d1;
    List l2 = (List)d2;
     
    int n1 = atoi((char*)getNcampo(l1,nPontos));
    int n2 = atoi((char*)getNcampo(l2,nPontos));
     
    if (n1>n2)
        return -1;
    else if (n1<n2)
        return 1;
    else
        return 0;
     
}

int getTempoMelhor(ListaLinhas prova){
	
	ListaLinhas lis = prova;
	Linha linha;
	char * x ;
	char * texto;
	int melhor=-1;
	int nLinha=0,nColuna=0;
	//linha = lis->u.d2.s1;
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			linha = lis->u.d1.s2;
				while(linha->flag!=PScons_csv_Linha_Fim){
					
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);
					
					if(idTotal-nColuna==idTempo)
						{int seg = tempo2segundos(texto);
						 if(melhor==-1 || melhor>seg)
							melhor=seg;
						 }
					
					linha = linha->u.d1.s1;	
					nColuna++;				
					}
				x = (char*)linha->u.d2.s1;
				texto=strdup(x);
				
				if(idTotal-nColuna==idTempo)
					{int seg = tempo2segundos(texto);
					 if(melhor==-1 || melhor>seg)
						melhor=seg;
					 }
				
				nColuna=0;
				
			lis = lis->u.d1.s1;	
			nLinha++;
			}
		return melhor;
	
}


void insere_Resultados(ListaLinhas prova, List provas){
	
	ListaLinhas lis = prova;
	Linha linha;
	char * x ;
	char * texto;
	
	int nLinha=0,nColuna=0;
	int tempomelhor=getTempoMelhor(lis);
	printf("melhor=%d\n",tempomelhor);
	List resprova=List_Create(NULL,*compara2scores,NULL);
	
	
	//linha = lis->u.d2.s1;
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			linha = lis->u.d1.s2;
			List score= List_Create(NULL,NULL,NULL);
				while(linha->flag!=PScons_csv_Linha_Fim){
					
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);
					
					if(idTotal-nColuna==idIdentificador)
						{List_Push(score,texto);printf("texto=%s\n",texto);}
					else if(idTotal-nColuna==idTempo)
						{int seg = tempo2segundos(texto);
						 char* pontos = (char*)malloc(sizeof(char)*4);
						 sprintf(pontos,"%d",pontuacao(tempomelhor,seg));
						 List_Push(score,pontos);printf("pontos=%s,seg=%d\n",pontos,seg);
						 }

					linha = linha->u.d1.s1;	
					nColuna++;				
					}
				x = (char*)linha->u.d2.s1;
				texto=strdup(x);
				
				if(idTotal-nColuna==idIdentificador)
					List_Push(score,texto);
				else if(idTotal-nColuna==idTempo)
					{int seg = tempo2segundos(texto);
					 char* pontos = (char*)malloc(sizeof(char)*4);
				     sprintf(pontos,"%d",pontuacao(tempomelhor,seg));
					 List_Push(score,pontos);}
				
				nColuna=0;
					
				lis = lis->u.d1.s1;	
				nLinha++;
				List_InsertOrd(resprova,score,NULL,NULL);
			}
			
		List_InsertOrd(provas,resprova,NULL,NULL);
	
		
}





