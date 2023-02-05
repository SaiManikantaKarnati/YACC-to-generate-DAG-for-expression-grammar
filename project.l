%{
 #include "y.tab.h"

 #include <stdlib.h>
%}
d[0-9]
c[a-z]
extern char yylval;
/*
 Rules:
 If an alphabet from a to z is matched, it is sent as a token.
 If a tab character is encountered, nothing is done.
 If a new line character is encountered, code stops running.
 For anything else, the first character of the matched word is
sent as token.
*/
%%
{c} { yylval=yytext[0]; return(id); }
[\t] ;
[\n] return 0;
. return yytext[0];
%%