%{
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "latex.h"

#define KGRN  "\x1B[32m"
#define KNRM  "\x1B[0m"
#define KNEG  "\033[1;30m"  


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

void printa(char * formato,char * texto);

%}

/*definicao de todos os estados possiveis*/
/*   1      2        3         4          5        6       7     8      9    10     11     12   13    14   15     16       17     18 */
%x NORMAL NEGRITO ITALICO SUBLINHADO COMENTARIO VERBATIM LISTA_I TABELA IMAGEM NIS FOOTNOTE COR LINHA LATEX HTML LEGENDA LISTA_O ITEM


%%
	/* fim de tabs */
<*>\\fim\\																	{ultimoEstado = estados[apontaEstados];
																				printf("ultimo:%d",ultimoEstado);
																		     if(apontaEstados>0) apontaEstados--;
																				printf("...%d..\n",estados[apontaEstados]);
																				
																			 switch(ultimoEstado)
																			 {
																			 	case 2: 
																			 	printa("%s","}");
																				break;
																			 	case 3:
																			 	printa("%s","}");
																			 	break;
																			 	case 4:
																			 	printa("%s","}");
																			 	break;
																			 	case 5:
																			 	printa("%s","\\end{comment}\n");
																			 	break;
																			 	case 6://verbatim
																			 	printa("%s","}");																			 	break;
																			 	case 7:
																			 	printa("%s","\\end{itemize}");
																			 	break;
																			 	case 8:
																			 	printa("%s",(char*)fimtabelaL());
																			 	break;
																			 	case 9:
																			 	printa("%s",(char*)fimimagemL());
																			 	break;
																			 	case 10:
																			 	printa("%s","}}}");
																			 	break;
																			 	case 11:
																			 	printa("%s","}");//footnote>
																			 	break;
																			 	case 12://cor
																			 	printa("%s","}");
																			 	break;
																			 	case 13://linha
																			 	//printa("%s","\\hline");
																			 	break;
																				case 16:
																			 	printa("%s","}");
																			 	break;
																			 	case 17:
																			 	printa("%s","\\end{enumerate}");
																			 	break;
																			 	case 18:																			
																			 	printa("%s","\\\\");
																			 	break;
																			 	default:
																			 	break;
																			 }
																			 
										 									 ultimoEstado= estados[apontaEstados];
																			 BEGIN ultimoEstado;
																			}

	/*titulo*/
<NORMAL>\\titulo\\.*\n														printa("%s",(char*)tituloL(tira_ns(yytext+8)));

	/*autores*/
<NORMAL>\\autores\\.*\n														printa("%s",(char*)autoresL(tira_ns(yytext+9)));

	/*nivel de seccao (pode ser 1, 2 ou 3)*/
<NORMAL>\\sec[1-3]\\.*\n													printa("%s",(char*)sectionL(tira_ns(yytext+6),yytext[4]));

	/*LISTA_I nao ordenada*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,NIS,COR,LINHA,LATEX,HTML>\\li\\[^\\]*		{BEGIN LISTA_I;
																								 estado=LISTA_I;
																								 apontaEstados++;
																								 estados[apontaEstados]=estado;
																								 if(_modoLatex)printa("%s",(char*)liL());
																								 //if(_modoHTML)printa("%s",(char*)liH());
																								}

	/*LISTA_O ordenada*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,NIS,COR,LINHA,LATEX,HTML>\\lo\\[^\\]*		{BEGIN LISTA_O;
																								 estado=LISTA_O;
																								 apontaEstados++;
																								 estados[apontaEstados]=estado;
																								 if(_modoLatex)printa("%s",(char*)loL());
																								 //if(_modoHTML)printa("%s",(char*)loH());
																								}

	/*novo item*/
