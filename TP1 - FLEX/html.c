#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "html.h"

void initHTML (FILE * html_file){
	fprintf(html_file,"<html>");
    fprintf(html_file,"<head>");
    fprintf(html_file,"<title>O bo tem mel</title>");
    fprintf(html_file,"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>");
    fprintf(html_file,"<link type=\"text/css\" rel=\"stylesheet\" href=\"css/ink.css\">");
	fprintf(html_file,"<body>");
}

char * tituloH(char * titulo){
	char *temp = (char *) malloc ((10+strlen(titulo)) * sizeof (char));
	sprintf(temp,"<h1>%s</h1>\n",titulo);
	return temp;
}

char * autoresH(char * autores){
	char *temp = (char *) malloc ((10+strlen(autores)) * sizeof (char));
	sprintf(temp,"<h4>%s</h4>\n",autores);
	return temp;
}

char * newpageH(){
	return "";
}

char * paragrafoH(){
	return "<br>";
}

char * tableconH(){
	return "\\tableofcontents\n";
}

char * listafigH(){
	return "\\listoffigures\n";
}

char * italicoH(char * texto){
	char *temp = (char *) malloc ((10+strlen(texto)) * sizeof (char));
	sprintf(temp,"<i>%s",texto);
	return temp;
}

char * negritoH(char * texto){
	char *temp = (char *) malloc ((10+strlen(texto)) * sizeof (char));
	sprintf(temp,"<b>%s",texto);
	return temp;
}

char * sublinhadoH(char * texto){
	char *temp = (char *) malloc ((13+strlen(texto)) * sizeof (char));
	sprintf(temp,"<u>%s",texto);
	return temp;
}

char * nisH(char * texto){
	char *temp = (char *) malloc ((35+strlen(texto)) * sizeof (char));
	sprintf(temp,"<b><u><i>%s",texto);
	return temp;
}

char * sectionH(char * texto,char nivel){
	
	char *temp = (char *) malloc ((20+strlen(texto)) * sizeof (char));
	
	if(nivel=='1')
		sprintf(temp,"<h2>%s<h2>\n",texto);
	else if(nivel=='2')
		sprintf(temp,"<h3>%s</h3>\n",texto);
	else if(nivel=='3')
		sprintf(temp,"<h4>%s</h4>\n",texto);
	
	return temp;
}

char * fimH(){
	return "</body></html>";
}


char * legendaH(char * texto){
	char *temp = (char *) malloc ((13+strlen(texto)) * sizeof (char));
	sprintf(temp,"\\caption{%s",texto);
	return temp;
}


char * tabelaH(char * texto){

//	printf("_%s_\n",texto);
	
	// 5c,t:50,l:bo tem mel na tabelaz\

	int i,textolen = strlen(texto),tlen,encontrado=0,offsetlegenda=0,offsettamanho=0;
	
	
	texto[strlen(texto)-1]='\0';
	int ncol = atoi(texto);

	
	
	char align;
	encontrado=0;
	for(i=1;i<textolen && encontrado==0;i++)
		if(texto[i]==',')
			{align=(texto[i-1]);encontrado=1;}
	
	
	char *temp = (char *) malloc ((200+strlen(texto)) * sizeof (char));
	strcat(temp,"\\begin{table}[!h]\n");
	
	
	char ratio[10];
	tlen = strlen(&texto[i]);
	char * len = &texto[i+2];
	
	encontrado=0;
	for(i=0;i<tlen && encontrado==0;i++)
		if(len[i]!=',')
			ratio[i]=len[i];
		else
			encontrado=1;
	ratio[i-1]='\0';
	
	
	//printf("temp:%s...\n",temp);
	
	
	
	encontrado=0;
	for(i=1;i<textolen && encontrado==0;i++)
		if(texto[i]=='l')
			if(texto[i+1]==':')
				{offsetlegenda=i+1;encontrado=1;}
	
	
	char * legenda = &texto[offsetlegenda+1];
	
	strcat(temp,"\\caption{");
	strcat(temp,legenda);
	strcat(temp,"}\n");
	
	
			
	strcat(temp,"\\scalebox{");
	strcat(temp,ratio);
	strcat(temp,"}\n");
	
	
	
	
	
	
	strcat(temp,"\n\\begin{tabular}{");
	
	
	
	//\\begin{tabular}{");
	char * numero = strdup(texto);
	int tamanho = strlen(temp);
	temp[tamanho]='|';
	for(i = 1;i<4*ncol;i+=4)
		{temp[i+tamanho]=' ';
		 temp[i+tamanho+1]=align;
		 temp[i+tamanho+2]=' ';
		 temp[i+tamanho+3]='|';}

	strcat(temp,"}\n\\hline\n");


	return temp;
}

char * tabelalinhaH(char * texto){
	texto[strlen(texto)-1]='\0';
	char *temp = (char *) malloc ((15+strlen(texto)) * sizeof (char));
	strcat(temp,texto);
	strcat(temp,"\\\\ \\hline\n");
	
	//printf("_%s_\n",temp);
	temp[strlen(texto)+14]='\0';
	
	
	return temp;
}

char * fimtabelaH(){
	return "\\end{tabular}\n\\end{table}\n";
}



char * itemH(char * texto){
	//printf("_%s_%d_\n",texto,strlen(texto));
	texto[strlen(texto)-2]='\0';
	char *temp = (char *) malloc ((8+strlen(texto)) * sizeof (char));
	
	sprintf(temp,"\\item %s",texto);
	
	return temp;
}


char * liH(){	
	return "\\begin{itemize}\n";
}

char * loH(){	
	return "\\begin{enumerate}\n";
}



char * corH(char * texto){
	//printf("_%s_%d_\n",texto,strlen(texto));
//	texto[strlen(texto)-2]='\0';
	
	int encontrado=0,i;
	for(i=0;i<strlen(texto) && encontrado==0;i++)
		if(texto[i]=='\\')
			encontrado=1;
	
	char *cor = strdup(texto);
	strcat(cor,texto);
	cor[i-1]='\0';
	//printf("cor:%s_\n",cor);
	
	texto+=i;
	
	char *temp = (char *) malloc ((15+i) * sizeof (char));
	
	
	if(strcmp(cor,"vermelho")==0)
		sprintf(temp,"<font color=\"red\">%s",texto);
	else if(strcmp(cor,"azul")==0)
		sprintf(temp,"<font color=\"aqua\">%s",texto);
	else if(strcmp(cor,"rosa")==0)
		sprintf(temp,"<font color=\"HotPink\">%s",texto);
	else if(strcmp(cor,"verde")==0)
		sprintf(temp,"<font color=\"Green\">%s",texto);
	else if(strcmp(cor,"amarelo")==0)
		sprintf(temp,"<font color=\"Gold\">%s",texto);
	else if(strcmp(cor,"laranja")==0)
		sprintf(temp,"<font color=\"Orange\">%s",texto);
	else if(strcmp(cor,"violeta")==0)
		sprintf(temp,"<font color=\"Violet\">%s",texto);
	else if(strcmp(cor,"cinzento")==0)
		sprintf(temp,"<font color=\"Silver\">%s",texto);
	else if(strcmp(cor,"castanho")==0)
		sprintf(temp,"<font color=\"Sienna\">%s",texto);
	
	//printf("temp:%s_\n",temp);
	
	return temp;
}





