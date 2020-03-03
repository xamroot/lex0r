%{

	#include <stdio.h>
	void yyerror(const  char* msg);
	int yylex();
%}

%union {int i;}

%start calculations

%token NUMBER
%token ADD_OP
%token SUB_OP
%token MUL_OP
%token DIV_OP
%token SEPARATOR

%type<i> NUMBER

%%

calculations:	expression
			|	calculations expression
;

expression:		add_exp
			|	sub_exp
			|	mul_exp
			|	div_exp
;

add_exp:		NUMBER ADD_OP NUMBER SEPARATOR		{ 
		printf("ADD DETECTED: %d + %d = %d\n", $1, $3, $1 + $3); 
	}
;

sub_exp:		NUMBER SUB_OP NUMBER SEPARATOR		{ 
		printf("SUB DETECTED: %d - %d = %d\n", $1, $3, $1 - $3); 
	}
;

mul_exp:		NUMBER MUL_OP NUMBER SEPARATOR		{ 
		printf("MULTIPLICATION DETECTED: %d * %d = %d\n", $1, $3, $1 * $3); 
	}
;

div_exp:		NUMBER DIV_OP NUMBER SEPARATOR		{ 
		printf("DIVISION DETECTED: %d / %d = %d\n", $1, $3, $1 / $3); 
	}
;

%%

int main(int argc, char** argv) {
	yyparse();
}

void yyerror(const char* msg) {
	printf("error has occurred\n");
	fprintf(stderr, "ERROR!: %s\n", msg);
}