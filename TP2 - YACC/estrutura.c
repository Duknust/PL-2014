#include "estrutura.h"

char * getNomeAtletabyId(List lista, char* id){//Retorna o Nome do Atleta de uma Lista de Atletas com o id
	
	int encontrado = 0;
	char * nome;
	ListElem aux = lista->elems;

    while (aux != NULL) {
        Atleta a = (Atleta)aux->data;
		if(strcmp(a->Identificador,id)==0)
			 return a->Nome;
        aux = aux->next;
    }
    return NULL;//Não tem esse ID na Lista
	
}

char * calcPontosAtleta(Atleta a, int maxP){
	char * pontosc;
	int pontos=0,countP = 0;
	
	
	ListElem aux = a->listaOrdPontos->elems;

    while (aux != NULL && countP < maxP) {
        pontos += atoi((char*)aux->data);
        countP++;
        aux = aux->next;
    }
	pontosc = (char*)malloc(sizeof(char)*5);
	sprintf(pontosc,"%d",pontos);
						 
	return pontosc;
}

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
	char * cIden,*cNome;
	int nLinha=0,nColuna=0;
	//linha = lis->u.d2.s1;
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			linha = lis->u.d1.s2;
			cIden = NULL;cNome=NULL;
				while(linha->flag!=PScons_csv_Linha_Fim){
					
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);
					
					if(idTotal-nColuna==idIdentificador){//Se for um ID
						cIden = strdup(texto);
						if(cNome!=NULL)//Se ja lemos um Nome entao vamos tentar inserir
							{
							 if(procura_atleta(lAtletas,cIden)==0){//Se não existe entao inserimos
								 Atleta at = (Atleta)malloc(sizeof(NodoAtleta));
								 at->Identificador=strdup(texto);
								 at->Nome=strdup(cNome);
								 at->listaOrdPontos=List_Create(NULL,NULL);
								 List_Push(lAtletas,at);
								 free(cNome);
								 free(cIden);}
								}
							
					}
							
					if(idTotal-nColuna==idNome){//Se for um Nome
							cNome = strdup(texto);
						if(cIden!=NULL)//Se ja lemos um Id entao vamos tentar inserir
							{
							 if(procura_atleta(lAtletas,cIden)==0){//Se não existe entao inserimos
								 Atleta at = (Atleta)malloc(sizeof(NodoAtleta));
								 at->Identificador=strdup(cIden);
								 at->Nome=strdup(texto);
								 at->listaOrdPontos=List_Create(NULL,NULL);
								 List_Push(lAtletas,at);
								 free(cNome);
								 free(cIden);}
								}
					}
					
					
					linha = linha->u.d1.s1;	
					nColuna++;				
					}
					
			x = (char*)linha->u.d2.s1;
			texto=strdup(x);
			
			if(idTotal-nColuna==idIdentificador){//Se for um ID
					if(cNome!=NULL)//Se ja lemos um Nome entao vamos tentar inserir
						{
						 if(procura_atleta(lAtletas,cIden)==0){//Se não existe entao inserimos
							 Atleta at = (Atleta)malloc(sizeof(NodoAtleta));
							 at->Identificador=strdup(texto);
							 at->Nome=strdup(cNome);
							 at->listaOrdPontos=List_Create(NULL,NULL);
							 List_Push(lAtletas,at);
							 free(cNome);
							 free(cIden);}
							}
					else//Se ainda nao lemos o Nome entao fica guardado o ID
					cIden = strdup(texto);
			}
					
			if(idTotal-nColuna==idNome){//Se for um Nome
				if(cIden!=NULL)//Se ja lemos um Id entao vamos tentar inserir
					{
					 if(procura_atleta(lAtletas,cIden)==0){//Se não existe entao inserimos
						 Atleta at = (Atleta)malloc(sizeof(NodoAtleta));
						 at->Identificador=strdup(cIden);
						 at->Nome=strdup(texto);
						 at->listaOrdPontos=List_Create(NULL,NULL);
						 List_Push(lAtletas,at);
						 free(cNome);
						 free(cIden);}
						}
				else//Se ainda nao inseriu entao fica guardado o Nome
					cNome = strdup(texto);
			}
			
			
			
			
			
			
			nColuna=0;
				
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


int compara2Int(void* d1,void * d2){
     
    int n1 = (int )d1;
    int n2 = (int )d2;
     
    
     
    if (n1>n2)
        return -1;
    else if (n1<n2)
        return 1;
    else
        return 0;
     
     
}


