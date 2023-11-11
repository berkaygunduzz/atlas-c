%{
#include <stdio.h>
%}

%token CONST VAR IF ELIF ELSE WHILE IN OUT RETURN FUNCTION
%token INT
%token LPAR RPAR LBRACE RBRACE LBRAKET RBRAKET SC COM STR ID
%left OR
%left AND
%left EQ NEQ
%left LT LTE GT GTE
%left PLUS MINUS
%left MULT DIV MOD
%right POW
%right ASGN FASGN

%%

program: stmts 
    |
stmts: stmt SC
    | stmt SC stmts

stmt: CONST ID asgn
    | var_decl
    | var_decl asgn
    | ID asgn
    | if_stmt
    | WHILE LPAR cond RPAR LBRACE stmts RBRACE
    | OUT LPAR out_param RPAR
    | VAR arr ASGN init_arr
    | VAR arr
    | arr asgn
    | RETURN expr
    | func_def
    | func_call

var_decl: VAR ID

asgn: ASGN expr

if_stmt: IF LPAR cond RPAR LBRACE stmts RBRACE else_part

else_part: ELSE LBRACE stmts RBRACE
         | ELIF LPAR cond RPAR LBRACE stmts RBRACE else_part
         | /* empty */

cond: or_expr

or_expr: and_expr
        | or_expr OR and_expr

and_expr: comp_expr
         | and_expr AND comp_expr

comp_expr: expr
         | expr comp_op expr
         | LPAR expr comp_op expr RPAR

expr: term
    | term op expr

term: ID
    | INT
    | in
    | func_call
    | arr
    | LPAR expr RPAR

in: IN LPAR RPAR

arr: ID arr_dims

arr_dims: LBRAKET expr RBRAKET
        | LBRAKET expr RBRAKET arr_dims

out_param: expr
         | STR
         | expr COM out_param
         | STR COM out_param

init_arr: LBRACE arr_val RBRACE

arr_val: expr
       | init_arr
       | expr COM arr_val
       | init_arr COM arr_val

func_def: FUNCTION ID LPAR param_def RPAR FASGN LBRACE stmts RBRACE

param_def: /* empty */
         | ID
         | ID COM param_def

func_call: ID LPAR params RPAR

params: /* empty */
      | expr
      | expr COM params

op: PLUS
   | MINUS
   | MULT
   | DIV
   | MOD
   | POW

comp_op: EQ
        | NEQ
        | LT
        | LTE
        | GT
        | GTE

%%

#include "atlas-c.lex.c"

int lineno = 0;
int valid_program = 1; // Initially, assume the program is valid

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error on line %d: %s\n", yylineno, s);
    valid_program = 0; // Mark the program as invalid
}

int main() {
    yyparse();
    if (valid_program) {
        printf("Input program is valid\n");
    }
    return 0;
}
