%{
#include "linkedList.h"


List * estados=init(sizeof(int),NULL);
/*
Tabela tabela;
Linha linha;
Imagem imagem;
*/
int abertos =0;
int estado;

%}


%x NORMAL NEGRITO ITALICO SUBLINHADO COMENTARIO VERBATIM LISTA TABELA IMAGEM




%%

BEGIN NORMAL;
estado=NORMAL;
\\fim\\	{
ultimoEstado = pop(estados);
BEGIN ultimoEstado;
estado = ultimoEstado;
 printf("encon fim\n");}

<NORMAL>\\titulo\\.*\\fim\\		printf("%s\n",yytext+8);
<NORMAL>\\autores\\.*\\fim\\		printf("%s\n",yytext+9);
<NORMAL>\\sec[1-6]\\[^\\]*\\fim\\		printf("%s\n",yytext+6);
<NORMAL>\\lo\\[^\\]*		printf("%s\n",yytext+4);
<NORMAL>\\li\\[^\\]*		printf("%s\n",yytext+4);
<NORMAL>\\item\\[^\\]*		printf("%s\n",yytext+4);

<NORMAL>\\n\{.*\}\\		{BEGIN NEGRITO;
				 insertHead(estados,&estado);
				 estado=NEGRITO;
				 abertos++;
				 //printf("NEGRITO-%s-",yytext+3);
				 }






%%

int yywrap()
{
  printf("\nFIM\n");


  return 1;
}
