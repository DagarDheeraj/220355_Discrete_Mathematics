%{
#include <stdio.h>
#include <string.h>

int line_number = 1;
void print_token(const char* token_type, const char* lexeme, int count);
%}

%option noyywrap

%{
#define KEYWORD     "KEYWORD"
#define OPERATOR    "OPERATOR"
#define IDENTIFIER  "IDENTIFIER"
#define STRING      "STRING"
#define DELIMITER   "DELIMITER"
#define INTEGER     "INTEGER"
#define FLOATING_POINT "FLOATING_POINT"
#define HEXADECIMAL "HEXADECIMAL"
%}

%%
[\n]          { line_number++; }
[ \t\r\f]+    { /* Ignore whitespace */ }

"BEGIN"|"ELSE"|"END"|"IF"|"INTEGER"|"PRINT"|"THEN"     { print_token(KEYWORD, yytext, 1); }
"GT"                                              { print_token(OPERATOR, yytext, 1); }
"+"                                               { print_token(OPERATOR, yytext, 1); }
":="                                              { print_token(OPERATOR, yytext, 1); }

"(" | ")" | "," | ";"                             { print_token(DELIMITER, yytext, 1); }

[0-9]+                                            { print_token(INTEGER, yytext, 1); }
[0-9]+\.[0-9]{1,6}                                { print_token(FLOATING_POINT, yytext, 1); }
0[xX][0-9a-fA-F]+                                 { print_token(HEXADECIMAL, yytext, 1); }

[a-zA-Z][a-zA-Z0-9]*                              { print_token(IDENTIFIER, yytext, 1); }

\"([^\"\\]|\\.)*\"                                { print_token(STRING, yytext, 1); }
\'([^\'\\]|\\.)*\'                                { print_token(STRING, yytext, 1); }

\"([^\"\\]|\\.)*                                  { printf("Error: Ill-formed string at line %d\n", line_number); return 1; }
\'([^\'\\]|\\.)*                                  { printf("Error: Ill-formed string at line %d\n", line_number); return 1; }

.                                                 { printf("Error: Illegal character '%s' at line %d\n", yytext, line_number); return 1; }

%%

void print_token(const char* token_type, const char* lexeme, int count) {
    printf("%-12s %-7d %-s\n", token_type, count, lexeme);
}

int main(int argc, char** argv) {
    yylex();
    return 0;
}
