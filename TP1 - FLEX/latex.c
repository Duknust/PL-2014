#include <stdio.h>
#include <string.h>
#include "latex.h"

void initLaTeX (){
	printf("\\documentclass[11pt, a4paper, oneside]{article}\n");
	printf("\\usepackage[portuguese]{babel}\n");
	printf("\\usepackage{hyperref}\n");
	printf("\\hypersetup{colorlinks=true, urlcolor=blue, linkcolor=black}\n");
	printf("\\usepackage[utf8]{inputenc}\n");
	printf("\\usepackage{graphicx}\n");
	printf("\\graphicspath{{./imagens/}}\n");
	printf("\\usepackage[labelformat=simple]{caption}\n");
	printf("\\usepackage[labelformat=empty]{subcaption}\n");
	printf("\\usepackage{lastpage}\n");
	printf("\\usepackage{fancyhdr}\n");
	printf("\\pagestyle{fancy}\n");
	printf("\\usepackage{enumitem}\n");
	printf("\\usepackage{verbatim}\n");
	printf("\\usepackage[algoruled]{algorithm2e}\n");
	printf("\\usepackage[usenames,dvipsnames]{color}\n\n\n\n\n\n\n\n\n");
	printf("\\begin{document}\n");
}

void tituloL(char * titulo){
	printf("\\title{%s}\n",titulo);
}

void autoresL(char * autores){
	printf("\\author{%s}\n",autores);
}

void fimdecapaL(){
	printf("\\maketitle\n");
}

void newpageL(){
	printf("\\newpage\n");
}

void paragrafoL(){
	printf("\\\\\n");
}

void tableconL(){
	printf("\\tableofcontents\n");
}

void listafigL(){
	printf("\\listoffigures\n");
}

void italicoL(char * texto){
	printf("\\textit{%s",texto);
}

void negritoL(char * texto){
	printf("\\textbf{%s",texto);
}

void sublinhadoL(char * texto){
	printf("\\underline{%s",texto);
}

void nisL(char * texto){
	printf("\\underline{\\textbf{\\textit{%s",texto);
}

void sectionL(char * texto,char nivel){
	if(nivel=='1')
		printf("\\section{%s}",texto);
	else if(nivel=='2')
		printf("\\subsection{%s}",texto);
	else if(nivel=='3')
		printf("\\subsubsection{%s}",texto);
}

void fimL(){
	printf("\\end{document}\n");
}

char* tira_ns(char * texto){
	
	texto[strlen(texto)-2]='\0';
	return texto;
}