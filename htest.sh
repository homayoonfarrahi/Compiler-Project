#!/bin/bash

# Script for testing the grammar

set -e

export CLASSPATH=".:/usr/local/lib/antlr-4.0-complete.jar:$CLASSPATH"

antlr4='java -jar /usr/local/lib/antlr-4.0-complete.jar -o ./antlrOutput'
grun='java org.antlr.v4.runtime.misc.TestRig'

langName=$1
langFile="$1.g4"
startRule=$2
testCnt=$3
tempStr=""
if [ "$langName" == "$tempStr" ] || [ "$startRule" == "$tempStr" ] || [ "$testCnt" == "$tempStr" ]; then
	echo "Correct format:   ./htest.sh [langName] [startRuleName] [testCount]"
	exit 0
fi


echo "Generating Parser..."
$antlr4 $langFile

echo "Compiling java files..."
javac *.java
javac ./antlrOutput/*.java

Counter=0
while [ $Counter -lt $testCnt ]; do
	let tempCnt=Counter+1
	echo "Test No: $tempCnt"
	java Test

	cd ./antlrOutput
	$grun $langName $startRule <../input.mol >../out.par
	cd ../
	if diff -B out.par rules.par >/dev/null ; then
		echo "    OK"
	else
		echo "  Error :("
		echo
		exit 0
	fi

	echo
	let Counter=Counter+1
done
