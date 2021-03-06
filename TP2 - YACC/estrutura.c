#include "estrutura.h"
extern FILE * csvin;
extern FILE * confin;

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


Atleta getAtletabyId(List lista, char* id){//Retorna o apontador para o Atleta de uma Lista de Atletas com o id
	
	int encontrado = 0;
	char * nome;
	ListElem aux = lista->elems;


    while (aux != NULL) {
        Atleta a = (Atleta)aux->data;
		if(strcmp(a->Identificador,id)==0)

			 return a;
        aux = aux->next;
    }
    return NULL;//Não tem esse ID na Lista
	
}

char * calcPontosAtleta(Atleta a, int maxP){
	char * pontosc;
	int pontos=0,countP = 0;
	
	

	ListElem aux = a->lista->elems;

    while (aux != NULL && countP < maxP) {
        pontos += atoi((char*)aux->data);
        countP++;
        aux = aux->next;
    }
	pontosc = (char*)malloc(sizeof(char)*5);
	sprintf(pontosc,"%d",pontos);
						 
	return pontosc;
}



void set_idTotal(ListaLinhas ll){
	//Fazer uma iteracao para contar o numero de campos
	ListaLinhas lis = ll;
	Linha linha;
	
	idTotal=1;
	linha = lis->u.d1.s2;
		
	while(linha->flag!=PScons_csv_Linha_Fim){
			linha = linha->u.d1.s1;	
			idTotal++;}
	
}



