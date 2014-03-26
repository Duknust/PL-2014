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


char * tabelaL(char * texto){
	char *temp = (char *) malloc ((50) * sizeof (char));
	strcat(temp,"\\begin{table}\n\\begin{tabular}{");
	char * numero = strdup(texto);
	numero[strlen(texto)-2]='\0';
	int tamanho=strlen("\\begin{table}\n\\begin{tabular}{");
	int ncol = atoi(numero);

	//printf("temp=%s...",texto);

	int i;
	for(i = 0;i<2*ncol;i+=2)
		{temp[i+tamanho]=texto[strlen(texto)-2];
		 if(i+2!=2*ncol)temp[i+tamanho+1]='|';}

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
	return "\\end{table}\n";
}

/*\begin{table}
 	\begin{tabular}{lll}   
    \hline
    ~ & ~ & ~ \\
    ~ & ~ & ~ \\
    ~ & ~ & ~ \\
    ~ & ~ & ~ \\
    \end{tabular}
	\end{table}*/
