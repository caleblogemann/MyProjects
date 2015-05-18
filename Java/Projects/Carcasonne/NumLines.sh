#!bin/bash
cd src;
find . -name '*.java' | xargs wc -l

#numLines=0;
#for entry in "src/*.java"
#do
    #echo $entry
#    numLines=$(($numLines+$(sed -n '$=' entry)));
#done
#echo $numLines;

