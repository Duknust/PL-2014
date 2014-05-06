%token IAGENDA FAGENDA IENTRADA FENTRADA INOME FNOME
%token IEMAIL FEMAIL ITELEFONE FTELEFONE IGRUPO FGRUPO
%token IREF FREF charve valor numero texto

%start Agenda

%%

Agenda : IAGENDA Lista FAGENDA ;

Lista : Lista Entrada
	  | Lista Grupo
	  | Entrada
	  | Grupo
	  ;

Entrada : IENTRADA ListaAtrib '>' Nome Email Telefone FENTRADA ;

ListaAtrib : ListaAtrib Atrib
		   |
		   ;

Atrib : chave '=' valor ;

Nome : INOME texto FNOME ;

Email : IEMAIL texto FEMAIL ;
	  |
	  ;

Telefone : ITELEFONE numero FTELEFONE ;

Grupo : IGRUPO ListaAtrib '>' ListaG FGRUPO ;

ListaG : ListaG Entrada
	   | ListaG Grupo
	   | ListaG Ref
	   | Entrada
	   | Grupo
	   | Ref
	   ;

Ref : IREF ListaAtrib FREF ;

%%

int yyerror( char*s){
	fprintf(stderr,"%s",s);
	return -1;
}