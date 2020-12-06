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
