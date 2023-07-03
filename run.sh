bison -d compound.y
flex -ocompound.yy.c compound.l
gcc compound.yy.c compound.tab.c -o compound
./compound
