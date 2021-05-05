#!/bin/bash
# script for internal debuging don't ask for doku.
#./installkernel.sh "-P2606 jenkins@192.168.178.49:~/Build_rpi_kernel_117_kernel.tar.gz"
scp $1 ./jenkins_bitstream.tar
#rsync -avze ssh -o StrictHostKeyChecking=no  $1 ./
tar xfv jenkins_bitstream.tar
cp hat_bs_out/rthat_top.bit /usr/share/InnoRoute/user_bitstream.bit
cp hat_bs_out/hat_env.sh 		/usr/share/InnoRoute/hat_env.sh
rm -r hat_bs_out
rm jenkins_bitstream.tar
/etc/init.d/INR_FPGA_load start

