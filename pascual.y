%{
  int yylex();
  void yyerror(char *);

  char code[1024][256];
  int code_idx = 0;
%}

%union {
  int num;
  char sym;
}

%token<num> IF
%token ELSE
%token FI
%token WRITELN
%token<sym> VAR
%token ASSIGN
%token<num> NUM

%%

lines:
| lines line '\n'
;

line:
| IF '(' cond ')' '\n' { $1 = code_idx++ } lines ELSE '\n' { sprintf(code[$1], "jz %d", code_idx+1); $1 = code_idx++ } lines FI { sprintf(code[$1], "jmp %d", code_idx) }
| VAR ASSIGN expression { sprintf(code[code_idx++], "store %c", $1) }
| WRITELN '(' expression ')' { sprintf(code[code_idx++], "writeln") }
| expression            { }
;

expression:
  factor
| expression '+' factor { sprintf(code[code_idx++], "+") }
| expression '-' factor { sprintf(code[code_idx++], "-") }
;

factor:
  term
| factor '*' term { sprintf(code[code_idx++], "*") }
| factor '/' term { sprintf(code[code_idx++], "/") }
;

term:
  NUM                { sprintf(code[code_idx++], "%d", $1) }
| VAR                { sprintf(code[code_idx++], "load %c", $1) }
| '(' expression ')' {}
| '+' term           {}
| '-' term           { sprintf(code[code_idx++], "-1"); sprintf(code[code_idx++], "*") }
;

cond:
  expression '=' expression { sprintf(code[code_idx++], "eq") }
| expression '<' expression { sprintf(code[code_idx++], "lt") }
| expression '>' expression { sprintf(code[code_idx++], "gt") }
;

%%

int main() {
  yyparse();
  for(int i=0; i<code_idx; i++) {
    printf("%s\n", code[i]);
  }
  return 0;
}

void yyerror(char* s) {
  printf("Error %s\n", s);
}
