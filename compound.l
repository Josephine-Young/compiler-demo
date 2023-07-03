%{
	#include <stdio.h>
	#include "compound.tab.h"
    #include <string.h>
    int q1[26]={0,11,12,0,0,19,0,1,127,0,39,0,0,14,16,31,0,0,32,0,0,51,0,0,89,0};
    int q2[26][26];
    extern char * yytext;
    extern int getValue(char *);
   
%}
digit	[1-9][0-9]*
element_1 (He|Li|Be|Ne|Na|Mg|Al|Si|Cl|Ar|Ca|Sc|Ti|Cr|Mn|Fe|Co|Ni|Cu|Zn|Ga|Ge|As|Se|Br|Kr|Rb|Sr|Sn|Sb|Te|Xe|Cs|Ba|Pt|Au|Hg|Tl|Pb|Bi|Po|At|Rn)
element_2 (H|B|C|N|O|F|P|S|K|V|Y|I)
%%
"exit"    return EXIT;
";"      return OVER;
{element_1} {
yylval.name=yytext;
// printf("yytext=%s\n",yytext);
return ELEMENT;
}
{element_2} {
yylval.name=yytext;
// printf("yytext=%s\n",yytext);
return ELEMENT;
}
{digit} {
yylval.num=atoi(yytext);
// printf("yytext=%s\n",yytext);
return VALUE; 
}
"_" {yylval.name=yytext;return CONNECT;}
"-" {yylval.name=yytext;return AND;}
"(" {yylval.name=yytext;return LP;}
")" {yylval.name=yytext;return RP;}
"[" {yylval.name=yytext;return LB;}
"]" {yylval.name=yytext;return RB;}
[ \t\n] ;
.       {printf("unrecognized word %s\n",yytext);}
%%
int yywrap(void)
{
	return 1;
}
void initialize(){
    
    int init[43]={4,7,9,20,23,24,27,28,35,40,40,45,48,52,55,56,59,59,64,65,70,73,75,79,80,
        84,85,88,119,122,128,131,133,137,195,197,201,204,207,209,209,210,222};
    char *names[43]={"He","Li","Be","Ne","Na","Mg","Al","Si","Cl","Ar","Ca","Sc","Ti","Cr",
        "Mn","Fe","Co","Ni","Cu","Zn","Ga","Ge","As","Se","Br","Kr","Rb","Sr","Sn","Sb",
        "Te","Xe","Cs","Ba","Pt","Au","Hg","Tl","Pb","Bi","Po","At","Rn"};
    for(int i=0;i<43;i++){
        int a=0,b=0;
        a=names[i][0]-'A';
        b=names[i][1]-'a';
        q2[a][b]=init[i];
        /* printf("%d,%s,%d\n",i,names[i],init[i]); */
    }  
}
int getValue(char * element){
    int val=0;
    if(strlen(element)==1){
        val=q1[element[0]-'A'];
    }
    else {
        int a=0,b=0;
        /* printf("element[0] is %c\n",element[0]);
        printf("element[1] is %c\n",element[1]); */
        a=element[0]-'A';
        b=element[1]-'a';
        val=q2[a][b];
        /* printf("q2[a][b] is %d\n",q2[a][b]);
        printf("in getValue(),val=%d\n",val); */
    }
    return val;
}
