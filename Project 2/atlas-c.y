%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct SymbolTable {
    char* name;
    int value;
};

int return_value = 0;  // Global return value

char* arr_special = "";

int global_operator = -1;
//char* global_operator = "";

int cond_return = 0;

struct SymbolTable symbol_table[100]; // Assuming a maximum of 100 variables

int symbol_table_size = 0; // To keep track of the number of variables

void add_variable(char* name, int value) {
    symbol_table[symbol_table_size].name = strdup(name);
    symbol_table[symbol_table_size].value = value;
    symbol_table_size++;
}

int find_variable(char* name) {
    for (int i = 0; i < symbol_table_size; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return symbol_table[i].value;
        }
    }
    return -1; // Return -1 if the variable is not found
}


extern int yylex();
void yyerror(const char* s);
%}

%union {
    int int_val;
    char* str_val;
}

%token CONST VAR IF ELSE WHILE IN OUT RETURN FUNCTION
%token INT EQ NEQ LT LTE GT GTE AND OR PLUS MINUS MULT DIV MOD POW
%token LPAR RPAR LBRACE RBRACE LBRAKET RBRAKET ASGN FASGN SC COM STR COMMENT
%token ID UNKNOWN NEWLINE

%type <int_val> int
%type <str_val> str
%type <str_val> id
%type <str_val> id_chars
%type <str_val> letter
%type <str_val> special
%type <str_val> char_list
%type <str_val> digit
%type <str_val> op
%type <str_val> comp_op
%type <str_val> term
%type <str_val> expr
%type <str_val> in
%type <str_val> arr
%type <str_val> cond
%type <str_val> func_def
%type <str_val> param_def
%type <str_val> func_call
%type <str_val> params
%type <str_val> stmt
%type <str_val> stmts
%type <str_val> out_param

%%

program: stmts
       ;

stmts: stmt
     | stmt SC
     | stmt SC stmts
     ;

stmt: CONST id ASGN expr { if(find_variable($2) == -1){add_variable($2, $4);} else {/*ERROR*/} }
    | VAR id { if(find_variable($2) == -1){add_variable($2, 0);} else {/*ERROR*/} }
    | VAR id ASGN expr { if(find_variable($2) == -1){add_variable($2, $4);} else {/*ERROR*/} }
    | id ASGN expr { if(find_variable($1) != -1){add_variable($1, $3);} else {/*ERROR*/} }
    | IF LPAR cond RPAR LBRACE stmts RBRACE { if( $3 !=0 ){ $6; } }
    | IF LPAR cond RPAR LBRACE stmts RBRACE ELSE LBRACE stmts RBRACE { if( $3 !=0 ){ $6; } else { $10; } }
    | WHILE LPAR cond RPAR LBRACE stmts RBRACE { while( $3 !=0 ){ $6; } }
    | OUT LPAR out_param RPAR { if($3 != ""){ printf($3); } else { printf("\n");} }
    | VAR arr { $2; }
    | arr ASGN expr { if(find_variable($1) != -1){add_variable(arr_special, $3);} else {/*ERROR*/} } //////// emin değilim bence yanlış hatta arrayler ama bir yandan '[' ve ']' isim verilirken kullanilamiyor o yuzden arraylerde özel bir isim olur?
    | RETURN expr { return_value = $2; }
    | func_def		////////// Bu hem mantikli hem de karisik baya 
    | func_call
    ;

out_param: expr
         | str
         | expr COM out_param
         | str COM out_param
         ;

func_def: id LPAR param_def RPAR FASGN LBRACE stmts RBRACE
        ;

param_def: /* empty */
         | id
         | id COM param_def
         ;

expr: term
    | term op expr
    ;

term: id
    | int
    | in
    | func_call
    | arr
    | LPAR expr RPAR
    ;

in: IN LPAR RPAR
   ;

arr: id LBRAKET expr RBRAKET { if(find_variable($1) != -1){ arr_special = $1 + "[" + $3 + "]";} else { for(int i = 0; i < $3; i++){add_variable($1 + "[" + i + "]", 0);} } }
    ;

cond: expr comp_op expr { switch(global_operator){case 0: cond_return = ($1 == $3); break;
						  case 1: cond_return = ($1 != $3); break;
						  case 2: cond_return = ($1 < $3); break;
						  case 3: cond_return = ($1 <= $3); break;
						  case 4: cond_return = ($1 > $3); break;
						  case 5: cond_return = ($1 >= $3); break;
						  case 6: cond_return = ($1 && $3); break;
						  case 7: cond_return = ($1 && $3); break; } }
     | expr comp_op cond  //// bence bu line olmayacak x < y < z mantiksiz oluyor
     ;

op: PLUS
   | MINUS
   | MULT
   | DIV
   | MOD
   | POW
   ;

comp_op: EQ { global_operator = 0; }
        | NEQ { global_operator = 1; }
        | LT { global_operator = 2; }
        | LTE { global_operator = 3; }
        | GT { global_operator = 4; }
        | GTE { global_operator = 5; }
        | AND { global_operator = 6; }
        | OR { global_operator = 7; }
        ;

int: digit
   | digit int
   ;

func_call: id LPAR params RPAR
         ;

params: /* empty */
      | expr
      | expr COM params
      ;

id: letter
   | letter id_chars
   ;

id_chars: id_char
         | id_char id_chars
         ;

id_char: letter
        | digit
        | special
        | '_'
        ;

letter: 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm' | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z' | 'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G' | 'H' | 'I' | 'J' | 'K' | 'L' | 'M' | 'N' | 'O' | 'P' | 'Q' | 'R' | 'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z'
        ;

special: '\'' | '+' | '-' | '*' | '/' | '^' | '!' | '?' | '%' | '&' | ' ' | '(' | ')' | '[' | ']' | '{' | '}' | '=' | '.' | ',' | ';' | ':' | '_'
        ;

str: STR
   ;

char_list: letter
         | digit
         | special
         | letter char_list
         | digit char_list
         | special char_list
         ;

digit: '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
     ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
