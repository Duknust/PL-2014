#include <stdio.h>
#include "csv.tab.h"

extern int csvlex();

int main(){

	int token;
	
	while((token=csvlex())!=0)
		switch(token){
			case SEPL: printf("SEPL\n");
				      break;
			case SEPC: printf("SEPC\n");
				      break;
            case c_string: printf("campo\n");
                break;
			default: printf("%d\n",token);
		}
}
