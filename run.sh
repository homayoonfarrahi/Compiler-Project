#!/bin/bash

# Script for testing the grammar

set -e
export CLASSPATH=".:/usr/local/lib/antlr-4.1-complete.jar:$CLASSPATH"

antlr4='java -jar /usr/local/lib/antlr-4.1-complete.jar -o ./antlrOutput'
grun='java org.antlr.v4.runtime.misc.TestRig'

cd antlrOutput
$grun mol program <../SampleTests/$1.mol >../SampleTests/$1.out -gui
diff ../SampleTests/$1.par ../SampleTests/$1.out
