#/bin/bash
echo
echo " +---------------------------------------------------+"
echo " |               Setting up Dependencies              |"
echo " +---------------------------------------------------+"
echo
echo
echo " +---------------------------------------------------+"
echo " |                Installing Python 3                |"
echo " +---------------------------------------------------+"
echo
wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tar.xz
cd ${CWD}/Python-3.7.2
./configure
make
make test
sudo make install
cd ..
echo
echo " +---------------------------------------------------+"
echo " |               Installing jansson lib              |"
echo " +---------------------------------------------------+"
echo
wget http://digip.org/jansson/releases/jansson-2.13.tar.gz    
gunzip -c jansson-2.13.tar.gz | tar xf -
cd ${CWD}/jansson-2.13
./configure
make
make install
cd ..
# http://search.cpan.org/dist/Parse-Yapp
echo
echo " +---------------------------------------------------+"
echo " |               Installing Perl Yapp                |"
echo " +---------------------------------------------------+"
echo
PACKAGER_ID=${PACKAGER_ID:-$USER}
PACKAGER=${PACKAGER:-$USER@$HOSTNAME}

# Set to YES to replicate slackbuild and patches
SB_REP=${SB_REP:-YES}

CWD=$(pwd)
TMP=${TMP:-/tmp}
if [ ! -d ${TMP} ]; then
  mkdir -p ${TMP}
fi

PNAME=Parse-Yapp
NAME=perl-parse-yapp
PKG=${PKG:-${TMP}/package-${NAME}}

VERSION=${VERSION:-1.05}
ARCH=noarch
SLKTARGET=${SLKTARGET:-x86_64}
BUILD=${BUILD:-1}
NJOBS=${NJOBS:-$(( $(getconf _NPROCESSORS_ONLN) + 1 ))}
DOCDIR=${PKG}/usr/doc/${NAME}-${VERSION}
SBDIR=${PKG}/usr/src/slackbuilds/perl-modules/${NAME}
PKGDEST=${PKGDEST:-${CWD}}
PKGFORMAT=${PKGFORMAT:-tgz}
PKGNAME=${NAME}-$(echo ${VERSION} | tr - . )-${ARCH}-${BUILD}${PACKAGER_ID}

PERLVENDORARCH=$(eval "$(perl -V:vendorarch)"; echo ${vendorarch})
PERLVENDORLIB=$(eval "$(perl -V:vendorlib)"; echo ${vendorlib})
PERLARCHLIB=$(eval "$(perl -V:archlib)"; echo ${archlib})
PERLVER=$(eval "$(perl -V:version)"; echo ${version})

DATE=$(LC_ALL=C date +%d-%b-%Y)

SRCDIR=${PNAME}-${VERSION}
SRCARCHIVE=${SRCDIR}.tar.gz

DL_PROG=${DL_PROG:-wget}
DL_TO=${DL_TO:-5}
DL_OPTS=${DL_OPTS:-"--timeout=${DL_TO}"}
DL_URL="http://www.cpan.org/modules/by-module/Parse/${SRCARCHIVE}"

# if source is not present, download in source rootdir if possible
test -r ${CWD}/${SRCARCHIVE} || ${DL_PROG} ${DL_OPTS} ${DL_URL} || exit 1

if [ -d ${PKG} ]; then
  # Clean up a previous build
  rm -rf ${PKG}
fi
mkdir -p ${PKG}

cd ${TMP}
rm -rf ${SRCDIR}
tar -xvf ${CWD}/${SRCARCHIVE} || exit 1
cd ${SRCDIR} || exit 1

chmod -R u+w,go+r-w,a-s .

