%{

#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define KGRN  "\x1B[32m"
#define KNRM  "\x1B[0m"

/*stack que guarda os estados*/
int estado=1;
int ultimoEstado;
int estados[100];
int apontaEstados=0;

/*modo que o utilizador pretende compilar*/
int _modoHTML=0;
int _modoLatex=0;
int _modoEcran=0;
int _versionORhelp=0;

/*files a serem criados*/
FILE *html_file=NULL;
FILE *latex_file=NULL;

%}

/*definicao de todos os estados possiveis*/
/*   1      2        3         4          5        6       7     8      9    10     11     12   13    14   15     16   */
%x NORMAL NEGRITO ITALICO SUBLINHADO COMENTARIO VERBATIM LISTA TABELA IMAGEM NIS FOOTNOTE COR LINHA LATEX HTML LEGENDA


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
																			 	printf("\\end{comment}\n");
																			 	break;
																			 	case 6://verbatim
																			 	printf("}");																			 	break;
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
																			 	printf("}");//footnote>
																			 	break;
																			 	case 12://cor
																			 	printf("}");
																				case 16:
																			 	printf("</legenda>");
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
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\jl\\[^\\]*				printf("<justL>%s",yytext+4);

	/*apenas no HTML*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\jh\\[^\\]*	 			printf("<justH>%s",yytext+4);

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
																	 	//	 if(_modoHTML) nisH(yytext+5);
																	 		 if(_modoEcran) printf("nis{%s}\n", yytext+5);
																	 		}

	/*comentario*/
<*>\\%\\[^\\]*																{BEGIN COMENTARIO;
																			 estado=COMENTARIO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("\\begin{comment}%s",yytext+3);
																	 		}

	/*simbolo do latex*/
<*>\LaTeX\																	printf("\\LaTeX");

	/*tab*/
<*>\tab\																	printf("\\vspace{10 mm}");

	/*link*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA,NIS>\\hlink\\				printf("\\link");

	/*data do dia*/
<NORMAL>\\data\\															printf("\\today");

	/*fim de capa*/
<NORMAL>\\fimdecapa\\														{fimdecapaL();
																			 newpageL();
																			}

	/*indice*/
<NORMAL>\\indice\\															printf("\\tableofcontents\n");

	/*indice de imagens*/
<NORMAL>\\indiceimg\\														printf("\\listoffigures\n");

	/*nota de rodape*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA,NIS>\\footnote\\[^\\]*		{BEGIN FOOTNOTE;
																			 estado=FOOTNOTE;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("\\footnote{%s",yytext+10);
																	 		}
	/*cores do texto*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA,NIS>\\(vermelho|verde|azul|amarelo|rosa)\\[^\\]*		{BEGIN COR;
																									 	 estado=COR;
																									 	 apontaEstados++;
																									 	 estados[apontaEstados]=estado;
																							 		 	 printf("\\textcolor{red}{%s",yytext+10);
																							 			}

	/*texto nao formatado*/
<NORMAL,VERBATIM,TABELA>\\nf\[^\\]*											{BEGIN VERBATIM;
																		 	 estado=VERBATIM;
																		 	 apontaEstados++;
																		 	 estados[apontaEstados]=estado;
																 		 	 printf("\\begin{verbatim}%s",yytext+4);
																 			}

	/*começar tabela tabela*/
