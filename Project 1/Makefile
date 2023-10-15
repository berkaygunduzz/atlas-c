atlas-c: atlas-c.lex.c
	gcc -o atlas-c atlas-c.lex.c
atlas-c.lex.c: atlas-c.l
	lex -o atlas-c.lex.c atlas-c.l
clean:
	rm -f atlas-c atlas-c.lex.c
test1: atlas-c test1.atlas.txt
	cat test1.atlas.txt | ./atlas-c
test2: atlas-c test2.atlas.txt
	cat test2.atlas.txt | ./atlas-c
test3: atlas-c test3.atlas.txt
	cat test3.atlas.txt | ./atlas-c
test4: atlas-c test4.atlas.txt
	cat test4.atlas.txt | ./atlas-c
test5: atlas-c test5.atlas.txt
	cat test5.atlas.txt | ./atlas-c
