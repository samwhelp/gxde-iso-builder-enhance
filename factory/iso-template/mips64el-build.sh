#!/bin/bash
#genisoimage -V GXDE -o gxde.iso ISO-temp/
#genisoimage -r -loliet-long -V GXDE -o gxde.iso -b boot/isolinux.bin -c boot/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -v -cache-inodes -T -eltorito-alt-boot -b boot/efiboot.img -no-emul-boot ISO-temp/
genisoimage -b boot/efiboot.img -no-emul-boot -R -J -T -c boot/boot.cat -b boot/isolinux.bin -hide boot.cat -V "GXDE" -o gxde.iso mips64el/
