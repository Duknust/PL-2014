%{
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include "latex.h"
#include "html.h"

#define KGRN  "\x1B[32m"
#define KNRM  "\x1B[0m"
#define KNEG  "\033[1;30m"  


/*stack que guarda os estados*/
int estado=1;
int ultimoEstado;
int estados[100];
int apontaEstados=0;
int slActivo=0;
int shActivo=0;
int maketi=0;

/*modo que o utilizador pretende compilar*/
int _modoHTML=0;
int _modoLatex=0;
int _modoEcran=0;
int _versionORhelp=0;

/*files a serem criados*/
FILE *html_file=NULL;
FILE *latex_file=NULL;

void printaL(char * formato,char * texto);
void printaH(char * formato,char * texto);

char *tira_ns(char * texto);


%}

/*definicao de todos os estados possiveis*/
/*   1      2        3         4          5        6       7     8      9    10     11     12   13    14   15     16       17     18     19        20      21   */
%x NORMAL NEGRITO ITALICO SUBLINHADO COMENTARIO VERBATIM LISTA_I TABELA IMAGEM NIS FOOTNOTE COR LINHA LATEX HTML LEGENDA LISTA_O ITEM DICIONARIO CITACAO RESUMO


%%
	/* fim de tabs */
<*>\/fim\/																	{ultimoEstado = estados[apontaEstados];
																				//printf("ultimo:%d",ultimoEstado);
																		     if(apontaEstados>0) apontaEstados--;
																				//printf("...%d..\n",estados[apontaEstados]);
																				
																			 switch(ultimoEstado)
																			 {
																			 	case 2: 
																			 	if(_modoLatex)printaL("%s","}");
																			 	if(_modoHTML)printaH("%s","</b>");
																				break;
																			 	case 3:
																			 	if(_modoLatex)printaL("%s","}");
																			 	if(_modoHTML)printaH("%s","</i>");
																			 	break;
																			 	case 4:
																			 	if(_modoLatex)printaL("%s","}");
																			 	if(_modoHTML)printaH("%s","</u>");
																			 	break;
																			 	case 5:
																			 	if(_modoLatex)printaL("%s","\\end{comment}\n");
																			 	if(_modoHTML)printaH("%s","-->\n");
																			 	break;
																			 	case 7:
																			 	if(_modoLatex)printaL("%s","\\end{itemize}");
																			 	if(_modoHTML)printaH("%s","</ul>");
																			 	break;
																			 	case 8:
																			 	if(_modoLatex)printaL("%s",(char*)fimtabelaL());
																			 	if(_modoHTML)printaH("%s",(char*)fimtabelaH());
																			 	break;
																			 	case 9:
																			 	break;
																			 	case 10:
																			 	if(_modoLatex)printaL("%s","}}}");
																			 	if(_modoHTML)printaH("%s","</b></u></i>");
																			 	break;
																			 	case 11:
																			 	if(_modoLatex)printaL("%s","}");
																			 	if(_modoHTML)printaH("%s","</a>");//footnote>
																			 	break;
																			 	case 12://cor
																			 	if(_modoLatex)printaL("%s","}");
																			 	if(_modoHTML)printaH("%s","</font>");
																			 	break;
																			 	case 14://SO LATEX
																			 	slActivo=0;
																			 	break;
																			 	case 15://SO HTML
																			 	shActivo=0;
																			 	break;
																				case 16:
																			 	printaL("%s","}");
																			 	break;
																			 	case 17:
																			 	if(_modoLatex)printaL("%s","\\end{enumerate}");
																			 	if(_modoHTML)printaH("%s","</ol>");
																			 	break;
																			 	case 18:																			
																			 	if(_modoLatex)printaL("%s","\\\\\n");
																			 	if(_modoHTML)printaH("%s","</li>\n");
																			 	break;
																			 	case 19:																			
																			 	if(_modoLatex)printaL("%s","\\end{description}");
																			 	if(_modoHTML)printaH("%s","\n");
																			 	break;
																			 	case 20:																			
																			 	if(_modoLatex)printaL("%s","\\end{quote}");
																			 	if(_modoHTML)printaH("%s","</q>\n");
																			 	break;
																			 	case 21:																			
																			 	if(_modoLatex)printaL("%s","\\end{abstract}");
																			 	if(_modoHTML)printaH("%s","</q>\n");
																			 	break;
																			 	default:
																			 	break;
																			 }
																			 
										 									 ultimoEstado= estados[apontaEstados];
																			 BEGIN ultimoEstado;
																			}
																			
																			
	/* fim de tabs */
