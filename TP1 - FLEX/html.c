#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "html.h"

void initHTML (FILE * html_file){
	fprintf(html_file,"<html>");
    fprintf(html_file,"<head>");
    fprintf(html_file,"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>");
    fprintf(html_file,"<title>Luthor</title>");
    fprintf(html_file,"<link type=\"text/css\" rel=\"stylesheet\" href=\"css/ink.css\">");
	fprintf(html_file,"</head><body>");
	fprintf(html_file,"<div class=\"ink-grid\">");

}

char * tituloH(char * tit){
	
	char * titulo = strdup(tit);
	char *temp = (char *) malloc ((200+strlen(titulo)) * sizeof (char));

	if(titulo[strlen(titulo)-1]=='\n')
		titulo[strlen(titulo)-1]='\0';
		
	sprintf(temp,"<h1>%s</h1>\n<script type=\"text/javascript\">document.title = \"%s\"</script>\n",titulo,titulo);
	return temp;
}

char * autoresH(char * aut){
	char * autores = strdup(aut);
	char *temp = (char *) malloc ((10+strlen(autores)) * sizeof (char));
		if(autores[strlen(autores)-1]=='\n')
		autores[strlen(autores)-1]='\0';
		
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

char * italicoH(char * text){
	
	char * texto = strdup(text);
	char *temp = (char *) malloc ((10+strlen(texto)) * sizeof (char));
	sprintf(temp,"<i>%s",texto);
	return temp;
}

char * negritoH(char * text){
	char * texto = strdup(text);
	
	char *temp = (char *) malloc ((10+strlen(texto)) * sizeof (char));
	sprintf(temp,"<b>%s",texto);
	return temp;
}

char * sublinhadoH(char * text){
	
	char * texto = strdup(text);
	char *temp = (char *) malloc ((13+strlen(texto)) * sizeof (char));
	sprintf(temp,"<u>%s",texto);
	return temp;
}

char * nisH(char * text){
	
	char * texto = strdup(text);
	char *temp = (char *) malloc ((35+strlen(texto)) * sizeof (char));
	sprintf(temp,"<b><u><i>%s",texto);
	return temp;
}

char * sectionH(char * text,char nivel){
	
	char * texto = strdup(text);
	
	char *temp = (char *) malloc ((20+strlen(texto)) * sizeof (char));

	if(texto[strlen(texto)-1]=='\n')
		texto[strlen(texto)-1]='\0';
	
	if(nivel=='1')
		sprintf(temp,"<h2>%s</h2>\n",texto);
	else if(nivel=='2')
		sprintf(temp,"<h3>%s</h3>\n",texto);
	else if(nivel=='3')
		sprintf(temp,"<h4>%s</h4>\n",texto);
	
	return temp;
}

char * fimH(){
	return "</div></body></html>";
}


char * legendaH(char * text){
	
	char * texto = strdup(text);
	char *temp = (char *) malloc ((13+strlen(texto)) * sizeof (char));
	sprintf(temp,"\\caption{%s",texto);
	return temp;
}


char * tabelaH(char * texto){
	
	return "<table class=\"ink-table bordered alternating hover\">\n<tbody>\n";
}

char * tabelalinhaH(char * text){
	
	char * texto = strdup(text);
	
	char *temp = (char *) malloc ((200+strlen(texto)) * sizeof (char));
	strcat(temp,"<tr><td>");
	
	int encontrado=0,i;
	for(i=0;i<strlen(texto) && encontrado==0;i++)
		{
			if(texto[i]=='&')
				strcat(temp,"</td><td>");
			else if(texto[i]=='\\')
				encontrado=1;
			else
				temp[strlen(temp)]=texto[i];
		}
		
	strcat(temp,"</td></tr>\n");
	//printf("temp=_%s_\n",temp);
	
	
	return temp;
}

char * fimtabelaH(){
	return "</tbody></table>\n";
}



char * itemH(char * text){
	
	char * texto = strdup(text);
	
	
	char *temp = (char *) malloc ((8+strlen(texto)) * sizeof (char));
	
	sprintf(temp,"<li>%s",texto);
	
	return temp;
}


char * liH(){	
	return "<ul>\n";
}

char * loH(){	
	return "<ol>\n";
}



char * corH(char * text){
	
	char * texto = strdup(text);
	
	
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



char * imagemH(char * text){


	
	
	char * texto2 = strdup(text);

	int i,textolen = strlen(texto2),tlen,encontrado=0,offsetlegenda=0,offsettamanho=0;
	
	
	texto2[strlen(texto2)]='\0';
	int ncol = atoi(texto2);

	
	
	char align;
	encontrado=0;
	for(i=1;i<textolen && encontrado==0;i++)
		if(texto2[i]==',')
			{align=(texto2[i-1]);encontrado=1;}
	
	
	char *temp = (char *) malloc ((200+strlen(texto2)) * sizeof (char));

	
	strcat(temp,"<figure><img src=\"");
	
	
	texto2++;
	
	char ratio[10];
	tlen = strlen(texto2);
	char * len = texto2;
	
	
	
	
	encontrado=0;
	for(i=0;i<tlen && encontrado==0;i++)
		if(len[i]!=',')
			ratio[i]=len[i];
		else
			encontrado=1;
	ratio[i-1]='\0';
	
	
	
	
	
	
	
	char * pathimg;
	
	encontrado=0;
	for(i=1;i<textolen && encontrado==0;i++)
		if(texto2[i]=='l')
			if(texto2[i+1]==':')
				{offsetlegenda=i+1;encontrado=1;}
	while(texto2[i]!=',') i++;
	pathimg = &texto2[i+3];
	pathimg[strlen(pathimg)-1]='\0';
	texto2[i]='\0';

	char * legenda = &texto2[offsetlegenda+1];

	
	strcat(temp,pathimg);
	strcat(temp,"\"  alt=\"Imagem\" >\n<figcaption>");
	strcat(temp,legenda);
	strcat(temp,"</figcaption>\n");	
	
	




	return temp;
}

char * fimimagemH(){
	return "</figure>\n";
}

char * tabH(){
	return "<span style=\"padding: 0 40px\">&nbsp;</span>";
}

char * itemDH(char * texto){
	
 char *texto2 = strdup(texto);
 

 char *temp = (char *) malloc ((20+strlen(texto)) * sizeof (char));
 char *naoNeg = NULL;
 int encontrado=0;
 int i=0;
 for(i=0;i<strlen(texto2) && !encontrado;i++){
  if (texto2[i]=='|'){
   naoNeg = &texto2[i+1];
   texto2[i]='\0';
   encontrado=1;
  }
 }

 sprintf(temp,"<b>%s</b> <i>%s</i>\n <br>",texto2,naoNeg);
 
 return temp;

}


char * dicH(){	
	return "";
}


char * hlinkH(char * text){
	char * texto = strdup(text);
	char *temp = (char *) malloc ((10+strlen(texto)) * sizeof (char));

	
	char *nomelink = NULL;
 int encontrado=0;
 int i=0;
 for(i=0;i<strlen(texto) && !encontrado;i++){
  if (texto[i]=='|'){
   nomelink = &texto[i+1];
   texto[i]='\0';
   encontrado=1;
  }
 }

 sprintf(temp,"<a href=\"%s\">%s</a>",nomelink,texto);
	
	return temp;
}


char * citacaoH(char * text){
 
 char * texto = strdup(text);
 char *temp = (char *) malloc ((20+strlen(texto)) * sizeof (char));
 
 strcat(temp,"<q>");
 strcat(temp,texto);
 
 
 return temp;
}


char * dotsH(){
	return "...";
}

char * initResumoH(char * text){

 char * texto = strdup(text);
 char *temp = (char *) malloc ((22+strlen(texto)) * sizeof (char));
 
 strcat(temp,"<h2>Resumo</h2>\n");
 strcat(temp,texto);
	return temp;
}
