/* -----------------------------------
 * Constructor Function Implementations
 * -----------------------------------
 */
#include "csv.ger.h"
ListaLinhas  cons_csv_ListaLinhas( ListaLinhas a1, Linha a2)
{
    ListaLinhas aux0;

  aux0 = (ListaLinhas) malloc(sizeof(struct sListaLinhas));
  aux0->flag = PScons_csv_ListaLinhas;
  aux0->u.d1.s1 = a1;
  aux0->u.d1.s2 = a2;
  return(aux0);
}

ListaLinhas  cons_csv_ListaLinhas_Fim( Linha a1)
{
    ListaLinhas aux0;

  aux0 = (ListaLinhas) malloc(sizeof(struct sListaLinhas));
  aux0->flag = PScons_csv_ListaLinhas_Fim;
  aux0->u.d2.s1 = a1;
  return(aux0);
}


Linha  cons_csv_Linha( Linha a1, char * a2)
{
    Linha aux0;

  aux0 = (Linha) malloc(sizeof(struct sLinha));
  aux0->flag = PScons_csv_Linha;
  aux0->u.d1.s1 = a1;
  aux0->u.d1.s2 = a2;
  return(aux0);
}

Linha  cons_csv_Linha_Fim( char * a1)
{
    Linha aux0;

  aux0 = (Linha) malloc(sizeof(struct sLinha));
  aux0->flag = PScons_csv_Linha_Fim;
  aux0->u.d2.s1 = a1;
  return(aux0);
}


