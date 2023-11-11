parser: atlas-c.tab.c atlas-c.lex.c
	gcc -o parser atlas-c.tab.c
	rm  -f atlas-c.tab.c atlas-c.lex.c

atlas-c.tab.c: atlas-c.y atlas-c.lex.c
	yacc -o atlas-c.tab.c atlas-c.y

atlas-c.lex.c: atlas-c.l
	lex -o atlas-c.lex.c atlas-c.l

clean:
	rm -f parser

test1: atlas-c test1.atlas.txt
	cat tests/test1.atlas.txt | ./atlas-c
test2: atlas-c test2.atlas.txt
	cat tests/test2.atlas.txt | ./atlas-c
test3: atlas-c test3.atlas.txt
	cat tests/test3.atlas.txt | ./atlas-c
test4: atlas-c test4.atlas.txt
	cat tests/test4.atlas.txt | ./atlas-c
test5: atlas-c test5.atlas.txt
	cat tests/test5.atlas.txt | ./atlas-c

test_error1: atlas-c test1.atlas.txt
	cat tests/test_error1.atlas.txt | ./atlas-c
test_error2: atlas-c test2.atlas.txt
	cat tests/test_error2.atlas.txt | ./atlas-c
test_error3: atlas-c test3.atlas.txt
	cat tests/test_error3.atlas.txt | ./atlas-c
test_error4: atlas-c test4.atlas.txt
	cat tests/test_error4.atlas.txt | ./atlas-c
test_error5: atlas-c test5.atlas.txt
	cat tests/test_error5.atlas.txt | ./atlas-c
