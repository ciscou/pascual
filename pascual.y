%{
  #define MODULO 65536 // Lazy man's way to store two numbers in a 32 bits integer

  int yylex();
  void yyerror(char *);

  char code[1024][256];
  int code_idx = 0;
%}

%union {
  int num;
  char* id;
}

%token<num> IF
%token THEN
%token ELSE
%token<num> WHILE
%token DO
%token AND
%token OR
%token NOT
%token LTE
%token GTE
%token NEQ
%token TK_BEGIN
%token END
%token WRITELN
%token READLN
%token ARRAY
%token<id> ID
%token ASSIGN
%token DIV
%token MOD
%token<num> NUM

%left AND
%left OR
%left NOT

%%

lines:
  line
| lines ';' line
;

line:
| TK_BEGIN lines END
| IF cond {
    // reserve space for jz instruction
    $1 = code_idx++
  } THEN line {
    // reserve space for jmp instruction
    $1 += MODULO * code_idx++;
    // back patch jz instruction
    sprintf(code[$1 % MODULO], "jz %d", code_idx)
  } ELSE line {
    // back patch jmp instruction
    sprintf(code[$1 / MODULO], "jmp %d", code_idx)
  }
| WHILE {
    // save address of jmp instruction
    $1 = MODULO * code_idx
  } cond {
    // reserve space for jz instruction
    $1 += code_idx++
  } DO line {
    // jump back to re-evaluate condition
    sprintf(code[code_idx++], "jmp %d", $1 / MODULO);
    // back patch jz instruction
    sprintf(code[$1 % MODULO], "jz %d", code_idx)
  }
| ID ASSIGN expression {
    sprintf(code[code_idx++], "store %s", $1)
  }
| ID ASSIGN ARRAY '(' expression ')' {
    sprintf(code[code_idx++], "mkarray %s", $1)
  }
| ID '[' expression ']' ASSIGN expression {
    sprintf(code[code_idx++], "storearr %s", $1)
  }
| WRITELN '(' expression ')' {
    sprintf(code[code_idx++], "writeln")
  }
;

expression:
  factor
| expression '+' factor {
    sprintf(code[code_idx++], "+")
  }
| expression '-' factor {
    sprintf(code[code_idx++], "-")
  }
;

factor:
  term
| factor '*' term {
    sprintf(code[code_idx++], "*")
  }
| factor '/' term {
    sprintf(code[code_idx++], "/")
  }
| factor DIV term {
    sprintf(code[code_idx++], "div")
  }
| factor MOD term {
    sprintf(code[code_idx++], "mod")
  }
;

term:
  NUM {
    sprintf(code[code_idx++], "%d", $1)
  }
| ID {
    sprintf(code[code_idx++], "load %s", $1)
  }
| '(' expression ')'
| '+' term
| '-' term {
    sprintf(code[code_idx++], "-1");
    sprintf(code[code_idx++], "*")
  }
| READLN '(' ')' {
    sprintf(code[code_idx++], "readln")
  }
| ID '[' expression ']' {
    sprintf(code[code_idx++], "loadarr %s", $1)
  }
;

cond:
  '(' cond ')'
| cond OR cond {
    sprintf(code[code_idx++], "or")
  }
| cond AND cond {
    sprintf(code[code_idx++], "and")
  }
| NOT cond {
    sprintf(code[code_idx++], "not")
  }
| expression '=' expression {
    sprintf(code[code_idx++], "eq")
  }
| expression '<' expression {
    sprintf(code[code_idx++], "lt")
  }
| expression '>' expression {
    sprintf(code[code_idx++], "gt")
  }
| expression LTE expression {
    sprintf(code[code_idx++], "lte")
  }
| expression GTE expression {
    sprintf(code[code_idx++], "gte")
  }
| expression NEQ expression {
    sprintf(code[code_idx++], "neq")
  }
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