<VERBATIM>!fim!																	{ultimoEstado = estados[apontaEstados];
																				//printf("ultimo:%d",ultimoEstado);
																		     if(apontaEstados>0) apontaEstados--;
																				//printf("...%d..\n",estados[apontaEstados]);
																				
																			 switch(ultimoEstado)
																			 {
																			 	case 6://verbatim
																			 	if(_modoLatex)printaL("%s","\\end{verbatim}\n");
																			 	if(_modoHTML)printaH("%s","</pre>");
																			 	break;
																			 	
																			 	default:
																			 	break;
																			 }
																			 
										 									 ultimoEstado= estados[apontaEstados];
																			 BEGIN ultimoEstado;
																			}


	/*titulo*/
<NORMAL>\/titulo\/.*\n														{if(_modoLatex)printaL("%s",(char*)tituloL(tira_ns(yytext+8)));
																			 if(_modoHTML)printaH("%s",(char*)tituloH(tira_ns(yytext+8)));}

	/*autores*/
<NORMAL>\/autores\/.*\n														{if(_modoLatex)printaL("%s",(char*)autoresL(tira_ns(yytext+9)));
																			 if(_modoHTML)printaH("%s",(char*)autoresH(tira_ns(yytext+9)));}

	/*nivel de seccao (pode ser 1, 2 ou 3)*/
<NORMAL>\/sec[1-3]\/.*\n													{if(_modoLatex)printaL("%s",(char*)sectionL(tira_ns(yytext+6),yytext[4]));
																			 if(_modoHTML)printaH("%s",(char*)sectionH(tira_ns(yytext+6),yytext[4]));}

	/*LISTA_I nao ordenada*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,NIS,COR,LINHA,LATEX,HTML>\/li\/[^\/]*		{BEGIN LISTA_I;
																								 estado=LISTA_I;
																								 apontaEstados++;
																								 estados[apontaEstados]=estado;
																								 if(_modoLatex)printaL("%s",(char*)liL());
																								 if(_modoHTML)printaH("%s",(char*)liH());
																								}

	/*LISTA_O ordenada*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,NIS,COR,LINHA,LATEX,HTML>\/lo\/[^\/]*		{BEGIN LISTA_O;
																								 estado=LISTA_O;
																								 apontaEstados++;
																								 estados[apontaEstados]=estado;
																								 if(_modoLatex)printaL("%s",(char*)loL());
																								 if(_modoHTML)printaH("%s",(char*)loH());
																								}

	/*novo item*/
<LISTA_I,LISTA_O>\/item\/[^\/]*													{BEGIN ITEM;
																				 estado=ITEM;
																				 apontaEstados++;
																				 estados[apontaEstados]=estado;
																	 			 if(_modoLatex)printaL("%s",(char*)itemL(yytext+6));
																	 			 if(_modoHTML)printaH("%s",(char*)itemH(yytext+6));
																	 			}



	/*quebra de linha*/
