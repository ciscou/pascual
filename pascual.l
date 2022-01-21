%{
  #include "pascual.tab.h"
%}

%%

[ \t\n]          {}
"if"             { return IF; }
"then"           { return THEN; }
"else"           { return ELSE; }
"while"          { return WHILE; }
"do"             { return DO; }
"begin"          { return TK_BEGIN; }
"end"            { return END; }
"or"             { return OR; }
"and"            { return AND; }
"not"            { return NOT; }
"writeln"        { return WRITELN; }
"readln"         { return READLN; }
[a-z]            { yylval.sym = yytext[0]; return ID; }
":="             { return ASSIGN; }
[0-9]+           { yylval.num = atoi(yytext); return NUM; }
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
