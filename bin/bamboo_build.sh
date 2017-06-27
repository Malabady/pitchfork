#!/bin/bash
type module >& /dev/null \
|| . /mnt/software/Modules/current/init/bash

module load gcc/4.9.2
module load graphviz/2.28.0
module load ccache/3.2.3

cd `dirname $0`/..

cat > settings.mk << EOF
DISTFILES  = ${PWD}/../.distfiles
CCACHE_DIR = /mnt/secondary/Share/tmp/bamboo.mobs.ccachedir
EOF

make -j third-party

# vim: ft=sh
