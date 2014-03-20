#include <stdio.h>
int main(){return 0;};

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

printf("\\usepackage[algoruled]{algorithm2e}\n");

printf("\\usepackage[usenames,dvipsnames]{color}\n");

printf("\\begin{document}\n\n");
	
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
	printf("\\textit{%s}",texto);
}

void negritoL(char * texto){
	printf("\\textbf{%s}",texto);
}

void sectionL(char * texto,int nivel){
	switch nivel{
	case 1:	printf("\\section{%s}",texto);break;
	case 2:	printf("\\subsection{%s}",texto);break;
	case 3:	printf("\\subsubsection{%s}",texto);break;
	default:break;	
}	

void fimL(){
	printf("\\end{document}\n");
}

}



