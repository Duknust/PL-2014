#include "conf.ger.h"

/* -----------------------------------
 * Constructor Function Implementations
 * -----------------------------------
 */

ListaLinhas  cons_conf_ListaLinhas( ListaLinhas a1, Linha a2)
{
    ListaLinhas aux0;

  aux0 = (ListaLinhas) malloc(sizeof(struct sListaLinhas));
  aux0->flag = PScons_conf_ListaLinhas;
  aux0->u.d1.s1 = a1;
  aux0->u.d1.s2 = a2;
  return(aux0);
}

ListaLinhas  cons_conf_ListaLinhas_Fim( Linha a1)
{
    ListaLinhas aux0;

  aux0 = (ListaLinhas) malloc(sizeof(struct sListaLinhas));
  aux0->flag = PScons_conf_ListaLinhas_Fim;
  aux0->u.d2.s1 = a1;
  return(aux0);
}


Linha  cons_conf_Linha( char * a1)
{
    Linha aux0;

  aux0 = (Linha) malloc(sizeof(struct sLinha));
  aux0->flag = PScons_conf_Linha;
  aux0->u.d1.s1 = a1;
  return(aux0);
}

Linha  cons_conf_Linha_ListaCampos( ListaCampos a1)
{
    Linha aux0;

  aux0 = (Linha) malloc(sizeof(struct sLinha));
  aux0->flag = PScons_conf_Linha_ListaCampos;
  aux0->u.d2.s1 = a1;
  return(aux0);
}


ListaCampos  cons_conf_ListaCampos( ListaCampos a1, char * a2)
{
    ListaCampos aux0;

  aux0 = (ListaCampos) malloc(sizeof(struct sListaCampos));
  aux0->flag = PScons_conf_ListaCampos;
  aux0->u.d1.s1 = a1;
  aux0->u.d1.s2 = a2;
  return(aux0);
}

ListaCampos  cons_conf_ListaCampos_Fim( char * a1)
{
    ListaCampos aux0;

  aux0 = (ListaCampos) malloc(sizeof(struct sListaCampos));
  aux0->flag = PScons_conf_ListaCampos_Fim;
  aux0->u.d2.s1 = a1;
  return(aux0);
}


