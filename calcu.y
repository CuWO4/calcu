%code requires {
  #include "../include/table.h"

  #include <cmath>
  #include <cstdio>

  int yylex();
  void yyerror(double& result, const char* s);
}

%{
%}

%parse-param  { double& result }

%union {
  double Double;
  char String[64];
}

%token <Double> TK_NUMBER
%token <String> TK_FUNC

%type <Double> exp

%left '+' '-'
%left '*' '/'
%right PREC_UNARY_OP
%right '^'
%right '!'

%%

line : exp { result = $1; }

exp
  : TK_NUMBER
  | '(' exp ')' { $$ = $2; }
  | '|' exp '|' { $$ = std::abs($2); }
  | '[' exp ']' { $$ = std::floor($2); }
  | exp '!' { $$ = std::tgamma($1 + 1); }
  | '+' exp %prec PREC_UNARY_OP { $$ = $2; }
  | '-' exp %prec PREC_UNARY_OP { $$ = -$2; }
  | exp '+' exp { $$ = $1 + $3; }
  | exp '-' exp { $$ = $1 - $3; }
  | exp '*' exp { $$ = $1 * $3; }
  | exp '/' exp { $$ = $1 / $3; }
  | exp '^' exp { $$ = std::pow($1, $3); }
  | TK_FUNC '(' exp ')' {
    const auto it = ufunc_table.find($1);

    if (it == ufunc_table.end()) {
      fprintf(stderr, "unknown function `%s`\n", $1);
      exit(-1);
    }

    $$ = it->second($3);
  }
  | TK_FUNC '(' exp ',' exp ')' {
    const auto it = bfunc_table.find($1);

    if (it == bfunc_table.end()) {
      fprintf(stderr, "unknown function `%s`\n", $1);
      exit(-1);
    }

    $$ = it->second($3, $5);
  }

%%

void yyerror(double& result, const char* s) {
  fprintf(stderr, "error: %s\n", s);
  exit(-1);
}
