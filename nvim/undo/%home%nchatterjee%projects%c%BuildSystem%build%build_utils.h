Vim�UnDo� �}`J��cP��%_�qe��������eG��   7                                   _l΄    _�                             ����                                                                                                                                                                                                                                                                                                                                                             _l�x     �   
      8          #include "libs/tomlc99/toml.h"5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _l�y    �   5   7            printf(RESET);�   4   6          &  printf("%-9s %s", "[SUCCESS]", msg);�   3   5            printf(GREEN);�   /   1            printf(RESET);�   .   0          /  fprintf(stderr, "%-9s %s\n", "[ERROR]", msg);�   -   /            printf(RED);�   )   +            printf(RESET);�   (   *          (  printf("%-9s %s\n", "[WARNING]", msg);�   '   )            printf(YELLOW);�   #   %            printf(RESET);�   "   $          %  printf("%-9s %s\n", "[INFO]", msg);�   !   #            printf(BLUE);�                  return res;�                  toml_rtos(toml_raw, &res);�                  char *res;�                1  toml_raw_t toml_raw = toml_raw_in(table, name);�                  return atoll(str);�                  pclose(command);�                #  fgets(str, sizeof(str), command);�                "  FILE *command = popen(str, "r");�                '  sprintf(str, "stat -c %%Y %s", file);�                  char str[50];�         7      	memset(str, 0, sizeof(str));5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                             _l΂     �   
      7      #include "libs/tomlc99/toml.h"5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                             _l΂     �   
      7      #include "tomlc99/toml.h"5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             _l΃    �   5   7   7      	printf(RESET);�   4   6   7      %	printf("%-9s %s", "[SUCCESS]", msg);�   3   5   7      	printf(GREEN);�   /   1   7      	printf(RESET);�   .   0   7      .	fprintf(stderr, "%-9s %s\n", "[ERROR]", msg);�   -   /   7      	printf(RED);�   )   +   7      	printf(RESET);�   (   *   7      '	printf("%-9s %s\n", "[WARNING]", msg);�   '   )   7      	printf(YELLOW);�   #   %   7      	printf(RESET);�   "   $   7      $	printf("%-9s %s\n", "[INFO]", msg);�   !   #   7      	printf(BLUE);�         7      	return res;�         7      	toml_rtos(toml_raw, &res);�         7      	char *res;�         7      0	toml_raw_t toml_raw = toml_raw_in(table, name);�         7      	return atoll(str);�         7      	pclose(command);�         7      "	fgets(str, sizeof(str), command);�         7      	memset(str, 0, sizeof(str));�         7      !	FILE *command = popen(str, "r");�         7      &	sprintf(str, "stat -c %%Y %s", file);�         7      	char str[50];5��