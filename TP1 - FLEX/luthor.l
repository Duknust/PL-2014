%{

#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

/*funcoes de LATEX*/
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
char *tira_ns(char * texto);

/*stack que guarda os estados*/
int estado=1;
int ultimoEstado;
int estados[100];
int apontaEstados=0;

/*modo que o utilizador pretende compilar*/
int _modoHTML=0;
int _modoLatex=0;
int _modoEcran=0;

%}

/*definicao de todos os estados possiveis*/
/*   1      2        3         4          5        6       7     8      9    10     11     12   13    14   15*/
%x NORMAL NEGRITO ITALICO SUBLINHADO COMENTARIO VERBATIM LISTA TABELA IMAGEM NIS FOOTNOTE COR LINHA LATEX HTML


%%
	/* fim de tabs */
<*>\\fim\\																	{ultimoEstado = estados[apontaEstados];
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
																			 	case 6:
																			 	printf("</verbatim>");
																			 	break;
																			 	case 7:
																			 	printf("</lista>");
																			 	break;
																			 	case 8:
																			 	printf("</table>");
																			 	break;
																			 	case 9:
																			 	printf("</img>");
																			 	break;
																			 	case 10:
																			 	printf("}}}");
																			 	break;
																			 	case 11:
																			 	printf("</footnote>");
																			 	break;
																			 	case 12:
																			 	printf("</cor>");
																			 	break;
																			 	default:
																			 	break;
																			 }
																			 
										 									 ultimoEstado= estados[apontaEstados];
																			 BEGIN ultimoEstado;
																			}

	/*titulo*/
<NORMAL>\\titulo\\.*\n														tituloL(tira_ns(yytext+8));

	/*autores*/
<NORMAL>\\autores\\.*\n														autoresL(tira_ns(yytext+9));

	/*nivel de seccao (pode ser 1, 2 ou 3)*/
<NORMAL>\\sec[1-3]\\.*\n													sectionL(tira_ns(yytext+6),yytext[4]);

	/*lista ordenada*/
<NORMAL>\\lo\\[^\\]*														printf("%s\n",yytext+4);

	/*lista nao ordenada*/
<NORMAL>\\li\\[^\\]*														printf("%s\n",yytext+4);

	/*novo item*/
<NORMAL>\\item\\[^\\]*														printf("%s\n",yytext+4);

	/*apenas no LaTeX*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\jl\\						printf("<justL>%s",yytext+4);

	/*apenas no HTML*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\jh\\						printf("<justH>%s",yytext+4);

	/*apenas no HTML*/

	/*quebra de linha*/
<*>\\nl\\																	paragrafoL();
	
	/*negrito*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\n\\[^\\]*					{BEGIN NEGRITO;
																			 estado=NEGRITO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 negritoL(yytext+3);
																	 		}

	/*italico*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\i\\[^\\]*					{BEGIN ITALICO;
																			 estado=ITALICO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 italicoL(yytext+3);
																	 		}

	/*sublinhado*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\s\\[^\\]*					{BEGIN SUBLINHADO;
																			 estado=SUBLINHADO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 sublinhadoL(yytext+3);
																	 		}

	/*combinação de negrito, italico e sublinhado*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\nis\\[^\\]*				{BEGIN NIS;
																			 estado=NIS;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 if(_modoLatex) nisL(yytext+5);
																	 		 if(_modoHTML) nisH(yytext+5);
																	 		 if(_modoEcran) printf("nis{%s}\n", yytext+5);
																	 		}

	/*comentario*/
<*>\\%\\[^\\]*																{BEGIN COMENTARIO;
																			 estado=COMENTARIO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("<coment>%s",yytext+3);
																	 		}

	/*simbolo do latex*/
<*>\LaTeX\																	printf("\\Latex");

	/*tab*/
<*>\tab\																	printf("\\vspace{10 mm}");

	/*link*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA,NIS>\\hlink\\				printf("\\link");

	/*data do dia*/
<NORMAL>\\data\\															printf("|data de hoje|\n");

	/*fim de capa*/
<NORMAL>\\fimdecapa\\														{fimdecapaL();
																			 newpageL();
																			}
	/*indice*/
<NORMAL>\\indice\\															printf("tableofcontents\n");

	/*indice de imagens*/
<NORMAL>\\indiceimg\\														printf("listoffigures\n");

	/*nota de rodape*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA,NIS>\\footnote\\[^\\]*		{BEGIN FOOTNOTE;
																			 estado=FOOTNOTE;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("<footnote>%s",yytext+10);
																	 		}
	/*cores do texto*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA,NIS>\\(vermelho|verde|azul|amarelo|rosa)\\[^\\]*		{BEGIN COR;
																									 	 estado=COR;
																									 	 apontaEstados++;
																									 	 estados[apontaEstados]=estado;
																							 		 	 printf("<cor=%s>",yytext+6);
																							 			}

	/*texto nao formatado*/
<NORMAL,VERBATIM,TABELA>\\nf\[^\\]*											{BEGIN VERBATIM;
																		 	 estado=VERBATIM;
																		 	 apontaEstados++;
																		 	 estados[apontaEstados]=estado;
																 		 	 printf("<verbatim>%s",yytext+4);
																 			}

	/*começar tabela tabela*/
<NORMAL,TABELA>\tabela\[[0-9]+\,[0-9]+\](e|c|d)\\							{BEGIN TABELA;
																			 estado=TABELA;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																			 printf("\\begin{table} \begin{tabular}{lll}%s\n",yytext+8);
																			}

	/*inserir linha da tabela*/
<TABELA>\linha\[^\\]*														{BEGIN LINHA;
																			 estado=LINHA;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																			 printf("<linha>%s",yytext+7);
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

	/*omissao da quebra*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,VERBATIM,LISTA,TABELA,IMAGEM,NIS,FOOTNOTE,COR,LINHA,LATEX,HTML>\n 			;
<COMENTARIO>\nf													printf("%s",yytext);
	
<*>\sh\[^\\]*															{BEGIN HTML;
																		 estado=HTML;
																		 apontaEstados++;
																		 estados[apontaEstados]=estado;
																		 printf("<linha>%s",yytext+7);
																		}	

<*>\sl\[^\\]*															{BEGIN LATEX;
																		 estado=LATEX;
																		 apontaEstados++;
																		 estados[apontaEstados]=estado;
																		 printf("<linha>%s",yytext+7);
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
/*nunca acontece isto*/
	else printf("---ERRO NA DEFINIÇÃO DE UMA SECÇÂO---\n");
}

void fimL(){
	printf("\\end{document}\n");
}

char* tira_ns(char * texto){
	/*texto[strlen(texto)-1]='\0';*/
	int i=0;
	for(i=0;i<strlen(texto);i++)
		if(texto[i]=='\n')
			texto[i]='\0';
	return texto;
}





















int main(int argc, char* argv[]){
	
/*iniciar o lex no estado 1, estado NORMAL*/	
estados[0]=1;
BEGIN NORMAL;
	
/*Reconhecedor dos padroes suportados*/
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
		if(argc==4){/*tem 4 args ou seja tem output*/
		
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

		else return -1;/*nao é válido -l ou -h*/

/*execucao do lex*/
		yylex();

/*so coloca estiver em modo de latex*/
		if(_modoLatex && !_modoEcran)
			fimL();
		if(_modoHTML && !_modoEcran)
			fimH();
		if(_modoEcran){
			if(_modoLatex)
				fimL();
			else if(_modoHTML)
				fimH();
		}
	}

	return 0;
}
