%option noyywrap
%option nounput
%option noinput
%option header="tmp/lex.yy.h"
%option nodebug

%{
  #include "calcu.tab.hpp"
  #include "../include/table.h"

  #include <cstdlib>

  #include <cstdio>
%}

WhiteSpace    [ \t\n\r]
Identifier    [a-zA-Z_][a-zA-Z0-9_]*

Number        [0-9]+(\.[0-9]*)?|\.[0-9]+

%%

{WhiteSpace}

{Number} {
  yylval.Double = atof(yytext);
  return TK_NUMBER;
}

{Identifier} {
  const auto it = symbol_table.find(yytext);
  if (it != symbol_table.end()) {
    yylval.Double = symbol_table.find(yytext)->second;
    return TK_NUMBER;
  } else {
    strcpy(yylval.String, yytext);
    return TK_FUNC;
  }
}

. { return yytext[0]; }

%%