chmod 644 lib/Parse/{*.pm,Yapp/*.pm}

if [ -r ${CWD}/apply-patches.sh ]; then
  . ${CWD}/apply-patches.sh
fi

perl Makefile.PL INSTALLDIRS="vendor" || exit $?

make -j${NJOBS} || make || exit $?
make pure_install PERL_INSTALL_ROOT=${PKG} || exit $?

find ${PKG} -type f \( -name perllocal.pod -o -name .packlist \) -exec rm -f {} \;
find ${PKG} -type f -name '*.bs' -a -size 0 -exec rm -f {} ';'
find ${PKG} -type d -depth -exec rmdir {} 2>/dev/null ';'
chmod -R u+w ${PKG}/*

# Add a documentation directory:
mkdir -p ${DOCDIR}
cp -a \
  README ${CWD}/ChangeLog.SB \
  ${DOCDIR}/
[ -r Changes ] && head -n 1000 Changes > ${DOCDIR}/Changes
find ${DOCDIR}/ -type d -print0 | xargs -0 chmod 0755
find ${DOCDIR}/ -type f -print0 | xargs -0 chmod 0644
find ${DOCDIR}/ -type f -size 0 -print0 | xargs -0 rm -f

# Compress and link manpages, if any:
if [ -d ${PKG}/usr/share/man ]; then
  mv ${PKG}/usr/share/man ${PKG}/usr/man
  rmdir ${PKG}/usr/share
fi
if [ -d ${PKG}/usr/man ]; then
  ( cd ${PKG}/usr/man
    for manpagedir in $(find . -type d -name "man*") ; do
      ( cd ${manpagedir}
        for eachpage in $( find . -type l -maxdepth 1) ; do
          ln -s $( readlink ${eachpage} ).gz ${eachpage}.gz
          rm -f ${eachpage}
        done
        gzip -9 *.?
        # Prevent errors
        rm -f *.gz.gz
      )
    done
  )
fi

mkdir -p ${PKG}/install
cat ${CWD}/slack-desc > ${PKG}/install/slack-desc
cat ${CWD}/slack-required > ${PKG}/install/slack-required

sed -i "s|_PACKAGER|${PACKAGER}|g; s|_BUILD_DATE|${DATE}|g" \
  ${PKG}/install/slack-desc

if [ "${SB_REP}" = "YES" ] ;then
  # Replicate slackbuild and patches
  mkdir -p ${SBDIR}/patches
  install -pm0644 ${CWD}/slack-desc ${CWD}/slack-required ${CWD}/ChangeLog.SB \
    ${CWD}/apply-patches.sh ${SBDIR}/
  install -pm0755 ${CWD}/${NAME}.SlackBuild \
    ${SBDIR}/${NAME}.SlackBuild
  install -pm0644 ${CWD}/patches/*.* \
    ${SBDIR}/patches/
  rmdir ${SBDIR}/patches
fi

# Build package:
set +o xtrace        # no longer print commands upon execution
set -e

ROOTCOMMANDS="set -o errexit -o xtrace ; cd ${PKG} ;
  /bin/chown --recursive root:root .  ;"

ROOTCOMMANDS="${ROOTCOMMANDS}
  /sbin/makepkg --linkadd y --chown n ${PKGDEST}/${PKGNAME}.${PKGFORMAT} "

if test ${UID} = 0; then
  eval ${ROOTCOMMANDS}
  set +o xtrace
elif test "$(type -t fakeroot)" = 'file'; then
  echo -e "\e[1mEntering fakeroot environment.\e[0m"
  echo ${ROOTCOMMANDS} | fakeroot
else
  echo -e "\e[1mPlease enter your root password.\e[0m (Consider installing fakeroot.)"
  /bin/su -c "${ROOTCOMMANDS}"
fi

# Clean up the extra stuff:
if [ "$1" = "--cleanup" ]; then
  echo "Cleaning..."
  if [ -d ${TMP}/${SRCDIR} ]; then
    rm -rf ${TMP}/${SRCDIR} && echo "${TMP}/${SRCDIR} cleanup completed"
  fi
  if [ -d ${PKG} ]; then
    rm -rf ${PKG} && echo "${PKG} cleanup completed"
  fi
  rmdir ${TMP} && echo "${TMP} cleanup completed"
fi
exit 0
cd ${CWD}/Parse-Yapp-1.05
perl Makefile.PL
make
make test
make install
cd ..
set -e -o pipefail
SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix POD, CPAN RT #54410
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.05-pod-errors.patch
# Fix POD, CPAN RT #54410
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.05-spelling.patch
# Fix POD, CPAN RT #11659
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.05-pod_item.patch

set +e +o pipefail
cd..
echo
echo " +---------------------------------------------------+"
echo " |               Installing Samba                    |"
echo " +---------------------------------------------------+"
echo
wget https://www.samba.org/samba/ftp/samba-latest.tar.gz
cd ${CWD}/samba-4.12.3
./configure --without-pam
make 
make test
make install
