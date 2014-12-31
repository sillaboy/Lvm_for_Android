Lvm_for_Android
===============
BUILDING LVM2 FOR USE ON ANDROID

This is a lvm2-2_20_102 version built for android. First thanks in advance for steven676's 
instruction (Address at https://github.com/steven676/android-lvm-mod/blob/master/HOWTO-BUILD).

Here is my pc info:

1.Ubunto info
Distributor ID: Ubuntu
Description:    Ubuntu 12.04 LTS
Release:        12.04
Codename:       precise

2.arm gcc info
arm-linux-gcc-4.3.2

3.lvm version
lvm2-2_20_102

Set up cross compilation enviroment

The package contains the codes and build results and could be achieved in the following way:

1. Download arm gcc to your build enviroment, and decompress it at anyplace you'like.
   Here i use arm-linux-gcc-4.3.2 and uncompresses it to 
   /armlinux

2. Install standard c enviroment. 
   apt-get install build-essential libncurses5-dev
   
3. Add to PATH at the end of the file. 
   gedit  ~/.profile
   Content as follows:
      
   if [ "$BASH" ]; then
     if [ -f ~/.bashrc ]; then
       . ~/.bashrc
     fi
   fi

   mesg n

   TZ='Asia/Shanghai';
   export TZ;
   export PATH=$PATH:/armlinux/usr/local/arm/4.3.2/bin

4. Make it become effect
   source  ~/.profile

Build lvm

1. Download Lvm2 codes from the Home Page (https://git.fedorahosted.org/git/lvm2.git).
   I choose lvm2-2_20_102.
   
2. Then follow the instruction according to steven676's guide.
   Here i made a shell file named build.sh:
	export CC=arm-linux-gcc-4.3.2
	./configure --host=arm-linux-gnueabi  --prefix=/lvm --enable-static_link \
	--disable-readline --disable-selinux \
	--with-pool=none --with-cluster=none \
	--with-confdir=/lvm/etc --with-default-run-dir=/data/lvm/run \
	--with-default-system-dir=/lvm/etc  --with-default-locking-dir=/data/lvm/lock \
	--with-optimisation="-Os -march=armv5te -mtune=cortex-a8 -mthumb" \
	make 
   For more information can visit(https://github.com/steven676/android-lvm-mod/blob/master/HOWTO-BUILD).

Special Instructions:

To solve the build erro with rpl_malloc:
	../libdm/libdevmapper.so: undefined reference to `rpl_malloc'
	collect2: ld returned 1 exit status
	make[1]: *** [dmsetup] Error 1
I modified config.h.in file   
   #undef malloc  -> //#undef malloc 
   #undef realloc -> //#undef realloc
   
The resulting statically linked unstripped LVM binary will be located in
tools/lvm.static in the LVM source tree, and an example configuration
file is located in doc/example.conf.