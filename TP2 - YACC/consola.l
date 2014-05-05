%{
#include "y.tab.h"	
%}

%%
"load"			return LOAD;

"save_db"		return SAVE;

\"[a-z\ ]*\"		{ yylval.tipoficheiro=strdup(yytext);
					  printf("estou aqui!\n");
				 	  return ficheiro;}

"exit"			return EXIT;

\n				return SEP;

[ \t]	;

<<EOF>>   return '$';

.				;			

%%