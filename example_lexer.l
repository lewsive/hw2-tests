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

"const"       { printf("%d\t%d\t\"%s\"\n", constsym, line_num, yytext); return CONST; }
"var"         { printf("%d\t%d\t\"%s\"\n", varsym, line_num, yytext); return VAR; }
"proc"        { printf("%d\t%d\t\"%s\"\n", procsym, line_num, yytext); return PROC; }
"call"        { printf("%d\t%d\t\"%s\"\n", callsym, line_num, yytext); return CALL; }
"begin"       { printf("%d\t%d\t\"%s\"\n", beginsym, line_num, yytext); return TK_BEGIN; }
"end"         { printf("%d\t%d\t\"%s\"\n", endsym, line_num, yytext); return END; }
"if"          { printf("%d\t%d\t\"%s\"\n", ifsym, line_num, yytext); return IF; }
"then"        { printf("%d\t%d\t\"%s\"\n", thensym, line_num, yytext); return THEN; }
"else"        { printf("%d\t%d\t\"%s\"\n", elsesym, line_num, yytext); return ELSE; }
"while"       { printf("%d\t%d\t\"%s\"\n", whilesym, line_num, yytext); return WHILE; }
"do"          { printf("%d\t%d\t\"%s\"\n", dosym, line_num, yytext); return DO; }
"read"        { printf("%d\t%d\t\"%s\"\n", readsym, line_num, yytext); return READ; }
"print"       { printf("%d\t%d\t\"%s\"\n", printsym, line_num, yytext); return PRINT; }
"divisible"   { printf("%d\t%d\t\"%s\"\n", divisiblesym, line_num, yytext); return DIVISIBLE; }
"by"          { printf("%d\t%d\t\"%s\"\n", bysym, line_num, yytext); return BY; }

"=="          { printf("%d\t%d\t\"%s\"\n", eqeqsym, line_num, yytext); return EQ; }
"!="          { printf("%d\t%d\t\"%s\"\n", neqsym, line_num, yytext); return NEQ; }
"<="          { printf("%d\t%d\t\"%s\"\n", leqsym, line_num, yytext); return LEQ; }
"<"           { printf("%d\t%d\t\"%s\"\n", ltsym, line_num, yytext); return LT; }
">="          { printf("%d\t%d\t\"%s\"\n", geqsym, line_num, yytext); return GEQ; }
">"           { printf("%d\t%d\t\"%s\"\n", gtsym, line_num, yytext); return GT; }

"+"           { printf("%d\t%d\t\"%s\"\n", plussym, line_num, yytext); return PLUS; }
"-"           { printf("%d\t%d\t\"%s\"\n", minussym, line_num, yytext); return MINUS; }
"*"           { printf("%d\t%d\t\"%s\"\n", multsym, line_num, yytext); return MULT; }
"/"           { printf("%d\t%d\t\"%s\"\n", divsym, line_num, yytext); return DIV; }

"."           { printf("%d\t%d\t\"%s\"\n", periodsym, line_num, yytext); return DOT; }
";"           { printf("%d\t%d\t\"%s\"\n", semisym, line_num, yytext); return SEMICOLON; }
"="           { printf("%d\t%d\t\"%s\"\n", eqsym, line_num, yytext); return ASSIGN; }
":="          { printf("%d\t%d\t\"%s\"\n", becomessym, line_num, yytext); return ASSIGNOP; }
","           { printf("%d\t%d\t\"%s\"\n", commasym, line_num, yytext); return COMMA; }
"("           { printf("%d\t%d\t\"%s\"\n", lparensym, line_num, yytext); return LPAREN; }
")"           { printf("%d\t%d\t\"%s\"\n", rparensym, line_num, yytext); return RPAREN; }

{IDENT}       { printf("%d\t%d\t\"%s\"\n", identsym, line_num, yytext); return IDENT; }
{NUMBER}      { printf("%d\t%d\t\"%s\"\n", numbersym, line_num, yytext); return NUMBER; }


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