<*>\/nl\/																	{if(_modoLatex)printaL("%s",(char*)paragrafoL());
																			 if(_modoHTML)printaH("%s",(char*)paragrafoH());}
	
	/*negrito*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,ITEM,LATEX,HTML>\/n\/[^\/]*					{BEGIN NEGRITO;
																			 estado=NEGRITO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 if(_modoLatex)printaL("%s",(char*)negritoL(yytext+3));
																			 if(_modoHTML)printaH("%s",(char*)negritoH(yytext+3));
																	 		}

	/*italico*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,ITEM,LATEX,HTML>\/i\/[^\/]*					{BEGIN ITALICO;
																			 estado=ITALICO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 if(_modoLatex)printaL("%s",(char*)italicoL(yytext+3));
																			 if(_modoHTML)printaH("%s",(char*)italicoH(yytext+3));
																	 		}

	/*sublinhado*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,ITEM,LATEX,HTML>\/s\/[^\/]*					{BEGIN SUBLINHADO;
																			 estado=SUBLINHADO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 if(_modoLatex)printaL("%s",(char*)sublinhadoL(yytext+3));
																			 if(_modoHTML)printaH("%s",(char*)sublinhadoH(yytext+3));
																	 		}

	/*combinação de negrito, italico e sublinhado*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,ITEM,LATEX,HTML>\/nis\/[^\/]*				{BEGIN NIS;
																			 estado=NIS;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 if(_modoLatex) printaL("%s",(char*)nisL(yytext+5));
																	 		 
																	 		 if(_modoHTML) printaH("%s",(char*)nisH(yytext+5));
																	 		}

	/*comentario*/
<*>\/%\/[^\/]*																{BEGIN COMENTARIO;
																			 estado=COMENTARIO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 if(_modoLatex)printaL("\\begin{comment}%s",(char*)yytext+3);
																	 		 if(_modoHTML)printaH("\n<!--%s",(char*)yytext+3);
																	 		}

	/*simbolo do latex*/
<*>\/LaTeX\/																	{if(_modoLatex)printaL("%s","\\LaTeX");\
																	 		 if(_modoHTML)printaH("%s","LaTeX");}

	/*tab*/
<*>\/tab\/																	{if(_modoLatex)printaL("%s",(char*)tabL());
																	 		 if(_modoHTML)printaH("%s",(char*)tabH());}

	/*link*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,NIS,LATEX,HTML>\/hlink\/[^\/]*				{if(_modoLatex)printaL("%s",(char *) hlinkL(yytext+7));
																										 if(_modoHTML)printaH("%s",(char *) hlinkH(yytext+7));}

	/*data do dia*/
<NORMAL,LATEX,HTML>\/data\/															{if(_modoLatex)printaL("%s","\\today");
																	 		 if(_modoHTML)printaH("%s","<script language=\"JavaScript\">Date.prototype.toDDMMYYYYString = function () {return isNaN (this) ? 'NaN' : [this.getDate() > 9 ? this.getDate() : '0' + this.getDate(),  this.getMonth() > 8 ? this.getMonth() + 1 : '0' +  (this.getMonth() + 1), this.getFullYear()].join('/')}\ndocument.write(new Date().toDDMMYYYYString())</script>");}

	/*fim de capa*/
<NORMAL>\/fimdecapa\/														{if(_modoLatex)
																			 {printaL("%s",(char*)fimdecapaL());
																			  printaL("%s",(char*)newpageL());}}
																			
	/*indice*/
<NORMAL>\/indice\/															printaL("%s","\\tableofcontents\n");

	/*indice de imagens*/
<NORMAL>\/indiceimg\/														printaL("%s","\\listoffigures\n");


	/*nota de rodape*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,NIS,ITEM>\/footnote\/[^\/]*		{BEGIN FOOTNOTE;
																			 estado=FOOTNOTE;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 if(_modoLatex)printaL("\\footnote{%s",(char*)yytext+10);
																			 if(_modoHTML)printaH("<a title=\"%s\"><sup>*</sup>",(char*)yytext+10);
																	 		}
	/*cores do texto*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,LISTA_O,TABELA,NIS,ITEM>\/(vermelho|verde|azul|amarelo|rosa|laranja|violeta|cinzento|castanho)\/[^\/]*		{BEGIN COR;
																																					 	 estado=COR;
																																					 	 apontaEstados++;
																																					 	 estados[apontaEstados]=estado;
																																			 		 	 {if(_modoLatex)printaL("%s",(char*)corL(yytext+1));
																																							if(_modoHTML)printaH("%s",(char*)corH(yytext+1));}
																																			 			}

	/*texto nao formatado*/
