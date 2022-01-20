%{
  #include "pascual.tab.h"
%}

%%

"if"             { return IF; }
"fi"             { return FI; }
"writeln"        { return WRITELN; }
[a-z]            { yylval.sym = yytext[0]; return VAR; }
"<-"             { return ASSIGN; }
[0-9]+           { yylval.num = atoi(yytext); return NUM; }
[ \t]            {}
"+"              { return '+'; }
"-"              { return '-'; }
"*"              { return '*'; }
"/"              { return '/'; }
"\n"             { return '\n'; }
"("              { return '('; }
")"              { return ')'; }
"="              { return '='; }
%%