<LISTA_I,LISTA_O>\\item\\[^\\]*													{BEGIN ITEM;
																				 estado=ITEM;
																				 apontaEstados++;
																				 estados[apontaEstados]=estado;
																	 			 if(_modoLatex)printa("%s",(char*)itemL(yytext+6));
																	 			 //if(_modoHTML)printa("%s",(char*)itemH(yytext+6));
																	 			}

	/*apenas no LaTeX*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA>\\jl\\[^\\]*				printa("<justL>%s",(char*)yytext+4);

	/*apenas no HTML*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA>\\jh\\[^\\]*	 			printa("<justH>%s",(char*)yytext+4);

	/*quebra de linha*/
<*>\\nl\\																	printa("%s",(char*)paragrafoL());
	
	/*negrito*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,ITEM>\\n\\[^\\]*					{BEGIN NEGRITO;
																			 estado=NEGRITO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printa("%s",(char*)negritoL(yytext+3));
																	 		}

	/*italico*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,ITEM>\\i\\[^\\]*					{BEGIN ITALICO;
																			 estado=ITALICO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printa("%s",(char*)italicoL(yytext+3));
																	 		}

	/*sublinhado*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,ITEM>\\s\\[^\\]*					{BEGIN SUBLINHADO;
																			 estado=SUBLINHADO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printa("%s",(char*)sublinhadoL(yytext+3));
																	 		}

	/*combinação de negrito, italico e sublinhado*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,ITEM>\\nis\\[^\\]*				{BEGIN NIS;
																			 estado=NIS;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 if(_modoLatex) printa("%s",(char*)nisL(yytext+5));
																	 		 //if(_modoHTML) nisH(yytext+5);
																	 		 if(_modoEcran) printf("nis{%s}\n", yytext+5);
																	 		}

	/*comentario*/
<*>\\%\\[^\\]*																{BEGIN COMENTARIO;
																			 estado=COMENTARIO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printa("\\begin{comment}%s",(char*)yytext+3);
																	 		}

	/*simbolo do latex*/
<*>\LaTeX\																	printa("%s","\\LaTeX");

	/*tab*/
<*>\tab\																	printa("%s","\\vspace{10 mm}");

	/*link*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,NIS>\\hlink\\				printa("%s","\\link");

	/*data do dia*/
<NORMAL>\\data\\															printa("%s","\\today");

	/*fim de capa*/
<NORMAL>\\fimdecapa\\														{printa("%s",(char*)fimdecapaL());
																			 printa("%s",(char*)newpageL());
																			}
	/*indice*/
<NORMAL>\\indice\\															printa("%s","\\tableofcontents\n");

	/*indice de imagens*/
<NORMAL>\\indiceimg\\														printa("%s","\\listoffigures\n");


	/*nota de rodape*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,NIS,ITEM>\\footnote\\[^\\]*		{BEGIN FOOTNOTE;
																			 estado=FOOTNOTE;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printa("\\footnote{%s",(char*)yytext+10);
																	 		}
	/*cores do texto*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,NIS,ITEM>\\(vermelho|verde|azul|amarelo|rosa|laranja|violeta|cinzento|castanho)\\[^\\]*		{BEGIN COR;
																									 	 estado=COR;
																									 	 apontaEstados++;
																									 	 estados[apontaEstados]=estado;
																							 		 	 printa("%s",(char*)corL(yytext+1));
																							 			}

	/*texto nao formatado*/
<NORMAL,VERBATIM,TABELA>\\nf\[^\\]*											{BEGIN VERBATIM;
																		 	 estado=VERBATIM;
																		 	 apontaEstados++;
																		 	 estados[apontaEstados]=estado;
																 		 	 printa("\\begin{verbatim}%s",(char*)yytext+4);
																 			}

	/*começar tabela tabela*/
<NORMAL,TABELA>\\tabela[0-9]+(l|c|r)(\,t\:[0-9.]+)?(\,l\:[^\\]+)\\			{BEGIN TABELA;
																			 estado=TABELA;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																			 printa("%s",(char*)tabelaL(yytext+7));
																			}

	/*inserir linha da tabela*/
<TABELA,LINHA>\\linha\\[^\\]*													{BEGIN LINHA;
																			 estado=LINHA;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																			 printa("%s",(char*)tabelalinhaL(yytext+7));
																			 //printf("....");
																			}																											
 	