<NORMAL,TABELA>!nf![^!]*											{BEGIN VERBATIM;//printf("VERB_%s_\n",yytext+4);
																		 	 estado=VERBATIM;
																		 	 apontaEstados++;
																		 	 estados[apontaEstados]=estado;
																 		 	 if(_modoLatex)printaL("\\begin{verbatim}%s",(char*)yytext+4);
																			 if(_modoHTML)printaH("<pre>%s",(char*)yytext+4);
																 			}

	/*começar tabela tabela*/
<NORMAL,TABELA>\/tabela[0-9]+(l|c|r|L|C|R)(\,t\:[0-9.]+)?(\,l\:[^\/]+)\/			{BEGIN TABELA;
																			 estado=TABELA;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																			 if(_modoLatex)printaL("%s",(char*)tabelaL(yytext+7));
																			 if(_modoHTML)printaH("%s",(char*)tabelaH(yytext+7));
																			}

	/*inserir linha da tabela*/
<TABELA,LINHA>\/linha\/[^\n]*											{BEGIN LINHA;
																			 estado=LINHA;
																			 //apontaEstados++;
																			 //estados[apontaEstados]=estado;
																			 if(_modoLatex)printaL("%s",(char*)tabelalinhaL(yytext+7));
																			 if(_modoHTML)printaH("%s",(char*)tabelalinhaH(yytext+7));
																			 
																			}																											



<*>\/legenda\/[^\/]*														{BEGIN LEGENDA;
																			 estado=LEGENDA;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																			 printaL("%s",(char*)legendaL(yytext+9));
																			}

	/*omissao da quebra*/
<NORMAL,NEGRITO,ITALICO,SUBLINHADO,VERBATIM,LISTA_I,LISTA_O,TABELA,IMAGEM,NIS,FOOTNOTE,COR,LINHA,LATEX,HTML,LEGENDA>\n 			;
	
	/*aparece apenas no HTML*/
<*>\/sh\/[^\/]*															{BEGIN HTML;
																		 estado=HTML;
																		 apontaEstados++;
																		 estados[apontaEstados]=estado;
																		 shActivo=1;
																		 printaH("%s",yytext+4);
																		}	
	/*aparece apenas no LaTeX*/
<*>\/sl\/[^\/]*															{BEGIN LATEX;
																		 estado=LATEX;
																		 apontaEstados++;
																		 estados[apontaEstados]=estado;
																		 slActivo=1;
																		 printaL("%s",yytext+4);
																		}	

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA_I,TABELA,NIS,COR,LINHA,LATEX,HTML,LISTA_O,ITEM>\/imagem(\,t\:[0-9.]+)?(\,l\:[^\/]+)(\,c\:[^\/]+)\/	{
																																				 if(_modoLatex){printaL("%s",(char*)imagemL(yytext+9));
																																								printaL("%s",(char*)fimimagemL());}
																																				 if(_modoHTML){printaH("%s",(char*)imagemH(yytext+9));
																																							  printaH("%s",(char*)fimimagemH());}
																																				  
																																				}
<NORMAL>\/citar\/[^\/]*             {BEGIN CITACAO;
									   estado=CITACAO;
									   apontaEstados++;
									   estados[apontaEstados]=estado;
									   if(_modoLatex)printaL("%s",(char*)citacaoL(yytext+7));
									   if(_modoHTML)printaH("%s",(char*)citacaoH(yytext+7));
									  }

<NORMAL>\/dic\/[^\/]*             {BEGIN DICIONARIO;
								   estado=DICIONARIO;
								   apontaEstados++;
								   estados[apontaEstados]=estado;
								   if(_modoLatex)printaL("%s",(char*)dicL(yytext+5));
								   if(_modoHTML) printaH("%s",(char*)dicH(yytext+5));
								  }

 /*novo item dicionario*/
