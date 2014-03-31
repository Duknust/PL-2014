#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "latex.h"


void initLaTeX (FILE * latex_file){
	fprintf(latex_file,"\\documentclass[11pt, a4paper, oneside]{article}\n");
	fprintf(latex_file,"\\usepackage[portuguese]{babel}\n");
	fprintf(latex_file,"\\usepackage{hyperref}\n");
	fprintf(latex_file,"\\hypersetup{colorlinks=true, urlcolor=blue, linkcolor=black}\n");
	fprintf(latex_file,"\\usepackage[utf8]{inputenc}\n");
	fprintf(latex_file,"\\usepackage{graphicx}\n");
	fprintf(latex_file,"\\graphicspath{{./imagens/}}\n");
	fprintf(latex_file,"\\usepackage[labelformat=simple]{caption}\n");
	fprintf(latex_file,"\\usepackage[labelformat=empty]{subcaption}\n");
	fprintf(latex_file,"\\usepackage{lastpage}\n");
	fprintf(latex_file,"\\usepackage{fancyhdr}\n");
	fprintf(latex_file,"\\pagestyle{fancy}\n");
	fprintf(latex_file,"\\usepackage{enumitem}\n");
	fprintf(latex_file,"\\usepackage{verbatim}\n");
	fprintf(latex_file,"\\usepackage[algoruled]{algorithm2e}\n");
	fprintf(latex_file,"\\usepackage[usenames,dvipsnames]{color}\n\n\n\n\n\n\n\n\n");
	fprintf(latex_file,"\\begin{document}\n");
}

char * tituloL(char * titulo){
	char *temp = (char *) malloc ((10+strlen(titulo)) * sizeof (char));
	sprintf(temp,"\\title{%s}\n",titulo);
	return temp;
}

char * autoresL(char * autores){
	char *temp = (char *) malloc ((10+strlen(autores)) * sizeof (char));
	sprintf(temp,"\\author{%s}\n",autores);
	return temp;
}

char * fimdecapaL(){
	return "\\maketitle\n";
}

char * newpageL(){
	return "\\newpage\n";
}

char * paragrafoL(){
	return "\\\\\n";
}

char * tableconL(){
	return "\\tableofcontents\n";
}

char * listafigL(){
	return "\\listoffigures\n";
}

char * italicoL(char * texto){
	char *temp = (char *) malloc ((10+strlen(texto)) * sizeof (char));
	sprintf(temp,"\\textit{%s",texto);
	return temp;
}

char * negritoL(char * texto){
	char *temp = (char *) malloc ((10+strlen(texto)) * sizeof (char));
	sprintf(temp,"\\textbf{%s",texto);
	return temp;
}

char * sublinhadoL(char * texto){
	char *temp = (char *) malloc ((13+strlen(texto)) * sizeof (char));
	sprintf(temp,"\\underline{%s",texto);
	return temp;
}

char * nisL(char * texto){
	char *temp = (char *) malloc ((35+strlen(texto)) * sizeof (char));
	sprintf(temp,"\\underline{\\textbf{\\textit{%s",texto);
	return temp;
}

char * sectionL(char * texto,char nivel){
	
	char *temp = (char *) malloc ((20+strlen(texto)) * sizeof (char));
	
	if(nivel=='1')
		sprintf(temp,"\\section{%s}\n",texto);
	else if(nivel=='2')
		sprintf(temp,"\\subsection{%s}\n",texto);
	else if(nivel=='3')
		sprintf(temp,"\\subsubsection{%s}\n",texto);
	
	return temp;
}

char * fimL(){
	return "\\end{document}\n";
}

char* tira_ns(char * texto){
	
	texto[strlen(texto)-2]='\0';
	return texto;
}

char * legendaL(char * texto){
	char *temp = (char *) malloc ((13+strlen(texto)) * sizeof (char));
	sprintf(temp,"\\caption{%s",texto);
	return temp;
}


