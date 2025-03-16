#include "tmp/calcu.tab.hpp"
#include "tmp/lex.yy.h" 

#include <cstdlib>
#include <cstring>
#include <cstdio>

int main(int argc, char* argv[]) {
  int precision = -1;

  for (int i = 1; i < argc; ++i) {
    if (strcmp(argv[i], "-p") == 0 && i + 1 < argc) {
      precision = std::atoi(argv[i + 1]);
      ++i;
    }
    else if (strcmp(argv[i], "-h")) {
      printf("usage: %s [-h] [-p PRECISION] EXPRS", argv[0]);
    }
    else {
      fprintf(stderr, "argument error: use `%s -h` for help", argv[0]);
      exit(-1);
    }
  }

  constexpr size_t max_input_size = 2048;
  char input[max_input_size] = {};
  fgets(input, max_input_size - 1, stdin);
  YY_BUFFER_STATE buffer = yy_scan_string(input);

  double result = 0;
  yyparse(result);
  yy_delete_buffer(buffer);

  if (precision < 0) {
    printf("%lg\n", result);
  }
  else {
    printf("%.*lg\n", precision, result);
  }

  return 0;
}