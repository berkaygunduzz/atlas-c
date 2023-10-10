%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

%%
"const"      { printf("CONST\n"); return CONST; }
"var"        { printf("VAR\n"); return VAR; }
"if"         { printf("IF\n"); return IF; }
"else"       { printf("ELSE\n"); return ELSE; }
"while"      { printf("WHILE\n"); return WHILE; }
"in"         { printf("IN\n"); return IN; }
"out"        { printf("OUT\n"); return OUT; }
[0-9]+       { printf("INT(%s)\n", yytext); yylval.integer = atoi(yytext); return INT; }
"=="         { printf("EQ\n"); return EQ; }
"!="         { printf("NEQ\n"); return NEQ; }
"<"          { printf("LT\n"); return LT; }
">"          { printf("GT\n"); return GT; }
"and"        { printf("AND\n"); return AND; }
"or"         { printf("OR\n"); return OR; }
"+"          { printf("PLUS\n"); return PLUS; }
"-"          { printf("MINUS\n"); return MINUS; }
"*"          { printf("MULTIPLY\n"); return MULTIPLY; }
"/"          { printf("DIVIDE\n"); return DIVIDE; }
"mod"        { printf("MOD\n"); return MOD; }
"\^"         { printf("POWER\n"); return POWER; }
"("          { printf("LPAREN\n"); return LPAREN; }
")"          { printf("RPAREN\n"); return RPAREN; }
"{"          { printf("LBRACE\n"); return LBRACE; }
"}"          { printf("RBRACE\n"); return RBRACE; }
"\["         { printf("LBRACKET\n"); return LBRACKET; }
"\]"         { printf("RBRACKET\n"); return RBRACKET; }
"="          { printf("ASSIGN\n"); return ASSIGN; }
";"          { printf("SEMICOLON\n"); return SEMICOLON; }
","          { printf("COMMA\n"); return COMMA; }
\"[^"]*\"    { printf("STRING(%s)\n", yytext); yylval.string = strdup(yytext); return STRING; }
\/\*[^*]*\*\/ { printf("COMMENT\n"); /* Ignore comments */ }
[a-zA-Z][a-zA-Z0-9_]* { printf("IDENTIFIER(%s)\n", yytext); yylval.identifier = strdup(yytext); return IDENTIFIER; }
[ \t\n]      ; // Ignore whitespace and tabs
.            { printf("UNKNOWN(%s)\n", yytext); yyerror("Unknown character"); }

%%

int yywrap() {
    return 1;
}