char * imagemL(char * texto){

//	printf("_%s_\n",texto);
	
	// 5c,t:50,l:bo,c:dnfghm.jpg tem mel na tabelaz\

	int i,textolen = strlen(texto),tlen,encontrado=0,offsetlegenda=0,offsettamanho=0;
	
	
	texto[strlen(texto)-1]='\0';
	int ncol = atoi(texto);

	
	
	char align;
	encontrado=0;
	for(i=1;i<textolen && encontrado==0;i++)
		if(texto[i]==',')
			{align=(texto[i-1]);encontrado=1;}
	
	
	char *temp = (char *) malloc ((200+strlen(texto)) * sizeof (char));
	strcat(temp,"\\begin{figure}[!h]\n");
	strcat(temp,"\\centering\n");
	
	
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
	
	char * pathimg;
	
	encontrado=0;
	for(i=1;i<textolen && encontrado==0;i++)
		if(texto[i]=='l')
			if(texto[i+1]==':')
				{offsetlegenda=i+1;encontrado=1;}
	while(texto[i]!=',') i++;
	pathimg = &texto[i+3];
	texto[i]='\0';

	char * legenda = &texto[offsetlegenda+1];

	strcat(temp,"\\includegraphics[width=3.5in] {");
	strcat(temp,pathimg);
	strcat(temp,"}\n");	
	strcat(temp,"\\caption{");
	strcat(temp,legenda);
	strcat(temp,"}\n");
	
	//strcat(temp,"\\scalebox{");
	//strcat(temp,ratio);
	//strcat(temp,"}\n");




	return temp;
}


char * tabelaL(char * texto){

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

char * tabelalinhaL(char * texto){
	texto[strlen(texto)-1]='\0';
	char *temp = (char *) malloc ((15+strlen(texto)) * sizeof (char));
	strcat(temp,texto);
	strcat(temp,"\\\\ \\hline\n");
	
	//printf("_%s_\n",temp);
	temp[strlen(texto)+14]='\0';
	
	
	return temp;
}

char * fimtabelaL(){
	return "\\end{tabular}\n\\end{table}\n";
}

char * fimimagemL(){
	return "\\end{figure}\n";
}

char * itemL(char * texto){
	//printf("_%s_%d_\n",texto,strlen(texto));
	texto[strlen(texto)-2]='\0';
	char *temp = (char *) malloc ((8+strlen(texto)) * sizeof (char));
	
	sprintf(temp,"\\item %s",texto);
	
	return temp;
}


char * liL(){	
	return "\\begin{itemize}\n";
}

char * loL(){	
	return "\\begin{enumerate}\n";
}



char * corL(char * texto){
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
		sprintf(temp,"\\textcolor{%s}{%s","red",texto);
	else if(strcmp(cor,"azul")==0)
		sprintf(temp,"\\textcolor{%s}{%s","MidnightBlue",texto);
	else if(strcmp(cor,"rosa")==0)
		sprintf(temp,"\\textcolor{%s}{%s","WildStrawberry",texto);
	else if(strcmp(cor,"verde")==0)
		sprintf(temp,"\\textcolor{%s}{%s","Green",texto);
	else if(strcmp(cor,"amarelo")==0)
		sprintf(temp,"\\textcolor{%s}{%s","Goldenrod",texto);
	else if(strcmp(cor,"laranja")==0)
		sprintf(temp,"\\textcolor{%s}{%s","Orange",texto);
	else if(strcmp(cor,"violeta")==0)
		sprintf(temp,"\\textcolor{%s}{%s","Violet",texto);
	else if(strcmp(cor,"cinzento")==0)
		sprintf(temp,"\\textcolor{%s}{%s","Gray",texto);
	else if(strcmp(cor,"castanho")==0)
		sprintf(temp,"\\textcolor{%s}{%s","RawSienna",texto);
	
	//printf("temp:%s_\n",temp);
	
	return temp;
}





