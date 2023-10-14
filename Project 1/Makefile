atlas-c: atlas-c.lex.c
        gcc -o atlas-c atlas-c.lex.c
atlas-c.lex.c: atlas-c.l
        lex -o atlas-c.lex.c atlas-c.l
clean:
        rm -f atlas-c atlas-c.lex.c
test1: atlas-c test1.atlas
        cat test1.atlas | ./atlas-c
test2: atlas-c test2.atlas
        cat test2.atlas | ./atlas-c
test3: atlas-c test3.atlas
        cat test3.atlas | ./atlas-c
