%{
  int yylex();
  void yyerror(char *);

  void set_var(char, int);
  int get_var(char);

  int vars[26];
%}

%union {
  int num;
  char sym;
}

%token<sym> VAR
%token ASSIGN
%token<num> NUM

%type<num> expression
%type<num> factor
%type<num> term

%%

lines:
| lines line '\n'
;

line:
| VAR ASSIGN expression { set_var($1, $3); printf("%d\n", $3) }
| expression { printf("%d\n", $1) }
;

expression:
  factor
| expression '+' factor { $$ = $1 + $3 }
| expression '-' factor { $$ = $1 - $3 }
;

factor:
  term
| factor '*' term { $$ = $1 * $3 }
| factor '/' term { $$ = $1 / $3 }
;

term:
  NUM { $$ = $1 }
| VAR { $$ = get_var($1) }
| '(' expression ')' { $$ = $2 }
| '+' term { $$ = $2 }
| '-' term { $$ = -$2 }
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
