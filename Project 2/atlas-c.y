%{
#include <stdio.h>
%}

%token CONST VAR IF ELIF ELSE WHILE IN OUT RETURN FUNCTION
%token INT EQ NEQ LT LTE GT GTE AND OR 
%token LPAR RPAR LBRACE RBRACE LBRAKET RBRAKET SC COM STR ID
%left PLUS MINUS MULT DIV MOD POW ASGN FASGN

%%
program: stmts 
    |
stmts: stmt SC
    | stmt SC stmts

stmt: CONST ID asgn
    | var_decl
    | var_decl asgn
    | ID asgn
    | IF LPAR cond RPAR LBRACE stmts RBRACE
    | IF LPAR cond RPAR LBRACE stmts RBRACE else_if
    | IF LPAR cond RPAR LBRACE stmts RBRACE else_if ELSE LBRACE stmts RBRACE
    | IF LPAR cond RPAR LBRACE stmts RBRACE ELSE LBRACE stmts RBRACE
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

else_if: ELIF LPAR cond RPAR LBRACE stmts RBRACE
       | ELIF LPAR cond RPAR LBRACE stmts RBRACE else_if

func_def: FUNCTION ID LPAR param_def RPAR FASGN LBRACE stmts RBRACE

param_def: /* empty */
         | ID
         | ID COM param_def

expr: term
    | term op expr

term: ID
    | INT
    | MINUS INT
    | PLUS INT
    | in
    | func_call
    | arr
    | cond
    | LPAR expr RPAR

in: IN LPAR RPAR

arr: ID arr_dims

arr_dims: LBRAKET expr RBRAKET
        | LBRAKET expr RBRAKET arr_dims

cond: expr comp_op expr

op: PLUS | MINUS | MULT | DIV | MOD | POW

comp_op: EQ | NEQ | LT | LTE | GT | GTE | AND | OR

out_param: expr
         | STR
         | expr COM out_param
         | STR COM out_param

init_arr: LBRACE arr_val RBRACE

arr_val: expr
       | init_arr
       | expr COM arr_val
       | init_arr COM arr_val

func_call: ID LPAR params RPAR

params: /* empty */
      | expr
      | expr COM params

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
