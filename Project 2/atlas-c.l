%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"  // Include the Yacc-generated header file
%}

%union {
    int int_val;
    char *str_val;
}

%%

"const"      { yylval.str_val = strdup(yytext); return CONST; }
"var"        { yylval.str_val = strdup(yytext); return VAR; }
"if"         { yylval.str_val = strdup(yytext); return IF; }
"else"       { yylval.str_val = strdup(yytext); return ELSE; }
"while"      { yylval.str_val = strdup(yytext); return WHILE; }
"in"         { yylval.str_val = strdup(yytext); return IN; }
"out"        { yylval.str_val = strdup(yytext); return OUT; }
"return"     { yylval.str_val = strdup(yytext); return RETURN; }
"func"       { yylval.str_val = strdup(yytext); return FUNCTION; }
[0-9]+       { yylval.int_val = atoi(yytext); return INT; }
"=="         { yylval.str_val = strdup(yytext); return EQ; }
"!="         { yylval.str_val = strdup(yytext); return NEQ; }
"<"          { yylval.str_val = strdup(yytext); return LT; }
"<="         { yylval.str_val = strdup(yytext); return LTE; }
">"          { yylval.str_val = strdup(yytext); return GT; }
">="         { yylval.str_val = strdup(yytext); return GTE; }
"and"        { yylval.str_val = strdup(yytext); return AND; }
"or"         { yylval.str_val = strdup(yytext); return OR; }
"+"          { yylval.str_val = strdup(yytext); return PLUS; }
"-"          { yylval.str_val = strdup(yytext); return MINUS; }
"*"          { yylval.str_val = strdup(yytext); return MULT; }
"/"          { yylval.str_val = strdup(yytext); return DIV; }
"mod"        { yylval.str_val = strdup(yytext); return MOD; }
"\^"         { yylval.str_val = strdup(yytext); return POW; }
"("          { yylval.str_val = strdup(yytext); return LPAR; }
")"          { yylval.str_val = strdup(yytext); return RPAR; }
"{"          { yylval.str_val = strdup(yytext); return LBRACE; }
"}"          { yylval.str_val = strdup(yytext); return RBRACE; }
"\["         { yylval.str_val = strdup(yytext); return LBRAKET; }
"\]"         { yylval.str_val = strdup(yytext); return RBRAKET; }
"="          { yylval.str_val = strdup(yytext); return ASGN; }
"=>"         { yylval.str_val = strdup(yytext); return FASGN; }
";"          { yylval.str_val = strdup(yytext); return SC; }
","          { yylval.str_val = strdup(yytext); return COM; }
\"[^"]*\"    { yylval.str_val = strdup(yytext); return STR; }
\/\*[^*]*\*\/ { yylval.str_val = strdup(yytext); return COMMENT; }
[a-zA-Z][a-zA-Z0-9_]* { yylval.str_val = strdup(yytext); return ID; }
[ \t]        ;
\n           { return NEWLINE; }
.            { return UNKNOWN; }

%%
