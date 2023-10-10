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
">"          { printf("GT "); }
"and"        { printf("AND "); }
"or"         { printf("OR "); }
"+"          { printf("PLUS "); }
"-"          { printf("MINUS "); }
"*"          { printf("MULTIPLY "); }
"/"          { printf("DIVIDE "); }
"mod"        { printf("MOD "); }
"\^"         { printf("POWER "); }
"("          { printf("LPAREN "); }
")"          { printf("RPAREN "); }
"{"          { printf("LBRACE "); }
"}"          { printf("RBRACE "); }
"\["         { printf("LBRACKET "); }
"\]"         { printf("RBRACKET "); }
"="          { printf("ASSIGN "); }
";"          { printf("SEMICOLON "); }
","          { printf("COMMA "); }
\"[^"]*\"    { printf("STRING "); }
\/\*[^*]*\*\/ { printf("COMMENT "); }
[a-zA-Z][a-zA-Z0-9_]* { printf("IDENTIFIER "); }
[ \t]        ;
\n           { printf("\n"); }
.            { printf("UNKNOWN "); printf("Unknown character "); }

%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