<NORMAL,TABELA>\tabela[0-9]+(l|c|d)\\										{BEGIN TABELA;
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



<COMENTARIO>\\nf															printf("%s",yytext);

<*>\legenda\[^\\]*															{BEGIN LEGENDA;
																			 estado=LEGENDA;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																			 printf("<legenda>%s",yytext+9);
																			}

	/*omissao da quebra*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,VERBATIM,LISTA,TABELA,IMAGEM,NIS,FOOTNOTE,COR,LINHA,LATEX,HTML,LEGENDA>\n 			;
	
	/*aparece apenas no HTML*/
<*>\sh\[^\\]*															{BEGIN HTML;
																		 estado=HTML;
																		 apontaEstados++;
																		 estados[apontaEstados]=estado;
																		 printf("<linha>%s",yytext+7);
																		}	
	/*aparece apenas no LaTeX*/
<*>\sl\[^\\]*															{BEGIN LATEX;
																		 estado=LATEX;
																		 apontaEstados++;
																		 estados[apontaEstados]=estado;
																		 printf("<linha>%s",yytext+7);
																		}	

	/*inserir imagem (path)*/
<*>\\imagem:[a-zA-Z0-9]*\\												{printf("IMAGEM!!!");}

	/*
	\begin{figure}[h] 
	\center 
	\includegraphics[width=10cm]{imagens/o... 
	\label{omeubrowser} 
	\caption{O meu browser} 
	\end{figure}*/

%%

int main(int argc, char* argv[]){
	
	/*iniciar o lex no estado 1, estado NORMAL*/	
estados[0]=1;
BEGIN NORMAL;
	
	/*Reconhecedor dos padroes suportados*/

	_versionORhelp=verificaArgs_callHelp(argc, argv);
	_versionORhelp=verificaArgs_callVersion(argc, argv);
	if (verificaArgs_ArgumentosOut(argc, argv)) {
		if(argc==4){ /*tem 4 args ou seja tem output*/
		
			if(strcmp(argv[2],"-o"))
				{
					printf("Terceiro parâmetro não é -o\n");
					return -1;
				}
			char * fileout=strdup(argv[3]);
			int file = open(fileout, O_WRONLY | O_CREAT, 0777);
			if(file < 0)	return 1;
		 
			if(dup2(file,1) < 0)	return 1;
		}

		if(strcmp(argv[1],"-h")==0)
		{
			_modoHTML=1; printf("h:%d",_modoHTML);
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

	/*execucao do lex*/
		if(_modoLatex || _modoHTML || _modoEcran)
			yylex();

	/*so coloca estiver em modo de latex*/
		if(_modoLatex && !_modoEcran)
			fimL();
		if(_modoHTML && !_modoEcran);
			//fimH();
		if(_modoEcran){
			if(_modoLatex)
				fimL();
			else if(_modoHTML)
				printf("fimH");
				//fimH();
		}
	} 

	if (_modoHTML==0 && _modoLatex==0 && _modoEcran==0 && _versionORhelp==0){
		printf("ERROR - maybe you need to use:\n");
		printf("--h or --help [all options and description]\n");
	} 
	return 0;
}



	/*Verifica se a invocação ocorreu com argumentos de help*/
int verificaArgs_callHelp(int argc, char* argv[]){
	int res = 0;
	if (argc==2 && (strcmp(argv[1],"--h")==0 || strcmp(argv[1],"--help")==0)){
		printf("\t lexLuthor -l -o [nome]\n");
		printf("\t lexLuthor -h -o [nome]\n");
		printf("\t lexLuthor -l\n");
		printf("\t lexLuthor -h\n");
		printf("\t lexLuthor -lh -o [nome]\n");
		printf("\t lexLuthor -hl -o [nome]\n");
		printf("\t lexLuthor -lh\n");
		printf("\t lexLuthor -hl\n");
		printf("\n\n");
		printf("\t\t --v or --version [version of LexLuthor]\n");
		printf("\t\t -l [only creats LaTeX output]\n");
		printf("\t\t -h [only creats HTML output]\n");
		printf("\t\t -o [to chose the output name]\n");
		res=1;
	}
	return res;
}

	/*Verifica se a invocação ocorreu com argumentos de versão*/
int verificaArgs_callVersion(int argc, char* argv[]){
	int res = 0;
	if (argc==2 && (strcmp(argv[1],"--v")==0 || strcmp(argv[1],"--version")==0)){
		printf("FlexLuthor version 3.2");
		printf(KGRN " Kryptonite");
		printf(KNRM "\nCreated by Duarte Duarte and Fábio Gomes\nProduct from BananaCorp®\n");
		res=1;
	}
	return res;
}

	/*Verifica se a invocação ocorreu com argumentos de criação de ficheiro*/
int verificaArgs_ArgumentosOut(int argc, char* argv[]){
	int res = 0;
	if (argc==2 || argc==4){
		res=1;
	}
	return res;
}