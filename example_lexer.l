%{
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>  // For atoi and file functions
#include "tokens.h"
#include "spl.tab.h"

int line_num = 1;  // Line number counter
%}

%option noyywrap

DIGIT      [0-9]
LETTER     [a-zA-Z]
IDENT      {LETTER}({LETTER}|{DIGIT})*
NUMBER     {DIGIT}+

%%

"const"       { printf("%-7d%-5d\"%s\"\n", constsym, line_num, yytext); return CONST; }
"var"         { printf("%-7d%-5d\"%s\"\n", varsym, line_num, yytext); return VAR; }
"proc"        { printf("%-7d%-5d\"%s\"\n", procsym, line_num, yytext); return PROC; }
"call"        { printf("%-7d%-5d\"%s\"\n", callsym, line_num, yytext); return CALL; }
"begin"       { printf("%-7d%-5d\"%s\"\n", beginsym, line_num, yytext); return TK_BEGIN; }
"end"         { printf("%-7d%-5d\"%s\"\n", endsym, line_num, yytext); return END; }
"if"          { printf("%-7d%-5d\"%s\"\n", ifsym, line_num, yytext); return IF; }
"then"        { printf("%-7d%-5d\"%s\"\n", thensym, line_num, yytext); return THEN; }
"else"        { printf("%-7d%-5d\"%s\"\n", elsesym, line_num, yytext); return ELSE; }
"while"       { printf("%-7d%-5d\"%s\"\n", whilesym, line_num, yytext); return WHILE; }
"do"          { printf("%-7d%-5d\"%s\"\n", dosym, line_num, yytext); return DO; }
"read"        { printf("%-7d%-5d\"%s\"\n", readsym, line_num, yytext); return READ; }
"print"       { printf("%-7d%-5d\"%s\"\n", printsym, line_num, yytext); return PRINT; }
"divisible"   { printf("%-7d%-5d\"%s\"\n", divisiblesym, line_num, yytext); return DIVISIBLE; }
"by"          { printf("%-7d%-5d\"%s\"\n", bysym, line_num, yytext); return BY; }

"=="          { printf("%-7d%-5d\"%s\"\n", eqeqsym, line_num, yytext); return EQ; }
"!="          { printf("%-7d%-5d\"%s\"\n", neqsym, line_num, yytext); return NEQ; }
"<="          { printf("%-7d%-5d\"%s\"\n", leqsym, line_num, yytext); return LEQ; }
"<"           { printf("%-7d%-5d\"%s\"\n", ltsym, line_num, yytext); return LT; }
">="          { printf("%-7d%-5d\"%s\"\n", geqsym, line_num, yytext); return GEQ; }
">"           { printf("%-7d%-5d\"%s\"\n", gtsym, line_num, yytext); return GT; }

"+"           { printf("%-7d%-5d\"%s\"\n", plussym, line_num, yytext); return PLUS; }
"-"           { printf("%-7d%-5d\"%s\"\n", minussym, line_num, yytext); return MINUS; }
"*"           { printf("%-7d%-5d\"%s\"\n", multsym, line_num, yytext); return MULT; }
"/"           { printf("%-7d%-5d\"%s\"\n", divsym, line_num, yytext); return DIV; }

"."           { printf("%-7d%-5d\"%s\"\n", periodsym, line_num, yytext); return DOT; }
";"           { printf("%-7d%-5d\"%s\"\n", semisym, line_num, yytext); return SEMICOLON; }
"="           { printf("%-7d%-5d\"%s\"\n", eqsym, line_num, yytext); return ASSIGN; }
":="          { printf("%-7d%-5d\"%s\"\n", becomessym, line_num, yytext); return ASSIGNOP; }
","           { printf("%-7d%-5d\"%s\"\n", commasym, line_num, yytext); return COMMA; }
"("           { printf("%-7d%-5d\"%s\"\n", lparensym, line_num, yytext); return LPAREN; }
")"           { printf("%-7d%-5d\"%s\"\n", rparensym, line_num, yytext); return RPAREN; }

{IDENT}       { printf("%-7d%-5d\"%s\"\n", identsym, line_num, yytext); return IDENT; }
{NUMBER}      { printf("%-7d%-5d\"%s\"\n", numbersym, line_num, yytext); return NUMBER; }


[ \t\r]       { /* Ignore whitespace */ }
\n            { line_num++; }  // Increment line number on newline
"%"[^\n]*     { /* Ignore comments */ }

.             { printf("Unknown character: %s\n", yytext); }

%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    printf("Tokens from file %s\nNumber Line  Text\n", argv[1]);

    // Set Flex to read from the file
    yyin = file;

    // Tokenize the input
    int token;
    while((token = yylex())) {
        // Tokens and corresponding text are printed in the lexer rules above
    }

    fclose(file);
    return 0;
}
