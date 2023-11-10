%%

"const"      {   return CONST; }
"var"        {   return VAR; }
"if"         {   return IF; }
"elif"       {   return ELIF; }
"else"       {   return ELSE; }
"while"      {   return WHILE; }
"in"         {   return IN; }
"out"        {   return OUT; }
"return"     {   return RETURN; }
"func"       {   return FUNCTION; }
[0-9]+       {   return INT; }
"=="         {   return EQ; }
"!="         {   return NEQ; }
"<"          {   return LT; }
"<="         {   return LTE; }
">"          {   return GT; }
">="         {   return GTE; }
"and"        {   return AND; }
"or"         {   return OR; }
"+"          {   return PLUS; }
"-"          {   return MINUS; }
"*"          {   return MULT; }
"/"          {   return DIV; }
"mod"        {   return MOD; }
"\^"         {   return POW; }
"("          {   return LPAR; }
")"          {   return RPAR; }
"{"          {   return LBRACE; }
"}"          {   return RBRACE; }
"\["         {   return LBRAKET; }
"\]"         {   return RBRAKET; }
"="          {   return ASGN; }
"=>"         {   return FASGN; }
";"          {   return SC; }
","          {   return COM; }
\"[^\"]*\"    { return STR; }
\/\*[^*]*\*\/ { /* ignore comments */ }
[a-zA-Z][a-zA-Z0-9_]* {   return ID; }
[ \t]        ;
\n           { yylineno++; }
.            { return UNKNOWN; }

%%
int yywrap() { return 1; }
