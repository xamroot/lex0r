%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}


%%

[0-9]+		{ yylval.i = atoi(yytext); return INT; }
point			{ return POINT; }
line			{ return LINE; }
rectangle		{ return RECTANGLE; }
circle			{ return CIRCLE; }
set_color		{ return SET_COLOR; }
;				{ return END_STATEMENT; }
END 			{ return END; }
[ \t\s\n\r]		;

%%

// no code needed here (unlike in expression.y) !