void set_NomesExtras(ListaLinhas ll){
	//Fazer uma iteracao para contar o numero de campos
	Linha linha,linha2;
	
	int id,id2;
	linha = ll->u.d2.s1;
		
	ListElem aux = lista_IdExtras->elems;
	List_Delete(lista_NomeExtras);
	lista_NomeExtras=List_Create();
    while (aux != NULL) {
        
        id = atoi((char*)aux->data);
        linha2=linha;
        id2 = idTotal;
        while(linha2->flag!=PScons_csv_Linha_Fim){
			if(linha2->u.d1.s2!=NULL)
			if(strcmp("\322\a",(char*)linha2->u.d1.s2)!=0){
			
				if(id==id2)
					List_Push(lista_NomeExtras,strdup((char*)linha2->u.d1.s2));
				id2--;
			}
			linha2 = linha2->u.d1.s1;	
			}
        aux = aux->next;
    }
		
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
	char * cIden;
	
	
	int nomesTodos;
	char* matrizNomes[4]={NULL};//200 atletas até 4 blocos de nomes
	int matrizIdNomes[4]={-1};//Contem os Indices dos Nomes
	ListElem aux = lista_IdnomesAtletas->elems;
	int totn = 0;
    while (aux != NULL) {
        matrizIdNomes[totn]=atoi((char*)aux->data);
        totn++;
        aux = aux->next;
    }
	
	
	int extrasTodos;
	char* matrizExtras[4]={NULL};//200 atletas até 4 blocos de nomes
	int matrizIdExtras[4]={-1};//Contem os Indices dos Extras
	aux = lista_IdExtras->elems;
	int tote = 0;
    while (aux != NULL) {
        matrizIdExtras[tote]=atoi((char*)aux->data);
        tote++;
        aux = aux->next;
    }
	
	
	int nLinha=0,nColuna=0,in;
	//linha = lis->u.d2.s1;
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			linha = lis->u.d1.s2;
			cIden = NULL;
			nomesTodos=0;
			extrasTodos=0;
				while(linha->flag!=PScons_csv_Linha_Fim){
					
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);
					
					
					
						//Se for um Nome
					if(idTotal-nColuna== matrizIdNomes[0])
						{matrizNomes[0] = strdup(texto);nomesTodos++;}
					else if(idTotal-nColuna== matrizIdNomes[1])
						{matrizNomes[1] = strdup(texto);nomesTodos++;}
					else if(idTotal-nColuna== matrizIdNomes[2])
						{matrizNomes[2] = strdup(texto);nomesTodos++;}
					else if(idTotal-nColuna== matrizIdNomes[3])
						{matrizNomes[3] = strdup(texto);nomesTodos++;}
						
						
						//Se for um Extra
					else if(idTotal-nColuna== matrizIdExtras[0])
						{matrizExtras[0] = strdup(texto);extrasTodos++;}
					else if(idTotal-nColuna== matrizIdExtras[1])
						{matrizExtras[1] = strdup(texto);extrasTodos++;}
					else if(idTotal-nColuna== matrizIdExtras[2])
						{matrizExtras[2] = strdup(texto);extrasTodos++;}
					else if(idTotal-nColuna== matrizIdExtras[3])
						{matrizExtras[3] = strdup(texto);extrasTodos++;}
						
						
					
					
					else if(idTotal-nColuna==idIdentificador)//Se for um ID
						cIden = strdup(texto);
							
								
							
						
					
					
					
					linha = linha->u.d1.s1;	
					nColuna++;				
					}
					
				x = (char*)linha->u.d2.s1;
				texto=strdup(x);
			
				//Se for um Nome
				if(idTotal-nColuna== matrizIdNomes[0])
					{matrizNomes[0] = strdup(texto);nomesTodos++;}
				else if(idTotal-nColuna== matrizIdNomes[1])
					{matrizNomes[1] = strdup(texto);nomesTodos++;}
				else if(idTotal-nColuna== matrizIdNomes[2])
					{matrizNomes[2] = strdup(texto);nomesTodos++;}
				else if(idTotal-nColuna== matrizIdNomes[3])
					{matrizNomes[3] = strdup(texto);nomesTodos++;}
					
				//Se for um Extra
				else if(idTotal-nColuna== matrizIdExtras[0])
					{matrizExtras[0] = strdup(texto);extrasTodos++;}
				else if(idTotal-nColuna== matrizIdExtras[1])
					{matrizExtras[1] = strdup(texto);extrasTodos++;}
				else if(idTotal-nColuna== matrizIdExtras[2])
					{matrizExtras[2] = strdup(texto);extrasTodos++;}
				else if(idTotal-nColuna== matrizIdExtras[3])
					{matrizExtras[3] = strdup(texto);extrasTodos++;}
				
				else if(idTotal-nColuna==idIdentificador)//Se for um ID
							cIden = strdup(texto);
							
						
							
								
							if(cIden!=NULL && nomesTodos==totn && extrasTodos==tote)//Se ja lemos um Id e os nomes todos e os Extras entao vamos tentar inserir
								{
								 if(procura_atleta(lAtletas,cIden)==0){//Se não existe entao inserimos
									 Atleta at = (Atleta)malloc(sizeof(NodoAtleta));
									 at->Identificador=strdup(cIden);
									 //Juntar os Nomes
									 char* nomecompleto = (char*)malloc(200);
								 
									 for(in=0;in<totn;in++)
										{strcat(nomecompleto,matrizNomes[in]);strcat(nomecompleto," ");
										 free(matrizNomes[in]);matrizNomes[in]=NULL;}
									 
									 at->Nome=nomecompleto;
									 at->lista=List_Create();
									 at->listaExtra=List_Create();
									 
									 
									 for(in=0;in<tote;in++)
										{List_Push(at->listaExtra,strdup(matrizExtras[in]));
										 free(matrizExtras[in]);matrizExtras[in]=NULL;}
									 
									 
									 List_Push(lAtletas,at);
									 free(cIden);}
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



	
void print_listaListaLinhas(){
	
	ListElem aux = listaListaLinhas->elems;

    while (aux != NULL) {
        print_ListaLinhas((ListaLinhas)aux->data);
        aux = aux->next;
    }
	
}	


	

void update_Ranking(){ // Actualiza o Ranking
	
	
	lista_Ranking = List_Create(NULL,*compara2scoresAtleta);
	List lista_Temp = List_Create();
	
	
	List resLista [lista_Atletas->totalCount];//matriz da lista dos tempos dos atletas com a ordem que veem da lista_Atletas
	int i = 0;
	//inicializa a matriz
	for(i=0;i<lista_Atletas->totalCount;i++)
		resLista[i] = List_Create(NULL,*compara2Int);
	
	
	ListElem aux = lista_Resultados->elems;
    while (aux != NULL) {// Lista das Provas
		Prova p = (Prova)aux->data;
		ListElem le2 = p->listaResultados->elems;	
		//printf("  l=%d\n",l->totalCount);
		while (le2 != NULL) {//Lista dos Resultados individuais
			
			Resultado r = (Resultado)le2->data;
			Atleta a = r->atleta;
			
			//FALTA O MEGA IF PARA QUANDO O IDENTIFICADOR APARECER DEPOIS DO TEMPO
		
		
			//faz copia dos valores
			char * cid=strdup(a->Identificador);
			char * cpontos=strdup(r->pontos);
			
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
					{List_InsertOrd(atl->lista,cpontos,*compara2scoresChar);//Insere os Pontos de forma ordenada
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
				at->lista = List_Create(NULL,*compara2scoresChar);
				at->Identificador=strdup(cid);
				List_Push(at->lista,cpontos);
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
		novo->lista= List_Create();
		List_Push(novo->lista,pontos);
		
        List_InsertOrd(lista_Ranking,novo,*compara2scoresAtleta);
        taux = taux->next;
    }
}	


void print_Ranking(List lr){
	if (lr==NULL)
		return;
		
	
	ListElem aux = lr->elems;
	
	if(lr->totalCount==0)
		{printf("Não há dados para calcular o Ranking\n");return;}
	
	printf("------------------------\nRanking de %d Atletas\n\n",lr->totalCount);
		int posicao = 1;
    while (aux != NULL) {
		Atleta a = (Atleta)aux->data;
		List l = a->lista;
		ListElem le1 = l->elems;
	
		char * pontos = (char*) le1->data;
		char c='\0';
		char d='\0';
		if(lista_Ranking->totalCount>1&& posicao<10)
		d=' ';
		if(strlen(pontos)==2)
			c=' ';
		printf("%c%d - %c%s pontos | %s (%s)\n",d,posicao,c,pontos,a->Nome,a->Identificador);
		
		
        posicao++;
        aux = aux->next;
    }
	printf("\n--------------\n");
}	



void print_RankingHTML(List lr,FILE * ficheiro){
	
	if (lr==NULL)
		{printf("ERRO no Ranking\n");return;}
	
	
	fprintf(ficheiro,"<p><b>Ranking : %s</b></p>\n\n",titulo);
	fprintf(ficheiro,"<table border=\"1\" style=\"width:600px\">\n<tbody>\n");
	fprintf(ficheiro,"<tr><th>Posicao</th><th>Identificador</th><th>Nome</th><th>Pontos</th></tr>\n");
	
	ListElem aux = lr->elems;
	
		int posicao = 1;
    while (aux != NULL) {
		Atleta a = (Atleta)aux->data;
		List l = a->lista;
		ListElem le1 = l->elems;
	
		char * pontos = (char*) le1->data;
		
		fprintf(ficheiro,"<tr><td>%d</td><td>%s</td><td>%s</td><td>%s</td></tr>\n",posicao,a->Identificador,a->Nome,pontos);
		
        posicao++;
        aux = aux->next;
    }
		
				
	fprintf(ficheiro,"</tbody></table>\n");
	
}


	void print_info(){
		if(estado==NAO_INICIADO)//Ainda não foi iniciado um Campeonato
			{printf("Campeonato ainda não carregado!\n");return;}
			
		printf("INFORMAÇÕES SOBRE O CAMPEONATO\n\n");
		printf("Nome: %s\n",titulo);
		printf("Número de Atletas: %d\n",lista_Atletas->totalCount);
		printf("Total de Provas: %d\n",numeroProvas);
		printf("Total de Provas Realizadas: %d\n",lista_Resultados->totalCount);
		printf("Número de Melhores Provas: %d\n",numeroMelhorProvas);
		char* melhor;
		if(lista_Ranking->elems!=NULL)
			melhor = (char*)((Atleta)lista_Ranking->elems->data)->Nome;
		else
			melhor = strdup("NENHUM (Prova não iniciada)\n");
		printf("Atleta Melhor Classificado: %s\n",melhor);
		
		printf("\n\n");
		print_Historico();
		}
	
	
	
void print_Prova(Prova p){
	if (p==NULL)
		return;
	int posicao=1;	
		
		List l = p->listaResultados;
		ListElem le1 = l->elems;	
		printf("------------------------\n Resultado da Prova : %s\n\n",p->nome);
	
		while (le1 != NULL) {
			Resultado c1 = (Resultado) le1->data;
			char c='\0';
			char d='\0';
			if(lista_Ranking->totalCount>1&& posicao<10)
				d=' ';
			if(strlen(c1->pontos)==2)
				c=' ';
			printf("%c%d - %c%s pontos | %s (%s)\n",d,posicao,c,c1->pontos,c1->atleta->Nome,c1->atleta->Identificador);
			le1=le1->next;
			posicao++;}
	printf("\n--------------\n");
}	

void print_ProvaHTML(Prova p,FILE * ficheiro){
	
	if (p==NULL)
		{printf("ERRO na Prova\n");return;}
		
	fprintf(ficheiro,"<p><b>Resultado da Prova : %s</b></p>\n\n",p->nome);
	fprintf(ficheiro,"<table border=\"1\" style=\"width:600px\">\n<tbody>\n");
	fprintf(ficheiro,"<tr><th>Posicao</th><th>Identificador</th><th>Nome</th><th>Pontos</th>");
	
	
	/*
	while (le1 != NULL) {
		Resultado c1 = (Resultado) le1->data;
		char c='\0';
		if(strlen(c1->pontos)==2)
			c=' ';
		fprintf(ficheiro,"<tr><td>%d</td><td>%s</td><td>%s</td><td>%s</td></tr>\n",posicao,c1->atleta->Identificador,c1->atleta->Nome,c1->pontos);
		le1=le1->next;
		posicao++;}*/
	
	ListElem lei0 = lista_NomeExtras->elems;	
	Atleta at ;
	
		
	while (lei0 != NULL) {
		fprintf(ficheiro,"<th>%s</th>",(char*)lei0->data);
		lei0= lei0->next;}
	fprintf(ficheiro,"</tr>\n");
	
	int posicao=1;
	
		List l = p->listaResultados;
		ListElem le1 = l->elems;	
		
		while (le1 != NULL) {
			Resultado c1 = (Resultado) le1->data;
			char c='\0';
			if(strlen(c1->pontos)==2)
				c=' ';
			fprintf(ficheiro,"<tr><td>%d</td><td>%s</td><td>%s</td><td>%s</td>",posicao,c1->atleta->Identificador,c1->atleta->Nome,c1->pontos);
			at = getAtletabyId(lista_Atletas,c1->atleta->Identificador);
			ListElem lei1 = at->listaExtra->elems;	
			while (lei1 != NULL) {
				fprintf(ficheiro,"<th>%s</th>",(char*)lei1->data);
				lei1= lei1->next;}
				
			fprintf(ficheiro,"</tr>\n");
			
			le1=le1->next;
			posicao++;}
			
	fprintf(ficheiro,"</tbody></table>\n");
	
}	


void print_ListaResultados(){
	
	ListElem aux = lista_Resultados->elems;
	//printf("lista_Resultados=%d\n",lista_Resultados->totalCount);
		
    while (aux != NULL) {
		Prova p = (Prova)aux->data;
		print_Prova(p);
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
	if(tempo_atleta==0)
		return 0;
	
	float tm = tempo_melhor*1.0;
	float ta = tempo_atleta*1.0;
	
	float f = (tm / ta * 100);
	//printf("%3f-%3f-%3f\n",tm,ta,f);
	return (int)f;
	
}

int compara2scoresResultados(void* d1,void * d2){
     
    Resultado l1 = (Resultado)d1;
    Resultado l2 = (Resultado)d2;

    int n1 = atoi((char*)l1->pontos);
    int n2 = atoi((char*)l2->pontos);
     
    if (n1>n2)
        return -1;
    else if (n1<n2)
        return 1;
    else
        return 0;
     
}

/*
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
*/

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

    int n1 = atoi((char*)l1->lista->elems->data);
    int n2 = atoi((char*)l2->lista->elems->data);
     
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
	int melhor=-1,seg;
	int nLinha=0,nColuna=0;
	//linha = lis->u.d2.s1;
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			linha = lis->u.d1.s2;
				while(linha->flag!=PScons_csv_Linha_Fim){
					
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);
					
					if(idTotal-nColuna==idTempo)
						{if(strcmp(texto,"DNF")==0)
							seg = 99999999;
						 else
							seg = tempo2segundos(texto);
						 if(melhor==-1 || melhor>seg)
							melhor=seg;
						 }
					
					linha = linha->u.d1.s1;	
					nColuna++;				
					}
				x = (char*)linha->u.d2.s1;
				texto=strdup(x);
				
				if(idTotal-nColuna==idTempo)
					{if(strcmp(texto,"DNF")==0)
							seg = 99999999;
					 else
						seg = tempo2segundos(texto);
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
	char * texto, *iden,*pontos,*tempo;
	int seg;
	
	int nLinha=0,nColuna=0;
	int tempomelhor=getTempoMelhor(lis);
	//printf("melhor=%d\nlt=%d\n",tempomelhor,provas->totalCount);
	
	
	Prova prov = (Prova)malloc(sizeof(NodoProva));
	char * nomeProva = getNnomeProva(lista_nomesProvas,listaListaLinhas->totalCount);
	if(nomeProva==NULL)
		prov->nome=strdup("NOME DA PROVA");
	else
		prov->nome=nomeProva;
	prov->listaResultados=List_Create();
				
	


		//Agora percorrer tudo
		while(lis->flag!=PScons_csv_ListaLinhas_Fim){
			linha = lis->u.d1.s2;
			
				while(linha->flag!=PScons_csv_Linha_Fim){
					
					x = (char*)linha->u.d1.s2;
					texto=strdup(x);
					if(idTotal-nColuna==idIdentificador)
						 iden=strdup(texto);
					else if(idTotal-nColuna==idTempo)
						{if(strcmp(texto,"DNF")==0 || strcmp(texto,"")==0)
							{tempo = strdup("DNF");
							 pontos = (char*)malloc(sizeof(char)*1);
							 sprintf(pontos,"%d",0);}
						else{
							 seg = tempo2segundos(texto);
							 tempo = strdup(texto);
							 pontos = (char*)malloc(sizeof(char)*4);
							 sprintf(pontos,"%d",pontuacao(tempomelhor,seg));}
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
					 tempo = strdup(texto);
					 pontos = (char*)malloc(sizeof(char)*4);
				     sprintf(pontos,"%d",pontuacao(tempomelhor,seg));
					 }
				
				nColuna=0;
					
				lis = lis->u.d1.s1;	
				nLinha++;
				
				 //printf("id=%s,pontos=%s,seg=%d\n",iden,pontos,seg);

				Atleta at = getAtletabyId(lista_Atletas,iden);//O Atleta que tem o ID daquele Resultado
				
				Resultado result = (Resultado)malloc(sizeof(NodoResultado));
				result->atleta= at;
				result->tempo=strdup(tempo);
				result->pontos=strdup(pontos);
				
				
				List_InsertOrd(prov->listaResultados,result,*compara2scoresResultados);
			}
			
		List_Push(provas,prov);
	
		
}



Prova getNProva (List lista,int n){
	if(n<=0 || n>numeroProvas)
		{printf("ERRO : Prova inexistente\n");return NULL;}
	else if(n>lista->totalCount && n<=numeroProvas)
			{printf("ERRO : Prova ainda foi carregada\n");return NULL;}

	int count = 1;
	ListElem aux = lista->elems;

    while (aux != NULL) {
        if(count == n)
			return (Prova)aux->data;
        count++;
        aux = aux->next;
    }
	return NULL;
}


char * getNnomeProva (List lista,int n){
	if(n<=0 || n>numeroProvas)
		{return NULL;}
	else if(n>lista->totalCount && n<=numeroProvas)
			{return NULL;}

	int count = 1;
	ListElem aux = lista->elems;

    while (aux != NULL) {
        if(count == n)
			return (char*)aux->data;
        count++;
        aux = aux->next;
    }
	return NULL;
}

List split(char* mensagem, char* sep){
    List res = List_Create();
    
    char *p = strtok(mensagem, sep);
    while(p != NULL) {
        List_Push(res,p);
        p = strtok(NULL, sep);
    }
    
    return res;
}



void initHTML (FILE * html_file, char * nome_prova){
	fprintf(html_file,"<html>");
    fprintf(html_file,"<head>");
    fprintf(html_file,"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>");
    fprintf(html_file,"<title>%s</title>",nome_prova);
	fprintf(html_file,"\n</head>\n<body>\n\n");
}

void fimHTML(FILE * html_file){
	fprintf(html_file, "\n\n</body></html>");
}


void print_lAtletas(){
	
	char * nome;
	ListElem aux = lista_Atletas->elems;


    while (aux != NULL) {
        Atleta a = (Atleta)aux->data;
		printf("-%s\n",a->Nome);
        aux = aux->next;
    }
	printf("---------------\n");
}



void load_c_result(char *ficheiro){
	
	if(lista_Resultados->totalCount>=numeroProvas){
		printf("O Campeonato já terminou : Já foram inseridas todas as Provas\n");
		return;}


	FILE * fich = fopen(ficheiro, "r");
	
	if(fich<=0){
		printf("ERRO : FICHEIRO INEXISTENTE\n");
		return;}
	
	csvin = fich;
	//printf("RESULT\n");
	(void)csvparse();
	//printf("Push na Lista\n");
	ListaLinhas ll = csvList;
	if(ll!=NULL)
		List_Push(listaListaLinhas,ll);
	else
		return;//discutir isto
		
	//printf("\ncount da listaListaLinhas=%d\n",listaListaLinhas->totalCount);
	
	set_idTotal(csvList);//Calcular sempre porque assim ate pode ter menos campos no fim desde que nao apanhe os importantes
	set_NomesExtras(csvList);
	insere_atletas(lista_Atletas,csvList);
	
	insere_Resultados(csvList,lista_Resultados);

	//print_ListaLinhas(csvList);
	//print_listaListaLinhas();
	//print_ListaResultados();
	
	print_Prova(getNProva(lista_Resultados,lista_Resultados->totalCount));
	
	update_Ranking();

	//HTML
	int nprova = listaListaLinhas->totalCount;
	char *c=(char*)malloc(sizeof(3));
	sprintf(c,"%d",nprova);
	char* nome = (char*)malloc(strlen(titulo)+35);
	strcpy(nome,titulo);
	strcat(nome,"_res");
	strcat(nome,c);
	strcat(nome,".html");
	FILE * html_file = fopen(nome, "w+");
	if(html_file < 0)
		printf("ERRO AO CRIAR O FICHEIRO: %s\n",nome);
	else
		{Prova pp = getNProva(lista_Resultados,lista_Resultados->totalCount); char * tituloP = pp->nome;
		 char * tit2 = (char*)malloc(strlen(tituloP)+strlen("Resultado da Prova: ")+1);strcat(tit2,"Resultado da Prova: ");strcat(tit2,tituloP);
	     initHTML(html_file,tit2);
		 print_ProvaHTML(getNProva(lista_Resultados,nprova),html_file);
		 fclose(html_file);}


	//Adicionar ao Historico
	List_Push(Historico,ficheiro);
	csvList = NULL;}
	
	
void save_db(char * nome){
	
	
FILE * fp;

fp = fopen(nome, "w+");
if (fp == NULL)
{printf("ERRO AO CRIAR O FICHEIRO:%s\n",nome);return;}


fprintf(fp,"%s\n",confActual);//Gravar o nome do Conf

char * nomef;
ListElem aux = Historico->elems;


    while (aux != NULL) {//Gravar o resto das Provas
        nomef = (char*)aux->data;
        fprintf(fp,"%s\n",nomef);
        aux = aux->next;
    }
fclose(fp);

saveActualizado=1;
printf("SAVE! Ficheiro gravado com o nome: %s\n",nome);

}


void load_db(char * nome){
	
FILE * fp;
char * line = NULL;
size_t len = 0;
ssize_t read;

fp = fopen(nome, "r");
if (fp == NULL)
{printf("ERRO AO LER O FICHEIRO:%s\n",nome);return;}


List_Delete(Historico);Historico = List_Create();


int linha = 1;
while ((read = getline(&line, &len, fp)) != -1) {
char * ficheiro;
ficheiro=strdup(line);

if(ficheiro[strlen(ficheiro)-1]=='\n')
ficheiro[strlen(ficheiro)-1]='\0';//Sacar o \n do fim
if(linha==1)//Primeira linha entao CONF
confActual=ficheiro;
else
List_Push(Historico,ficheiro);

//printf("%d-line=%s\n",linha,ficheiro);
linha ++;
}

if (line)
free(line);


//Actualizar o CONF
confin=fopen(confActual, "r");
(void)confparse();

//Recalcular tudo
reload_total();	

}

void print_Historico(){
	ListElem aux = Historico->elems;
	printf("Historico:\n");
	int pos = 1;
    while (aux != NULL) {
        printf("Prova %d -> %s\n",pos,(char*)aux->data);
        aux = aux->next;
        pos++;
    }
}






void ranking (char * ficheiro){
	
	update_Ranking();
	
	print_Ranking(lista_Ranking);// No ecra
	//HTML
	if(lista_Ranking->totalCount!=0){//Se há ranking
		   
		char* nome = (char*)malloc(strlen(ficheiro));
		strcpy(nome,ficheiro);
		nome++;
		nome[strlen(nome)-1]='\0';

		FILE * html_file = fopen(nome, "w+");
		if(html_file < 0)
			printf("ERRO AO CRIAR O FICHEIRO: %s\n",nome);
		else
			{char * tit2 = (char*)malloc(strlen(titulo)+strlen("Ranking Geral: ")+1);strcat(tit2,"Ranking Geral: ");strcat(tit2,titulo);
			 initHTML(html_file,titulo);
			 print_RankingHTML(lista_Ranking,html_file);
			 fimHTML(html_file);
			 fclose(html_file);}
	}//Se não o erro foi dado no print_Ranking
	
	
}


void reload_total(){
	
	//Aqui ja tenho o CONF pronto
	
	
	List_Delete(listaListaLinhas);listaListaLinhas = List_Create();
	List_Delete(lista_Atletas);lista_Atletas = List_Create();
	List_Delete(lista_Resultados);lista_Resultados = List_Create();
	List_Delete(lista_Ranking);lista_Ranking = List_Create();
//	List_Delete(Historico);Historico = List_Create();
	List_Delete(lista_nomesProvas);lista_nomesProvas= List_Create();
	List_Delete(lista_IdnomesAtletas);lista_IdnomesAtletas= List_Create();
	List_Delete(lista_IdExtras);lista_IdExtras= List_Create();
	List_Delete(lista_NomeExtras);lista_NomeExtras= List_Create();
	
	
	//Tratar o resto dos campos caso tenham sido preenchidos
	if(camposTemp!=NULL)//"6"
		{lista_IdExtras = split(camposTemp,",");
			}
			
	if(provasTemp!=NULL)//"Santa Isabel, Santa Isabel, Centro Historico, ..."
		lista_nomesProvas = split(provasTemp,",");
			
				
	if(defNomeTemp!=NULL)//"6, 5"
		lista_IdnomesAtletas = split(defNomeTemp,",");
			
  
	popUpdateHistorico();
	
}

void popUpdateHistorico(){
	//Percorrer o Historico e fazer inserts
	char * prova;
	ListElem aux = Historico->elems;
	int fim = Historico->totalCount;
	while (aux != NULL && fim>0) {
		prova = (char*)aux->data;
		load_c_result(prova);
		List_Pop(Historico);
		aux = aux->next;
		fim--;
	}
	
}



