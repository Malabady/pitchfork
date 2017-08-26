#!/bin/bash -e
case "$bamboo_repository_branch_name" in
  develop)
    publication="snapshots"
    archive_version="snapshot"
    ;;
  master)
    publication="releases"
    archive_version="release"
    exit 0
    ;;
  *)
    exit 0
    ;;
esac
NEXUS_BASEURL=http://nexus/repository
NEXUS_URL=$NEXUS_BASEURL/unsupported/pitchfork/gcc-4.9.2
for mywhl in $(find pitchfork/.git/pip -name *whl); do
  curl -v -n --upload-file $mywhl \
    $NEXUS_URL/pythonpkgs/$(basename $mywhl)
done
cd pitchfork/deployment
for mypkg in var/pkg/*; do
  grep -e 'pip uninstall' -e '^lib/python' $mypkg >& /dev/null \
    && continue \
    || true
  portname=`basename $mypkg`
  [[ $portname =~ htslib ]] && continue
  grep -v '^#' $mypkg | xargs file | grep -v -e 'directory$' \
  | awk -F : '{print $1}' | xargs tar zcf ${portname}.tgz
  curl -v -n --upload-file ${portname}.tgz \
    $NEXUS_URL/${portname}.tgz
done
portname=`basename var/pkg/Python-2*`
cat var/pkg/Python-2* | xargs tar zcf ${portname}.tgz
curl -v -n --upload-file ${portname}.tgz \
  $NEXUS_URL/${portname}.tgz
cd -
cd pitchfork
git archive --format=tar --prefix=pitchfork/ \
  --output=../pitchfork-${archive_version}.tar \
  develop
cd -
rm -f pitchfork-${archive_version}.tar.gz
gzip pitchfork-${archive_version}.tar
curl -v -n --upload-file \
  pitchfork-${archive_version}.tar.gz \
  $NEXUS_URL/pitchfork-${archive_version}.tar.gz
