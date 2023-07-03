%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	int yylex(void);  
	void yyerror(char const *);
	int yyparse(void);
    int quan=0;
    int flag=1;
	extern int getValue(char *);
	extern void initialize();
         
%}
%union {int num; char* name;};
%start line
%token <name> CONNECT
%token <num> VALUE
%token EXIT 
%token OVER
%token <name> AND
%token <name> LP
%token <name> RP
%token <name> LB
%token <name> RB
%token <name> ELEMENT
%type <num> expr term factor E post_expr line 


%%
/*
E -> T E
  |  T
  |  E - n E
  | (E)_n
  | [E] E

T -> a
  |  a_n
*/
/* line	: E OVER {$$=$1;quan=$$;printf("rule 0\n");return 0;}
E		: expr {$$=$1;printf("rule 1: $$=%d,$1=%d\n",$$,$1);}
		| expr LB E RB E {$$=$1+$3+$5;}
		//{$$=$2+$4;printf("rule 2: $$=%d,$2=%d,$4=%d\n",$$,$2,$4);}
		| expr AND post_expr {$$=$1+$3;printf("rule 3: $$=%d,$1=%d,$3=%d\n",$$,$1,$3);}
		| expr LP E RP CONNECT VALUE E {$$=$1+$3*$6+$7;}
		//{$$=$2*$5;printf("rule 6: $$=%d,$2=%d,$5=%d\n",$$,$2,$5);}
		;
post_expr: E {$$=$1;}
		| VALUE E {$$=$1*$2;printf("rule 10: $$=%d,$1=%d,$2=%d\n",$$,$1,$2);}

expr	: %empty {$$=0;}
		| expr factor {$$=$1+$2;printf("rule 4: $$=%d,$1=%d,$2=%d\n",$$,$1,$2);}
		//| factor {$$=$1;printf("rule 5: $$=%d,$1=%d\n",$$,$1);}
		;
factor	: term{$$=$1;printf("rule 7: $$=%d,$1=%d\n",$$,$1);}
		| term CONNECT VALUE{$$=$1*$3;printf("rule 8: $$=%d,$1=%d,$3=%d\n",$$,$1,$3);}
		;
term	: ELEMENT {$$=getValue($1);printf("rule 9: $$=%d,$1=%d\n",$$,getValue($1));}
		| EXIT {flag=0; return 0;}
		; */
line	: E OVER {$$=$1;quan=$$;return 0;}
E		: expr {$$=$1;}
		| expr LB E RB E {$$=$1+$3+$5;}
		| expr AND post_expr {$$=$1+$3;}
		| expr LP E RP CONNECT VALUE E {$$=$1+$3*$6+$7;}
		;
post_expr: E {$$=$1;}
		| VALUE E {$$=$1*$2;}

expr	: %empty {$$=0;}
		| expr factor {$$=$1+$2;}
	
		;
factor	: term{$$=$1;}
		| term CONNECT VALUE{$$=$1*$3;}
		;
term	: ELEMENT {$$=getValue($1);}
		| EXIT {flag=0; return 0;}
		;
%%
int main()
{	initialize();
	while(flag){
	quan=0;
	printf("begin\n");
	yyparse();
	if(flag)  printf("quantity=%d\n",quan);
	else break;
}
	return 0;
}
void yyerror(char const *msg)  
{  
    fprintf(stderr, "%s\n",msg);  
} 

