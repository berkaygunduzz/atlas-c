atlas-c: atlas-c.yy.c
  gcc -o atlas-c atlas-c.yy.c
atlas-c.yy.c: atlas-c.l
  lex -o atlas-c.yy.c atlas-c.l
clean: atlas-c atlas-c.yy.c atlas-c.l
  rm -f atlas-c atlas-c.yy.c
test_1: atlas-c test1.atlas
  cat test1.atlas | ./atlas-c
test_2: atlas-c test2.atlas
  cat test2.atlas | ./atlas-c
test_3: atlas-c test3.atlas
  cat test3.atlas | ./atlas-c
