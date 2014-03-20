%{

#include <unistd.h>
#include <fcntl.h>

int estado;
int ultimoEstado;
int estados[100];
int apontaEstados=0;

int _modoHTML=0;
int _modoLatex=0;

int mainTeste(){
	printf("MAIN TESTE\n");
	return 0;
}

%}
/*   1      2        3         4          5        6       7     8      9    10     11    */
%x NORMAL NEGRITO ITALICO SUBLINHADO COMENTARIO VERBATIM LISTA TABELA IMAGEM NIS FOOTNOTE

%%
printf("antes init\n");
estados[apontaEstados]=NORMAL;
printf("depois init\n");

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
									 	printf("</n>");
									 	break;
									 	case 3:
									 	printf("</i>");
									 	break;
									 	case 4:
									 	printf("</s>");
									 	break;
									 	case 5:
									 	printf("</coment>");
									 	break;
									 	case 10:
									 	printf("</nis>");
									 	break;
									 	case 11:
									 	printf("</footnote>");
									 	break;
									 	default:
									 	break;
									 }
 									 BEGIN ultimoEstado;
									 estado = ultimoEstado;
									}

<NORMAL>\\titulo\\.*\n				printf("%s",yytext+8);
<NORMAL>\\autores\\.*\n				printf("%s",yytext+9);
<NORMAL>\\sec[1-3]\\.*\n			printf("%s\n",yytext+6);
<NORMAL>\\lo\\[^\\]*				printf("%s\n",yytext+4);
<NORMAL>\\li\\[^\\]*				printf("%s\n",yytext+4);
<NORMAL>\\item\\[^\\]*				printf("%s\n",yytext+4);
<NORMAL>\\nl\\						printf("\n");

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\n\\[^\\]*					{BEGIN NEGRITO;
																			 estado=NEGRITO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("<n>%s",yytext+3);
																	 		}

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\i\\[^\\]*					{BEGIN ITALICO;
																			 estado=ITALICO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("<i>%s",yytext+3);
																	 		}

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\s\\[^\\]*					{BEGIN SUBLINHADO;
																			 estado=SUBLINHADO;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("<s>%s",yytext+3);
																	 		}

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA>\\nis\\[^\\]*				{BEGIN NIS;
																			 estado=NIS;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("<nis>%s",yytext+5);
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

<NORMAL>\\fimdecapa\\														printf("maketitle\n");

<NORMAL>\\indice\\															printf("tableofcontents\n");

<NORMAL>\\indiceimg\\														printf("listoffigures\n");

<NORMAL,NEGRITO,ITALICO,SUBLINHADO,LISTA,TABELA,NIS>\\footnote\\[^\\]*		{BEGIN FOOTNOTE;
																			 estado=FOOTNOTE;
																			 apontaEstados++;
																			 estados[apontaEstados]=estado;
																	 		 printf("<footnote>%s",yytext+10);
																	 		}
%%

int main(int argc, char* argv[]){
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
			printf("____-LaTeX-____\n");
		}
		else if(strcmp(argv[1],"-lh")==0 || strcmp(argv[1],"-hl")==0){
			_modoHTML=1;
			_modoLatex=1;
			printf("____-LaTeX e HTML-____\n");
		}

		else return -1;//nao é válido -l ou -h

		printf("AQUI ESTA A MAIN \n\n\n\n");
		yylex();
	}
	

	return 0;
}

int yywrap()
{
  return 1;
}
