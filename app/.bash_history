pwd
mkdir build
git clone https://github.com/abraunegg/onedrive.git ./build/onedrive
cd build/onedrive/
source ~/dlang/dmd-2.100.0/activate
curl -fsS https://dlang.org/install.sh | bash -s dmd
source ~/dlang/dmd-2.100.0/activate
./configure --help
mkdir ~/build/tmp
./configure --enable-notifications ~/build/tmp
make clean
make
make install
ls -lah ~/build/tmp/
./configure --enable-notifications --prefix=/root/build/tmp
make clean; make
make install
ls -lah ~/build/tmp/
ls -lah ~/build/tmp/share/
ls -lah ~/build/tmp/bin/
