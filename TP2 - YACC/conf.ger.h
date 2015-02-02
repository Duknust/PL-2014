/* -----------------------------------
 * Production Selectors
 * -----------------------------------
 */

#define PScons_conf_ListaLinhas  2000
#define PScons_conf_ListaLinhas_Fim  2001

#define PScons_conf_Linha  2002
#define PScons_conf_Linha_ListaCampos  2003

#define PScons_conf_ListaCampos  2004
#define PScons_conf_ListaCampos_Fim  2005

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

/* --- dummy ListaCampos ---*/
struct sListaCampos;
typedef struct sListaCampos *ListaCampos;

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
        char * s1;
      } d1;
    struct {
        ListaCampos s1;
      } d2;

  } u;
};

/* --- ListaCampos ---*/
struct sListaCampos 
{ int flag;
  union {  
    struct {
        ListaCampos s1;
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

ListaLinhas  cons_conf_ListaLinhas( ListaLinhas a1, Linha a2);
ListaLinhas  cons_conf_ListaLinhas_Fim( Linha a1);

Linha  cons_conf_Linha( char * a1);
Linha  cons_conf_Linha_ListaCampos( ListaCampos a1);

ListaCampos  cons_conf_ListaCampos( ListaCampos a1, char * a2);
ListaCampos  cons_conf_ListaCampos_Fim( char * a1);

