#!/bin/sh
cat $1 | awk -f `dirname $0`/org2plain.awk
