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

%token <str_val> CONST VAR IF ELSE WHILE OUT RETURN FUNCTION
%token <int_val> INT
%token EQ NEQ LT LTE GT GTE AND OR PLUS MINUS MULT DIV MOD POW
%token LPAR RPAR LBRACE RBRACE LBRAKET RBRAKET ASGN FASGN SC COM NEWLINE
%token STR ID

%start program

%%

program: stmts
       | /* empty */

stmts: stmt SC
     | stmt SC stmts

stmt: CONST ID ASGN expr
    | VAR ID
    | VAR ID ASGN expr
    | ID ASGN expr
    | IF LPAR cond RPAR LBRACE stmts RBRACE
    | IF LPAR cond RPAR LBRACE stmts RBRACE ELSE LBRACE stmts RBRACE
    | WHILE LPAR cond RPAR LBRACE stmts RBRACE
    | OUT LPAR out_param RPAR
    | VAR arr
    | arr ASGN expr
    | RETURN expr
    | func_def
    | func_call

out_param: expr
         | STR
         | expr COM out_param
         | STR COM out_param

func_def: FUNCTION ID LPAR param_def RPAR FASGN LBRACE stmts RBRACE

param_def: /* empty */
         | ID
         | ID COM param_def

expr: term
    | term PLUS expr
    | term MINUS expr
    | term MULT expr
    | term DIV expr
    | term MOD expr
    | term POW expr

term: ID
    | INT
    | IN
    | func_call
    | arr
    | LPAR expr RPAR /*LOOK*/

in: IN LPAR RPAR

arr: ID LBRAKET expr RBRAKET

cond: expr comp_op expr
    | expr comp_op cond

comp_op: EQ | NEQ | LT | LTE | GT | GTE | AND | OR

int: int_start int_end

int_start:  | MINUS
int_end: DIGIT | DIGIT int_end

func_call: ID LPAR params RPAR

params: /* empty */
      | expr
      | expr COM params

ID: LETTER id_chars

id_chars: /* empty */
         | id_char id_chars

id_char: LETTER
       | DIGIT
       | _

STR: DOUBLE_QUOTE char_list DOUBLE_QUOTE

char_list: LETTER
         | DIGIT
         | SPECIAL
         | LETTER char_list
         | DIGIT char_list
         | SPECIAL char_list

DIGIT: 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

LETTER: a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z
      | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z

SPECIAL:  PLUS | MINUS | MULT | DIV | POW | EXCLAMATION | QUESTION | PERCENT | AMPERSAND | SPACE
       | LPAR | RPAR | LBRACE | RBRACE | LBRAKET | RBRAKET | EQUALS | DOT | COMMA | SEMICOLON | COLON | UNDERSCORE
       | NEWLINE | HASH | DOLLAR


PLUS: +

MINUS: -

MULT: *

DIV: /

POW: ^

EXCLAMATION: !

QUESTION: ?

PERCENT: %

AMPERSAND: &

SPACE: ' '

LPAR: (

RPAR: )

LBRACE: {

RBRACE: }

LBRAKET: [

RBRAKET: ]

EQUALS: =

DOT: .

COMMA: ,

SEMICOLON: ;

COLON: :

UNDERSCORE: _

NEWLINE: \n

HASH: #


DOUBLE_QUOTE: \"

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error on line %d: %s\n", yylineno, s);
}
