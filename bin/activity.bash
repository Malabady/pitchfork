#!/bin/bash
ncount=0
while read LINE; do
    test $ncount = 0 && echo -ne "\r\\" && ncount=1 && continue || true
    test $ncount = 1 && echo -ne "\r|"  && ncount=2 && continue || true
    test $ncount = 2 && echo -ne "\r/"  && ncount=3 && continue || true
    test $ncount = 3 && echo -ne "\r-"  && ncount=0 && continue || true
done
echo
