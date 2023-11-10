atlas-c: atlas-c.tab.c atlas-c.lex.c
	gcc -o atlas-c atlas-c.tab.c

atlas-c.tab.c: atlas-c.y atlas-c.lex.c
	yacc -o atlas-c.tab.c atlas-c.y

atlas-c.lex.c: atlas-c.l
	lex -o atlas-c.lex.c atlas-c.l

clean:
	rm -f atlas-c atlas-c.tab.c atlas-c.lex.c
