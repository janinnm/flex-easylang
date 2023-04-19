/* A simple lexical analyzer for the EASY language */
%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    int lineno = 1;
    void ret_print(char *token_type);
    void yyerror();
%}
DIGIT [0-9]
ID [a-zA-Z_][a-zA-Z0-9]*
%%

{DIGIT}+ { ret_print("INTEGER"); }
{DIGIT}+"."{DIGIT}* { ret_print("FLOAT"); }
true|false { ret_print("BOOLEAN"); }
not { ret_print("LOGICAL_NOT"); }
and { ret_print("LOGICAL_AND"); }
or { ret_print("LOGICAL_OR"); }
if|then|else|case|endcase|while|do|endwhile|repeat|until|loop|forever|for|endfor|to|by|input|output|array|node|call|return|stop|end|procedure {
ret_print("RESERVED");}
{ID} ret_print("IDENTIFIER");
"^" ret_print("EXPONENTIATION");
"/" ret_print("DIVISION");
"*" ret_print("MULTIPLICATION");
"+" ret_print("ADDITION");
"-" ret_print("SUBTRACTION");
"<"|"<="|">"|">=" ret_print("RELATIONAL");
"==" ret_print("EQUALITY");
\".*\" ret_print("STRING_LITERAL");
\'.*\' ret_print("STRING_LITERAL");
"!=" ret_print("INEQUALITY");
"=" ret_print("ASSIGNMENT");
"("|")" ret_print("PARENTHESES");
":" ret_print("COLON");
";" ret_print("SEMI_COLON");
"," ret_print("COMMA");
"{"[\^{}}\n]*"}"      /* handles one-line comments */   
"\n" { lineno++; }               
[ \t\r\f]+              /* handles whitespace */                  
. { yyerror("Unrecognized character"); }

%%

void ret_print(char *token_type) {
    printf("yytext: %s\ttoken: %s\tlineno: %d\n", yytext, token_type, lineno);
}

void yyerror(char *message) {
    printf("Error: \"%s\". Token = %s\n", message, yytext);
    exit(1);
}

int main( int argc, char *argv[] )
{
    yyin = fopen( argv[1], "r" );
    yylex();
    fclose(yyin);
    return 0;
}
