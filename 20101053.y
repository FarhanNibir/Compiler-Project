%{
	#include <malloc.h>
	#include <stdlib.h>
	#include <stdio.h>
	#include <math.h>
	extern FILE *yyin;
	extern FILE *yyout;
	int sym[26],check[26];
	int c[30];
	int x=0;
	int arr[30];
	int far[30];
%}

%token NUMBER VARIABLE COMMA INT IF ELSE START LEFT_BRAC RIGHT_BRAC ASSIGN PLUS MINUS DIV MULT LESS GREAT FOR SEMI
%token GREAT_EQ LEFT_BK RIGHT_BK COLON LEFT_PAREN RIGHT_PAREN LESS_EQ END
%token EQUAL
%nonassoc IFX
%nonassoc ELSE 
%nonassoc FOR
%left LESS GREAT
%left PLUS MINUS
%left MULT DIV
 
%%

start: START stat END { fprintf(yyout,"Successfully executed\n");}
     ;

stat: statement
    | declaration
    | stat statement
    | stat declaration
    ;
	
statement: expression 
         |IF LEFT_BK expression RIGHT_BK LEFT_BRAC expression RIGHT_BRAC { {fprintf(yyout,"Single If executed\n");} } 
	 |IF LEFT_BK expression RIGHT_BK LEFT_BRAC expression RIGHT_BRAC ELSE LEFT_BRAC expression RIGHT_BRAC	{if($3){fprintf(yyout,"If executed\n");}else {fprintf(yyout,"Else executed\n");}}		
         |FOR LEFT_BK expression COLON expression RIGHT_BK LEFT_BRAC expression RIGHT_BRAC { 
    int start = $3;
    int end = $5;
    int step = 1;
    if (start <= end) {
        for (int i = start; i <= end; i += step) {
            fprintf(yyout, "Expression in for loop: %d\n", $8);
        }
    } else {
        fprintf(yyout, "Invalid for loop condition: Start value is not less than or equal to end value\n");
    }}
       	;

	
declaration: INT VARIABLE {fprintf(yyout, "Variable %c declared\n", $2); } 
	   ;


expression: NUMBER {$$=$1;}
	|VARIABLE    {$$=arr[$1];}
	|VARIABLE ASSIGN expression { arr[$1]=$3; $$=$3; fprintf(yyout,"Value of this variable: %d\t\n",$3); }
	|expression PLUS expression {$$=$1+$3;}
	|expression MINUS expression {$$=$1-$3;}
	|expression MULT expression {$$=$1*$3;}
	|expression DIV expression {if($3) {$$=$1/$3;}}
	|expression LESS expression {$$=$1<$3;}
	|expression GREAT expression {$$=$1>$3;}
	|expression EQUAL expression {$$=$1==$3;}
	|LEFT_BRAC expression RIGHT_BRAC   {$$=$2;}
	;
       
%%

int yywrap()
{
return 1;
}
int main(void)
{
	yyin = fopen("input.txt","r");
	yyout = fopen("output.txt","w");
	yyparse();
}

int yyerror(char *s) 
{
	fprintf(yyout,"%s\n",s);
	return(0);
}