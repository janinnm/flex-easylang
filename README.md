# flex-easylang
A simple lexical analyzer for the EASY language.

Enter the following commands to get the output of the input file given
```
flex easy.lex
gcc lex.yy.c -lfl
./a.out < hanoi.easy
```

The expected output is the following:

```
lineno: _ <Token, LEXEME>
lineno: _ <Token, LEXEME>
lineno: _ <Token, LEXEME>
... 
```

> Comments were not handled in this implementation