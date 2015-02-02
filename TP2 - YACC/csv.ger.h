#ifndef _CSVGER
#define _CSVGER

#define PScons_csv_ListaLinhas  2000
#define PScons_csv_ListaLinhas_Fim  2001

#define PScons_csv_Linha  2002
#define PScons_csv_Linha_Fim  2003

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* -----------------------------------
 * Abstract Data Types Definition
 * -----------------------------------
 */

/* To avoid dependencies, waiting for a cleaner solution...*/

/* --- dummy ListaLinhas ---*/
struct sListaLinhas;
typedef struct sListaLinhas *ListaLinhas;

/* --- dummy Linha ---*/
struct sLinha;
typedef struct sLinha *Linha;

/* Now the types definition...*/

/* --- ListaLinhas ---*/
struct sListaLinhas 
{ int flag;
  union {  
    struct {
        ListaLinhas s1;
        Linha s2;
      } d1;
    struct {
        Linha s1;
      } d2;

  } u;
};

/* --- Linha ---*/
struct sLinha 
{ int flag;
  union {  
    struct {
        Linha s1;
        char * s2;
      } d1;
    struct {
        char * s1;
      } d2;

  } u;
};

/* -----------------------------------
 * Constructor Function Signatures
 * -----------------------------------
 */

ListaLinhas  cons_csv_ListaLinhas( ListaLinhas a1, Linha a2);
ListaLinhas  cons_csv_ListaLinhas_Fim( Linha a1);

Linha  cons_csv_Linha( Linha a1, char * a2);
Linha  cons_csv_Linha_Fim( char * a1);

#endif
