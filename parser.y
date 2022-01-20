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

%left '+' '-'
%left '*' '/'

%type<num> exp

%%

input:
| input line '\n'
;

line:
| VAR ASSIGN exp { set_var($1, $3); printf("%d\n", $3) }
| exp { printf("%d\n", $1) }
;

exp:
  NUM { $$ = $1 }
| VAR { $$ = get_var($1) }
| exp '+' exp { $$ = $1 + $3 }
| exp '-' exp { $$ = $1 - $3 }
| exp '*' exp { $$ = $1 * $3 }
| exp '/' exp { $$ = $1 / $3 }
| '(' exp ')' { $$ = $2 }
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
