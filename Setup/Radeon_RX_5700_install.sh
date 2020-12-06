#/bin/bash
#MSI Radeon RX 5700 GX install
 git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
 sudo cp -va amdgpu/ /lib/firmware/
 update-initramfs -u
 mkdir /home/ewhtp4/Kernel
 cp linux-headers-5.3.11-050311_5.3.11-050311.201911121635_all.deb /home/ewhtp4/Kernel
 cp linux-image-unsigned-5.3.11-050311-generic_5.3.11-050311.201911121635_amd64.deb /home/ewhtp4/Kernel
 cp linux-modules-5.3.11-050311-lowlatency_5.3.11-050311.201911121635_amd64.deb /home/ewhtp4/Kernel
 cd /home/ewhtp4/Kernel
 dpkg -i linux-headers-5.3.11-050311_5.3.11-050311.201911121635_all.deb 
 #dpkg -i linux-image-unsigned-5.3.11-050311-generic_5.3.11-050311.201911121635_amd64.deb 
 dpkg -i linux-modules-5.3.11-050311-lowlatency_5.3.11-050311.201911121635_amd64.deb
 