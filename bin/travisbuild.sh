#!/usr/bin/env bash
export PATH=/usr/lib/jvm/java-8-oracle/jre/bin:$PATH
rm -rf $HOME/local.pip/wheel
mkdir -p $HOME/distfiles
rm -rf $HOME/distfiles/*
test -e $HOME/distfiles/hdf5-1.8.13-linux-x86_64-shared.tar.gz \
|| curl -s -L https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.13/bin/linux-x86_64/hdf5-1.8.13-linux-x86_64-shared.tar.gz \
        -o $HOME/distfiles/hdf5-1.8.13-linux-x86_64-shared.tar.gz
tar zxf $HOME/distfiles/hdf5-1.8.13-linux-x86_64-shared.tar.gz -C $HOME
cp mk/travis.mk settings.mk
make init
make python
#make reseq-core
#make pbfalcon
#make smrtflow
rm -rf $HOME/local.pip/wheel
