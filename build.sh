#bin/bash
export CC=arm-linux-gcc-4.3.2
./configure --host=arm-linux-gnueabi  --prefix=/lvm --enable-static_link --disable-readline  --disable-selinux --with-pool=none --with-cluster=none --with-confdir=/lvm/etc --with-default-run-dir=/data/lvm/run --with-default-system-dir=/lvm/etc  --with-default-locking-dir=/data/lvm/lock --with-optimisation="-Os -march=armv5te -mtune=cortex-a8 -mthumb"
make
echo " use :/tools/lvm.static"