<COMENTARIO>\nf													printa("%s",yytext);
<*>\\legenda\\[^\\]*															{BEGIN LEGENDA;
																			 estado=LEGENDA;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																			 printa("%s",(char*)legendaL(yytext+9));
																			}

	/*omissao da quebra*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,VERBATIM,LISTA_I,LISTA_O,TABELA,IMAGEM,NIS,FOOTNOTE,COR,LINHA,LATEX,HTML,LEGENDA>\n 			;
	
	/*aparece apenas no HTML*/
<*>\\sh\\[^\\]*															{BEGIN HTML;
																		 estado=HTML;
																		 apontaEstados++;
																		 estados[apontaEstados]=estado;
																		 printa("<linha>%s",yytext+7);
																		}	
	/*aparece apenas no LaTeX*/
<*>\\sl\\[^\\]*															{BEGIN LATEX;
																		 estado=LATEX;
																		 apontaEstados++;
																		 estados[apontaEstados]=estado;
																		 printa("<linha>%s",yytext+7);
																		}	

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,TABELA,NIS,COR,LINHA,LATEX,HTML,LISTA_O,ITEM>\\imagem(\,t\:[0-9.]+)?(\,l\:[^\\]+)(\,c\:[^\\]+)\\	{BEGIN IMAGEM;
																																				 estado=IMAGEM;
																																				 apontaEstados++;
																																				 estados[apontaEstados]=estado;
																																				 printa("%s",(char*)imagemL(yytext+9));
																																				}

<*>.																	printa("%s",yytext);

%%




/*


int main(int argc, char* argv[]){
	
//iniciar o lex no estado 1, estado NORMAL
estados[0]=1;
BEGIN NORMAL;
	
//Reconhecedor dos padroes suportados
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
			char * nome1 = strdup(argv[3]);
			char * nome2 = strdup(argv[3]);
			char * fileout1=strdup(strcat(nome1,".tex"));
			char * fileout2=strdup(strcat(nome2,".html"));
			
			if(!strcmp(argv[1],"-l"))
			{
				_modoLatex=1;
				latex_file = fopen(fileout1, "w+");
				if(latex_file < 0)    return 1;
				
				initLaTeX();
				
				
			} else if(!strcmp(argv[1],"-h"))
			{
				_modoHTML=1;
				html_file = fopen(fileout2, "w+");
				if(html_file < 0)    return 1;
				
				//initHTML();
				
			} else if(!strcmp(argv[1],"-lh"))
			{
				_modoHTML=1;
				_modoLatex=1;
				latex_file = fopen(fileout1, "w+");
				html_file = fopen(fileout2, "w+");
			
			
				if(latex_file < 0 || html_file < 0)    return 1;
				
				initLaTeX();
				//initHTML();
				
			}
			
//			if(dup2(file,1) < 0)    return 1;
		}


		else return -1;//nao é válido -l ou -h

//execucao do lex
		yylex();


		if(_modoLatex && !_modoEcran)
			fprintf(latex_file,"%s",fimL());
		if(_modoHTML && !_modoEcran)
			fprintf(html_file,"%s",fimH());
		if(_modoEcran){
			if(_modoLatex)
				fprintf(latex_file,"%s",fimL());
			else if(_modoHTML)
				fprintf(html_file,"%s",fimL());

		}
	}

	return 0;
}



*/



void printa(char * formato,char * texto){
	
	if(_modoHTML==1)
		fprintf(html_file,formato,texto);
			
	if(_modoLatex==1)
		fprintf(latex_file,formato,texto);
			
}

	/*Verifica se a invocacao ocorreu com argumentos de criacao de ficheiro*/
int verificaArgs_ArgumentosOut(int argc, char* argv[]){
	int res = 0;
	if (argc==2 || argc==4){
		res=1;
	}
	return res;
}

	/*Verifica se a invocacao ocorreu com argumentos de help*/
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

	/*Verifica se a invocacao ocorreu com argumentos de versao*/
