%{
  int yylex();
  void yyerror(char *);

  int current_instruction = 0;

  void generate_code(char *);
  void next_instruction();
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
| lines line '\n'
;

line:
| IF '(' cond ')' '\n' { printf("IF %d\n", current_instruction) } lines ELSE '\n' { printf("ELSE %d\n", current_instruction) } lines FI { printf("FI %d\n", current_instruction) }
| VAR ASSIGN expression { printf("store %c\n", $1); next_instruction() }
| WRITELN '(' expression ')' { generate_code("writeln") }
| expression            { }
;

expression:
  factor
| expression '+' factor { generate_code("+") }
| expression '-' factor { generate_code("-") }
;

factor:
  term
| factor '*' term { generate_code("*") }
| factor '/' term { generate_code("/") }
;

term:
  NUM                { printf("%d\n", $1); next_instruction() }
| VAR                { printf("load %c\n", $1); next_instruction() }
| '(' expression ')' {}
| '+' term           {}
| '-' term           { generate_code("-1"); generate_code("*") }
;

cond:
  expression '=' expression { generate_code("eq") }
| expression '<' expression { generate_code("lt") }
| expression '>' expression { generate_code("gt") }
;

%%

int main() {
  yyparse();
  return 0;
}

void yyerror(char* s) {
  printf("Error %s\n", s);
}

void generate_code(char *code) {
  printf("%s\n", code);
  next_instruction();
}

void next_instruction() {
  current_instruction++;
}
