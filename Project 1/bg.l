%{
#include <stdio.h>
#include <string.h>
%}

%%
"const"      { printf("CONST "); }
"var"        { printf("VAR "); }
"if"         { printf("IF "); }
"else"       { printf("ELSE "); }
"while"      { printf("WHILE "); }
"in"         { printf("IN "); }
"out"        { printf("OUT "); }
[0-9]+       { printf("INT "); }
"=="         { printf("EQ "); }
"!="         { printf("NEQ "); }
"<"          { printf("LT "); }
"<="         { printf("LTE "); }
">"          { printf("GT "); }
">="         { printf("GTE "); }
"and"        { printf("AND "); }
"or"         { printf("OR "); }
"+"          { printf("PLUS "); }
"-"          { printf("MINUS "); }
"*"          { printf("MULT "); }
"/"          { printf("DIV "); }
"mod"        { printf("MOD "); }
"\^"         { printf("POW "); }
"("          { printf("LPAR "); }
")"          { printf("RPAR "); }
"{"          { printf("LBRACE "); }
"}"          { printf("RBRACE "); }
"\["         { printf("LBRAKET "); }
"\]"         { printf("RBRAKET "); }
"="          { printf("ASGN "); }
";"          { printf("SC "); }
","          { printf("COM "); }
\"[^"]*\"    { printf("STR "); }
\/\*[^*]*\*\/ { printf("COMMENT "); }
[a-zA-Z][a-zA-Z0-9_]* { printf("ID "); }
[ \t]        ;
\n           { printf("\n"); }
.            { printf("UNKNOWN "); }

%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
