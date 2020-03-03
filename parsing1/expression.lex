%{
	#include "expression.tab.h"
	#include <stdlib.h>
%}


%%

[0-9]+		{ yylval.i = atoi(yytext); return NUMBER; }
\+			{ return ADD_OP; }
\-			{ return SUB_OP; }
\*			{ return MUL_OP; }
\/			{ return DIV_OP; }
;			{ return SEPARATOR; }
[ \t\s\n\r]	;

%%

// no code needed here (unlike in expression.y) !