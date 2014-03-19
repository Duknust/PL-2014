%{

/*
Tabela tabela;
Linha linha;
Imagem imagem;
*/
int estado;
int ultimoEstado;
int estados[100];
int apontaEstados=0;

int mainTeste(){
	printf("MAIN TESTE\n");
	return 0;
}

%}
/*   1      2        3         4          5        6       7     8      9    10  */
%x NORMAL NEGRITO ITALICO SUBLINHADO COMENTARIO VERBATIM LISTA TABELA IMAGEM NIS

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
									 	default:
									 	break;
									 }
 									 BEGIN ultimoEstado;
									 estado = ultimoEstado;
									}

<NORMAL>\\titulo\\.*\n				printf("%s",yytext+8);
<NORMAL>\\autores\\.*\n				printf("%s",yytext+9);
<NORMAL>\\sec[1-6]\\.*\n			printf("%s\n",yytext+6);
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

\LaTeX\																		printf("\\Latex");

\tab\																		printf("\\vspace{10 mm}");

%%

int main(int argc, char* argv[]){
	if(argc<2 || argc >4 || argc==3){
		printf("Padrão desconhecido:\n\n");
		printf("lexLuthor -l -o nome\n");
		printf("lexLuthor -h -o nome\n");
		printf("lexLuthor -l\n");
		printf("lexLuthor -h\n");
		printf("lexLuthor -lh -o nome\n");
		printf("lexLuthor -hl -o nome\n");
		printf("lexLuthor -lh\n");
		printf("lexLuthor -hl\n");
	} else {
		printf("AQUI ESTA A MAIN \n\n\n\n");
		yylex();
	}
	

	return 0;
}

/*int yywrap()
{
  mainTeste();
  return 1;
}*/
