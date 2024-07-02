Open a terminal and navigate to the directory containing the file prob1.1.l.
Run the following commands to compile and execute the lexical analyzer:
flex prob1.1.l
gcc lex.yy.c -o lexer
./lexer < input.knp
Replace input.knp with the actual Kanpur source code file you want to analyze.
