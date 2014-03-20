%{

#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>


void initLaTeX ();

void tituloL(char * titulo);

void autoresL(char * autores);

void fimdecapaL();

void newpageL();

void paragrafoL();

void listafigL();

void tableconL();

void italicoL(char * texto);

void negritoL(char * texto);

void sublinhadoL(char * texto);

void nisL(char * texto);

void sectionL(char * texto,char nivel);

void fimL();




int estado=1;
int ultimoEstado;
int estados[100];
int apontaEstados=0;


int _modoHTML=0;
int _modoLatex=0;



%}

/*   1      2        3         4          5        6       7     8      9    10     11    */
%x NORMAL NEGRITO ITALICO SUBLINHADO COMENTARIO VERBATIM LISTA TABELA IMAGEM NIS FOOTNOTE


%%
BEGIN NORMAL;
estado=NORMAL;

<*>\\init\\							BEGIN NORMAL;
<*>\\eof\\								printf("ACABOU O FICHEIRO!!\n");
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,VERBATIM,LISTA,TABELA,IMAGEM>\n 									;

<*>\\fim\\							{ultimoEstado = estados[apontaEstados];
								     if(apontaEstados>0) apontaEstados--;
								     
									 switch(ultimoEstado)
									 {
									 	case 2: 
									 	printf("}");
									 	break;
									 	case 3:
									 	printf("}");
									 	break;
									 	case 4:
									 	printf("}");
									 	break;
									 	case 5:
									 	printf("</coment>");
									 	break;
									 	case 10:
									 	printf("}}}");
									 	break;
									 	case 11:
									 	printf("</footnote>");
									 	break;
									 	default:
									 	break;
									 }
									 
 									 ultimoEstado= estados[apontaEstados];
									 BEGIN ultimoEstado;
									}

<NORMAL>\\titulo\\.*\n				tituloL(yytext+8);
<NORMAL>\\autores\\.*\n				autoresL(yytext+9);
<NORMAL>\\sec[1-3]\\.*\n			sectionL(yytext+6,yytext[4]);
<NORMAL>\\lo\\[^\\]*				printf("%s\n",yytext+4);
<NORMAL>\\li\\[^\\]*				printf("%s\n",yytext+4);
<NORMAL>\\item\\[^\\]*				printf("%s\n",yytext+4);
<NORMAL>\\nl\\						paragrafoL();

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\n\\[^\\]*					{BEGIN NEGRITO;
																			 estado=NEGRITO;
																			 
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 negritoL(yytext+3);
																	 		}

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\i\\[^\\]*					{BEGIN ITALICO;
																			 estado=ITALICO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 italicoL(yytext+3);
																	 		}

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\s\\[^\\]*					{BEGIN SUBLINHADO;
																			 estado=SUBLINHADO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 sublinhadoL(yytext+3);
																	 		}

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\nis\\[^\\]*				{BEGIN NIS;
																			 estado=NIS;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 nisL(yytext+5);
																	 		}

<*>\\%\\[^\\]*																{BEGIN COMENTARIO;
																			 estado=COMENTARIO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("<coment>%s",yytext+3);
																	 		}

<*>\LaTeX\																	printf("\\Latex");

<*>\tab\																	printf("\\vspace{10 mm}");

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA,NIS>\\hlink\\				printf("\\link");

<NORMAL>\\data\\															printf("|data de hoje|\n");

<NORMAL>\\fimdecapa\\														{fimdecapaL();newpageL();}

<NORMAL>\\indice\\															printf("tableofcontents\n");

<NORMAL>\\indiceimg\\														printf("listoffigures\n");

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA,NIS>\\footnote\\[^\\]*		{BEGIN FOOTNOTE;
																			 estado=FOOTNOTE;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("<footnote>%s",yytext+10);
																	 		}
%%




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
	else printf("---ERRO NA DEFINIÇÃO DE UMA SECÇÂO---\n");
}


void fimL(){
	printf("\\end{document}\n");
}























int main(int argc, char* argv[]){
	
	
estados[0]=1;
	
	if(argc<2 || argc >4 || argc==3){
		printf("Padrão desconhecido:\n\nArgumentos válidos:\n");
		printf(" lexLuthor -l -o nome\n");
		printf(" lexLuthor -h -o nome\n");
		printf(" lexLuthor -l\n");
		printf(" lexLuthor -h\n");
		printf(" lexLuthor -lh -o nome\n");
		printf(" lexLuthor -hl -o nome\n");
		printf(" lexLuthor -lh\n");
		printf(" lexLuthor -hl\n");
	} else {
		if(argc==4){//tem 4 args ou seja tem output
		
			if(strcmp(argv[2],"-o"))
				{
					printf("Terceiro parâmetro não é -o\n");
					return -1;
				}
			char * fileout=strdup(argv[3]);
			
			int file = open(fileout, O_WRONLY | O_CREAT, 0777);
			if(file < 0)    return 1;
		 
			if(dup2(file,1) < 0)    return 1;
		}
		
		if(strcmp(argv[1],"-h")==0)
		{
			_modoHTML=1;
			printf("____-HTML-____\n");
		}

		else if(strcmp(argv[1],"-l")==0){
			_modoLatex=1;
			initLaTeX();
		}
		else if(strcmp(argv[1],"-lh")==0 || strcmp(argv[1],"-hl")==0){
			_modoHTML=1;
			_modoLatex=1;
			printf("____-LaTeX e HTML-____\n");
		}

		else return -1;//nao é válido -l ou -h

		
		yylex();
		
		if(_modoLatex)
			fimL();
	}
	

	return 0;
}

int yywrap()
{
  return 1;
}
