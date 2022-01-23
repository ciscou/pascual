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
"array"          { return ARRAY; }
":="             { return ASSIGN; }
[0-9]+           { yylval.num = atoi(yytext); return NUM; }
";"              { return ';'; }
"+"              { return '+'; }
"-"              { return '-'; }
"*"              { return '*'; }
"/"              { return '/'; }
"("              { return '('; }
")"              { return ')'; }
"["              { return '['; }
"]"              { return ']'; }
"="              { return '='; }
"<"              { return '<'; }
">"              { return '>'; }
"<="             { return LTE; }
">="             { return GTE; }
"<>"             { return NEQ; }
"div"            { return DIV; }
"mod"            { return MOD; }
[a-z][a-z0-9_]*  { yylval.id = strdup(yytext); return ID; }

%%
