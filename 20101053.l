%{   
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
        #include <math.h>
	#include "20101053.tab.h"
        extern int yylval;
	extern FILE *yyin;
	extern FILE *yyout;
%}

%%
[ \t\n]* ;
[0-9]+ { yylval=atoi(yytext); return NUMBER;}
[a-zA-Z]  {yylval=*yytext-'a'; return VARIABLE;}
"NIBIR" { return START; }
"NIBIR_END" { return END; }
"Int" { return INT ;}
"For" { return FOR; }
"If"    {return IF;}
"Else"  {return ELSE;}
","	{return COMMA;}
"="	{return ASSIGN;}
"+"	{return PLUS;}
"-"	{return MINUS;}
"/"	{return DIV;}
"*"	{return MULT;}
">"	{return GREAT;}
"<"	{return LESS;}
"=="	{return EQUAL;}
"<="	{return LESS_EQ;}
">="	{return GREAT_EQ;}
"["	{return LEFT_BK;}
"]"	{return RIGHT_BK;}
";"	{return SEMI;}
":"	{return COLON;}
"("	{return LEFT_BRAC;}
")"	{return RIGHT_BRAC;}
"{"	{return LEFT_PAREN;}
"}"	{return RIGHT_PAREN;}
"@".*         ;
"@@".*?"@@"   ;
%%