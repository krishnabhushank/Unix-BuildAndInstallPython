INSTALL_BASE_PATH="$HOME/opt"
cd ~
mkdir build
cd build
[ -f Python-3.9.11.tgz ] || wget https://www.python.org/ftp/python/3.9.11/Python-3.9.11.tgz
tar -zxvf Python-3.9.11.tgz

[ -f sqlite-autoconf-3240000.tar.gz ] || wget --no-check-certificate https://www.sqlite.org/2018/sqlite-autoconf-3240000.tar.gz
tar -zxvf sqlite-autoconf-3240000.tar.gz

cd sqlite-autoconf-3240000
./configure --prefix=${INSTALL_BASE_PATH}
make
make install

cd ../Python-3.9.11
LD_RUN_PATH=${INSTALL_BASE_PATH}/lib configure
LDFLAGS="-L ${INSTALL_BASE_PATH}/lib"
CPPFLAGS="-I ${INSTALL_BASE_PATH}/include"
LD_RUN_PATH=${INSTALL_BASE_PATH}/lib make
./configure --prefix=${INSTALL_BASE_PATH}
make
make install

cd ~
LINE_TO_ADD="export PATH=${INSTALL_BASE_PATH}/bin:\$PATH"
if grep -q -v "${LINE_TO_ADD}" $HOME/.bash_profile; then echo "${LINE_TO_ADD}" >> $HOME/.bash_profile; fi
source $HOME/.bash_profile
