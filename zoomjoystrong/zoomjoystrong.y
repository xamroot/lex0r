%{

	#include "zoomjoystrong.c"
	#include <stdio.h>
	#include <signal.h>
	void yyerror(const  char* msg);
	int yylex();
%}

%union {int i; float f;}

%start statements

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT

%%

statements:	statement
			|	statements statement
;

statement:		point
			|	line
			|	rectangle
			|	circle
			|	set_color
;

point:		POINT INT INT END_STATEMENT		{ 
		point($2, $3);
	}
;

line:		LINE INT INT INT INT END_STATEMENT		{ 
		line($2, $3, $4, $5);
	}
;

circle:		CIRCLE INT INT INT END_STATEMENT		{ 
		circle($2, $3, $4);
	}
;

rectangle:		RECTANGLE INT INT INT INT END_STATEMENT		{ 
		rectangle($2, $3, $4, $5);
	}
;

set_color:		SET_COLOR INT INT INT END_STATEMENT		{ 
		set_color($2, $3, $4);
	}
;

%%

static volatile int running = 1;

void killhandler () {
	running = 0;
}

void yyerror(const char* msg) {
	printf("error has occurred\n");
	fprintf(stderr, "ERROR!: %s\n", msg);
}

int main(int argc, char** argv) {
	setup();
	set_color(255,255,255);
	yyparse();

	signal(SIGINT, killhandler);

	while(running);
}