<DICIONARIO>\/item\/[^\/]*            {BEGIN ITEM;
									   estado=ITEM;
									   apontaEstados++;
									   estados[apontaEstados]=estado;
										if(_modoLatex)printaL("%s",(char*)itemDL(yytext+6));
										if(_modoHTML) printaH("%s",(char*)itemDH(yytext+6));
									   }

<*>\/reticencias\/					{if(_modoLatex)printaL("%s",(char*)dotsL());
								     if(_modoHTML) printaH("%s",(char*)dotsH());
								    }

<NORMAL>\/resumo\/[^\/]*			{BEGIN RESUMO;
									   estado=RESUMO;
									   apontaEstados++;
									   estados[apontaEstados]=estado;
										if(_modoLatex)printaL("%s",(char*)initResumoL(yytext+8));
										if(_modoHTML) printaH("%s",(char*)initResumoH(yytext+8));
									   }

<NORMAL>\/np\/						{if(_modoLatex)printaL("%s",(char*)newpageL());
								    }
									   
<*>.								{printaL("%s",yytext);
									 printaH("%s",yytext);
									}

%%




void printaH(char * formato,char * texto){
	
	if(_modoHTML==1 && slActivo==0)
		fprintf(html_file,formato,texto);
			
}


void printaL(char * formato,char * texto){

	if(_modoLatex==1 && shActivo==0)
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






char* tira_ns(char * texto){
	char c = texto[strlen(texto)-2];
	if( !(((c>='a') && (c<='z')) || ((c>='A') && (c<='Z')) || ((c>='0') && (c<='9'))))
		texto[strlen(texto)-2]='\0';
	return texto;
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
		
		char * fileout1 = (char*)malloc(sizeof(strlen(argv[3])+15));
		strcat(fileout1,"LaTeX/");
		strcat(fileout1,argv[3]);
		strcat(fileout1,".tex");
		
		char * fileout2 = (char*)malloc(sizeof(strlen(argv[3])+15));
		strcat(fileout2,"HTML/");
		strcat(fileout2,argv[3]);
		strcat(fileout2,".html");
		
		mkdir("HTML",S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
		mkdir("LaTeX",S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
		
		
		//printf("n1:%s_%d\nn2:%s_%d\n",fileout1,strlen(fileout1),fileout2,strlen(fileout2));
		
		if(fileout1[strlen(fileout1)-2] == 'x')
			fileout1[strlen(fileout1)-1]='\0';
		fileout1[strlen(fileout1)]='\0';
		
		
		
		if(fileout2[strlen(fileout2)-2] == 'l')
			fileout2[strlen(fileout2)-1]='\0';
		fileout2[strlen(fileout2)]='\0';
		
		
		//printf("n1:%s_%d\nn2:%s_%d\n",fileout1,strlen(fileout1),fileout2,strlen(fileout2));

		if(strcmp(argv[1],"-h")==0)
		{
			_modoHTML=1;
			html_file = fopen(fileout2, "w+");
			if(html_file < 0)    return 1;
			
			initHTML(html_file);
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
			latex_file = fopen(fileout1, "w+");initLaTeX(latex_file);
			html_file  = fopen(fileout2, "w+");initHTML(html_file);
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
			fprintf(html_file,"%s",fimH());
		if(_modoEcran){
			if(_modoLatex)
				printf("%s",(char *)fimL());
				
			else if(_modoHTML==1)
				printf("%s",fimH());
				
		}
	
	} 

	if (_modoHTML==0 && _modoLatex==0 && _modoEcran==0 && _versionORhelp==0 && strcmp(argv[1],"--man")!=0){
		printf("ERROR - maybe you need to use:\n");
		printf("--h or --help [all options and description]\n");
	} 
	return 0;
}






