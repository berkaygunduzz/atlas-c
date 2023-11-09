%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern void yyerror(const char*);
%}

%union {
    int int_val;
    char *str_val;
}

%token <str_val> CONST VAR IF ELSE WHILE IN OUT RETURN FUNCTION
%token <int_val> INT
%token EQ NEQ LT LTE GT GTE AND OR PLUS MINUS MULT DIV MOD POW
%token LPAR RPAR LBRACE RBRACE LBRAKET RBRAKET ASGN FASGN SC COM NEWLINE STR ID COMMENT UNKNOWN

%start program

%%

program: statement_list
       | /* empty */

statement_list: statement
              | statement_list statement

statement: declaration
         | assignment
         | /* other statement types */

declaration: CONST ID SC
           | VAR ID SC
           | FUNCTION ID LPAR parameter_list RPAR LBRACE statement_list RBRACE SC
           | /* other declaration types */

parameter_list: /* empty */
              | parameter
              | parameter_list COM parameter

parameter: VAR ID

assignment: ID ASGN expression SC

expression: INT
          | ID
          | STR
          | expression PLUS expression
          | expression MINUS expression
          | expression MULT expression
          | expression DIV expression
          | expression MOD expression
          | expression POW expression
          | expression EQ expression
          | expression NEQ expression
          | expression LT expression
          | expression LTE expression
          | expression GT expression
          | expression GTE expression
          | expression AND expression
          | expression OR expression
          | LPAR expression RPAR
          | FUNCTION_CALL ID LPAR argument_list RPAR

argument_list: /* empty */
             | expression
             | argument_list COM expression

FUNCTION_CALL: "call"

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error on line %d: %s\n", yylineno, s);
}
