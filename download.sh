#!/bin/bash

set -e -x;

YEARS="\
1987\
 1988\
 1989\
 1990\
 1991\
 1992\
 1993\
 1994\
 1995\
 1996\
 1997\
 1998\
 1999\
 2000\
 2001\
 2002\
 2003\
 2004\
 2005\
 2006\
 2007\
 2008";

mkdir -p data/

for YEAR in $YEARS; do 
	(cd data && wget -c http://stat-computing.org/dataexpo/2009/$YEAR.csv.bz2)
done