int verificaArgs_callVersion(int argc, char* argv[]){
	int res = 0;
	if (argc==2 && (strcmp(argv[1],"--v")==0 || strcmp(argv[1],"--version")==0)){
		printf("FlexLuthor version 3.2");
		printf(KGRN " Kryptonite");
		printf(KNRM "\nCreated by Duarte Duarte and Fabio Gomes\nProduct from BananaCorp®\n");
		res=1;
	}
	return res;
}

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
					printf("Terceiro parÃ¢metro nao Ã© -o\n");
					return -1;
				}
		}
		
		char * nome1 = strdup(argv[3]);
		char * nome2 = strdup(argv[3]);
		char * fileout1=strdup(strcat(nome1,".tex"));
		char * fileout2=strdup(strcat(nome2,".html"));

		if(strcmp(argv[1],"-h")==0)
		{
			_modoHTML=1;
			html_file = fopen(fileout2, "w+");
			if(html_file < 0)    return 1;
			
			//initHTML();
		}

		else if(strcmp(argv[1],"-l")==0){
			_modoLatex=1;
			latex_file = fopen(fileout1, "w+");
			if(latex_file < 0)    return 1;
			
			initLaTeX(latex_file);
		}
		else if(strcmp(argv[1],"-lh")==0 || strcmp(argv[1],"-hl")==0){
			_modoHTML=1;
			_modoLatex=1;
			latex_file = fopen(fileout1, "w+");
			html_file = fopen(fileout2, "w+");
		}
		else if(strcmp(argv[1],"--man")==0){
  			system("clear");

			printf(KNRM "\nLUTHOR(1)                 BananaCorp® Commands Manual                LUTHOR(1)\n\n");
			printf(KNEG "NAME\n");
				printf(KNEG "\tFlexLuthor\n\n"); printf(KNRM "\t -- converte ficheiros para diferentes formatos\n\n");
			printf(KNEG "flexLuthor -lh -o [output]\n");
				printf(KNEG "\tFlexLuthor\n\n");
			printf(KNEG "DESCRIPTION\n");
				printf(KNRM "\tUtiliza-se para converter um ficheiro em formato .tbc para converter para LaTeX e/ou HTML\n\n");
			printf(KNEG "EXIT STATUS\n");
				printf(KNRM "\tO"); printf(KNEG " FlexLuthor "); printf(KNRM "devolve \"done\" no sucesso e \"error\" quando ocorre um erro\n\n");
			printf(KNEG "EXAMPLE\n");
				printf(KNRM "\tEsta pagina foi escrita por Duarte Duarte e Fabio Gomes\n\n");


			printf(KNEG "HISTORY\n");
				printf(KNRM "\tO"); printf(KNEG " FlexLuthor "); printf(KNRM "foi desenvolvido para a UC de Processamento de Linguagens inserida no 2º semestre do 3º ano da Licenciatura em Engenharia Informatica (LEI) no ano lectivo de 2013/2014\n\n");
			printf(KNEG "AUTHORS\n");
				printf(KNRM "\tEsta pagina foi escrita por Duarte Duarte e Fabio Gomes\n\n");
			printf(KNRM "\nLUTHOR(1)                        Marco de 2014                       LUTHOR(1)\n\n");
		}

	/*execucao do lex*/
		if(_modoLatex || _modoHTML || _modoEcran){
		//printf("AQUI JAZ YYLEX\n");
			yylex();
		}

/*so coloca estiver em modo de latex*/
		if(_modoLatex && !_modoEcran)
			fprintf(latex_file,"%s",(char*)fimL());
		if(_modoHTML && !_modoEcran)
			;//fprintf(html_file,"%s",fimH());
		if(_modoEcran){
			if(_modoLatex)
				printf("%s",(char *)fimL());
				
			else if(_modoHTML==1)
				;//printf("%s",fimH());
				
		}
	
	} 

	if (_modoHTML==0 && _modoLatex==0 && _modoEcran==0 && _versionORhelp==0 && strcmp(argv[1],"--man")!=0){
		printf("ERROR - maybe you need to use:\n");
		printf("--h or --help [all options and description]\n");
	} 
	return 0;
}