int procura_atleta(List lAtletas,char*atleta){
	Atleta a = List_Search(lAtletas,*compara2IdsAtleta,atleta);
	if(a ==NULL)
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


	
void update_ListaResultados(){
	
	
	lista_ResTotal = List_Create(NULL,*compara2scoresAtleta);
	List lista_Temp = List_Create(NULL,NULL);
	
	
	List resLista [lista_Atletas->totalCount];//matriz da lista dos tempos dos atletas com a ordem que veem da lista_Atletas
	int i = 0;
	//inicializa a matriz
	for(i=0;i<lista_Atletas->totalCount;i++)
		resLista[i] = List_Create(NULL,*compara2Int);
	
	
	ListElem aux = lista_Resultados->elems;
    while (aux != NULL) {// Lista das Provas
		List l = (List)aux->data;
		ListElem le2 = l->elems;	
		//printf("  l=%d\n",l->totalCount);
		while (le2 != NULL) {//Lista dos Resultados individuais
			
			
			List l2 = (List)le2->data;// Resultado+Identificador+... do Atleta
			
			//FALTA O MEGA IF PARA QUANDO O IDENTIFICADOR APARECER DEPOIS DO TEMPO
		
		
			ListElem le1=l2->elems;
			char * id = (char*) le1->data;
			le1=le1->next;
			char * pontos = (char*)le1->data;
			
			//faz copia dos valores
			char * cid=strdup(id);
			char * cpontos=strdup(pontos);
			
			//printf("   l2=%d id=%s pontos=%s\n",l2->totalCount,cid,cpontos);
			
			
			ListElem laux = lista_Temp->elems;
			int inserido = 0;
			
			while (laux != NULL&& inserido == 0) {//Percorrer a Lista dos Resultados Totais e fazer a soma dos pontos
				//List li = (List)laux->data;
				//ListElem lie2 = li->elems;	
				//printf("res_%s\n",(char*)lie2->data);
				Atleta atl = NULL;
				atl = (Atleta)laux->data;

				if(atl != NULL)
				 if (strcmp(atl->Identificador, cid)==0)//Ser for este atleta
					{List_InsertOrd(atl->listaOrdPontos,cpontos,*compara2scoresChar);//Insere os Pontos de forma ordenada
					 inserido = 1;}
				 
				
					laux = laux->next;
			}
			if(inserido==0)//Se nao tem ainda la esse Atleta
				{//Criar a Lista do Resultado do Atleta e inserir na lista final para somar pontos
				Atleta at= (Atleta)malloc(sizeof(NodoAtleta));
				char * NomeA = getNomeAtletabyId(lista_Atletas,cid);
				if(NomeA!=NULL)
					at->Nome = strdup(NomeA);
				else
					at->Nome = strdup("NOME");
				at->listaOrdPontos = List_Create(NULL,*compara2scoresChar);
				at->Identificador=strdup(cid);
				List_Push(at->listaOrdPontos,cpontos);
				List_Push(lista_Temp,at);}
			
			le2=le2->next;}//Iterar Resultados Individuais
        
        aux = aux->next;//Iterar Provas
    }
    
    //Agora inserir com Ordenacao por Pontos na ResTotal
    
	
	ListElem taux = lista_Temp->elems;

    while (taux != NULL) {
		Atleta lisAt = (Atleta)taux->data;
		char * pontos = calcPontosAtleta(lisAt,numeroMelhorProvas);
		Atleta novo = (Atleta)malloc(sizeof(NodoAtleta));
		novo->Nome = lisAt->Nome;
		novo->Identificador=lisAt->Identificador;
		novo->listaOrdPontos= List_Create(NULL,NULL);
		List_Push(novo->listaOrdPontos,pontos);
		
        List_InsertOrd(lista_ResTotal,novo,*compara2scoresAtleta);
        taux = taux->next;
    }
}	


void print_Ranking(List lr){
	if (lr==NULL)
		return;
		
	ListElem aux = lr->elems;
	printf("------------------------\nRanking de %d Atletas\n\n",lr->totalCount);
		int posicao = 1;
    while (aux != NULL) {
		Atleta a = (Atleta)aux->data;
		List l = a->listaOrdPontos;
		ListElem le1 = l->elems;
	
		char * pontos = (char*) le1->data;

		printf("%d - %s pontos | %s (%s)\n",posicao,pontos,a->Nome,a->Identificador);
		
		printf("\n--------------\n");
        posicao++;
        aux = aux->next;
    }
	
}	
	
void print_Lista(List lr){
	if (lr==NULL)
		return;
		
	ListElem aux = lr->elems;
	printf("l=%d\n",lr->totalCount);
		
    while (aux != NULL) {
		List l = (List)aux->data;
		ListElem le1 = l->elems;	
		while (le1 != NULL) {
			char * c1 = (char*) le1->data;
			le1=le1->next;
			char * c2 = (char*)le1->data;
			
			printf("id=%s,pontos=%s\n",c1,c2);
			le1=le1->next;}printf("\n--------------\n");
        
        aux = aux->next;
    }
	
}	


void print_ListaResultados(){
	
	ListElem aux = lista_Resultados->elems;
	printf("lista_Resultados=%d\n",lista_Resultados->totalCount);
		
    while (aux != NULL) {
		List l = (List)aux->data;
		ListElem le1 = l->elems;	
		while (le1 != NULL) {
			List l1 = (List)le1->data;
			ListElem le2 = l1->elems;
			char * c1 = (char*) le2->data;
			le2=le2->next;
			char * c2 = (char*)le2->data;
			
			printf("id=%s,pontos=%s\n",c1,c2);
			le1=le1->next;}
			printf("\n--------------\n");
        
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
        aux = aux->next;
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


int compara2IdsAtleta(void* d1,void * d2){// d1 é um Atleta (da Lista) e d2 é o char* (Identificador)
    
    Atleta l1 = (Atleta)d1;
     
    char* c1= l1->Identificador;
    char * c2= (char*)d2;
    
    int s = strcmp(c1,c2);
    if (s==0)
        return 1;
    else 
        return 0;
     
}

int compara2scoresAtleta(void* d1,void * d2){
    
    Atleta l1 = (Atleta)d1;
    Atleta l2 = (Atleta)d2;
     
    int n1 = atoi((char*)l1->listaOrdPontos->elems->data);
    int n2 = atoi((char*)l2->listaOrdPontos->elems->data);
     
    if (n1>n2)
        return -1;
    else if (n1<n2)
        return 1;
    else
        return 0;
     
}

int compara2scoresChar(void* d1,void * d2){
     
    char* l1 = (char*)d1;
    char* l2 = (char*)d2;
     
    int n1 = atoi(l1);
    int n2 = atoi(l2);
     
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
	char * texto, *iden,*pontos;
	int seg;
	
	int nLinha=0,nColuna=0;
	int tempomelhor=getTempoMelhor(lis);
	printf("melhor=%d\nlt=%d\n",tempomelhor,provas->totalCount);
	List resprova=List_Create(NULL,*compara2scores);
	
	
	//linha = lis->u.d2.s1;
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			linha = lis->u.d1.s2;
			
				while(linha->flag!=PScons_csv_Linha_Fim){
					
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);

					if(idTotal-nColuna==idIdentificador)
						 iden=strdup(texto);
					else if(idTotal-nColuna==idTempo)
						{seg = tempo2segundos(texto);
						 pontos = (char*)malloc(sizeof(char)*4);
						 sprintf(pontos,"%d",pontuacao(tempomelhor,seg));
						 }

					linha = linha->u.d1.s1;	
					nColuna++;				
					}
				x = (char*)linha->u.d2.s1;
				texto=strdup(x);

				if(idTotal-nColuna==idIdentificador)
					iden=strdup(texto);
				else if(idTotal-nColuna==idTempo)
					{seg = tempo2segundos(texto);
					 pontos = (char*)malloc(sizeof(char)*4);
				     sprintf(pontos,"%d",pontuacao(tempomelhor,seg));
					 }
				
				nColuna=0;
					
				lis = lis->u.d1.s1;	
				nLinha++;
				
				 printf("id=%s,pontos=%s,seg=%d\n",iden,pontos,seg);
				List score= List_Create(NULL,NULL);
				List_Push(score,iden);
				List_Push(score,pontos);
				List_InsertOrd(resprova,score,*compara2scores);
			}
			
		int r = List_Push(provas,resprova);
	
		
}


List getNProva (List lista,int n){
	if(n<=0 || n>numeroProvas)
		{printf("ERRO : Prova inexistente\n");return NULL;}
	else if(n>lista->totalCount && n<numeroProvas)
			{printf("ERRO : Prova ainda foi carregada\n");return NULL;}
		
	int count = 1;
	ListElem aux = lista->elems;

    while (aux != NULL) {
        if(count == n)
			return (List)aux->data;
        count++;
        aux = aux->next;
    }
	return NULL;
}

List split(char* mensagem, char* sep){
    List res = List_Create(NULL,NULL);
    
    char *p = strtok(mensagem, sep);
    while(p != NULL) {
        List_Push(res,p);
        p = strtok(NULL, sep);
    }
    
    return res;
}


