%{
  int yylex();
  void yyerror(char *);

  void set_var(char, int);
  int get_var(char);

  int vars[26];

  int cond = 1;
%}

%union {
  int num;
  char sym;
}

%token IF
%token ELSE
%token FI
%token WRITELN
%token<sym> VAR
%token ASSIGN
%token<num> NUM

%%

lines:
| lines line
;

line:
  '\n'
| IF cond '\n' lines FI '\n' {           } // TODO: generate code for if (must remember which instructions to jump
| IF cond '\n' lines ELSE '\n' lines FI '\n' {           } // TODO: generate code for if (must remember which instructions to jump
| VAR ASSIGN expression '\n' { printf("store %c\n", $1) }
| WRITELN '(' expression ')' '\n' { printf("writeln\n") }
| expression '\n'            { }
;

expression:
  factor
| expression '+' factor { printf("+\n") }
| expression '-' factor { printf("-\n") }
;

factor:
  term
| factor '*' term { printf("*\n") }
| factor '/' term { printf("/\n") }
;

term:
  NUM                { printf("%d\n", $1) }
| VAR                { printf("load %c\n", $1) }
| '(' expression ')' {}
| '+' term           {}
| '-' term           { printf("-1\n"); printf("*\n") }
;

cond:
  expression '=' expression { printf("eq\n") }
;

%%

int main() {
  for(int i=0; i<26; i++) vars[i] = 0;
  yyparse();
  return 0;
}

void yyerror(char* s) {
  printf("Error %s\n", s);
}

void set_var(char var, int val) {
  vars[var - 'a'] = val;
}

int get_var(char var) {
  return vars[var - 'a'];
}
