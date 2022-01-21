%{
  #define MOD 65536 // Lazy man's way to store two numbers in a 32 bits integer

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
%token<num> WHILE
%token END
%token WRITELN
%token READLN
%token<sym> ID
%token ASSIGN
%token<num> NUM

%%

lines:
  line
| lines ';' line
;

line:
| IF '(' cond ')' {
    // reserve space for jz instruction
    $1 = code_idx++
  } lines ELSE {
    // reserve space for jmp instruction
    $1 += MOD * code_idx++;
    // back patch jz instruction
    sprintf(code[$1 % MOD], "jz %d", code_idx)
  } lines FI {
    // back patch jmp instruction
    sprintf(code[$1 / MOD], "jmp %d", code_idx)
  }
| WHILE {
    // save address of jmp instruction
    $1 = MOD * code_idx
  } '(' cond ')' {
    // reserve space for jz instruction
    $1 += code_idx++
  } lines END {
    // jump back to re-evaluate condition
    sprintf(code[code_idx++], "jmp %d", $1 / MOD);
    // back patch jz instruction
    sprintf(code[$1 % MOD], "jz %d", code_idx)
  }
| ID ASSIGN expression {
    sprintf(code[code_idx++], "store %c", $1)
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
;

term:
  NUM {
    sprintf(code[code_idx++], "%d", $1)
  }
| ID {
    sprintf(code[code_idx++], "load %c", $1)
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
;

cond:
  expression '=' expression {
    sprintf(code[code_idx++], "eq")
  }
| expression '<' expression {
    sprintf(code[code_idx++], "lt")
  }
| expression '>' expression {
    sprintf(code[code_idx++], "gt")
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
