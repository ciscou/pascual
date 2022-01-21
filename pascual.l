%{
  #include "pascual.tab.h"
%}

%%

"if"             { return IF; }
"else"           { return ELSE; }
"fi"             { return FI; }
"while"          { return WHILE; }
"end"            { return END; }
"writeln"        { return WRITELN; }
"readln"         { return READLN; }
[a-z]            { yylval.sym = yytext[0]; return ID; }
"<-"             { return ASSIGN; }
[0-9]+           { yylval.num = atoi(yytext); return NUM; }
[ \t\n]          {}
";"              { return ';'; }
"+"              { return '+'; }
"-"              { return '-'; }
"*"              { return '*'; }
"/"              { return '/'; }
"("              { return '('; }
")"              { return ')'; }
"="              { return '='; }
"<"              { return '<'; }
">"              { return '>'; }
%%
