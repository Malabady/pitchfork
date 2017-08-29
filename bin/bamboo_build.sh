#!/bin/bash
type module >& /dev/null \
|| . /mnt/software/Modules/current/init/bash

# ~/.local is the default PYTHONUSERBASE,
# bad for automation
rm -rf $HOME/.local/lib/python2.7

# less effective defensive move
unset PYTHONUSERBASE

module load gcc/6.4.0
module load graphviz/2.28.0
module load ccache/3.3.4

cd `dirname $0`/..

if [[ $USER == "bamboo" ]]; then
  CCACHE_DIR=/mnt/secondary/Share/tmp/bamboo.mobs.ccachedir
  export CCACHE_TEMPDIR=/scratch/bamboo.ccache_tempdir
fi
export CCACHE_COMPILERCHECK='%compiler% -dumpversion'
cat > settings.mk << EOF
DISTFILES  = ${PWD}/../.distfiles
CCACHE_DIR = ${CCACHE_DIR}
EOF

make -j third-party

# vim: ft=sh
