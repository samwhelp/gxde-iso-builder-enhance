#!/bin/bash
function util_chroot_package_control () {
	if [[ $isUnAptss == 1 ]]; then
		util_chroot_run apt "$@"
	else
		util_chroot_run aptss "$@"
	fi
}
function util_chroot_run () {
	for i in {1..5};
	do
		sudo env DEBIAN_FRONTEND=noninteractive chroot $debianRootfsPath "$@"
		if [[ $? == 0 ]]; then
			break
		fi
		sleep 1
	done
}
function gxde_target_os_unmount () {
	sudo umount "$1/sys/firmware/efi/efivars"
	sudo umount "$1/sys"
	sudo umount "$1/dev/pts"
	sudo umount "$1/dev/shm"
	sudo umount "$1/dev"

	sudo umount "$1/sys/firmware/efi/efivars"
	sudo umount "$1/sys"
	sudo umount "$1/dev/pts"
	sudo umount "$1/dev/shm"
	sudo umount "$1/dev"

	sudo umount "$1/run"
	sudo umount "$1/media"
	sudo umount "$1/proc"
	sudo umount "$1/tmp"
}
programPath=$(cd $(dirname $0); pwd)
debianRootfsPath=debian-rootfs
if [[ $1 == "" ]]; then
	echo 请指定架构：i386 amd64 arm64 mips64el loong64
	echo 还可以再加一个参数：unstable 以构建内测镜像
	echo "如 $0  amd64  [unstable] [aptss(可选)] 顺序不能乱"
	exit 1
fi
if [[ -d $debianRootfsPath ]]; then
	gxde_target_os_unmount $debianRootfsPath
	sudo rm -rf $debianRootfsPath
fi
export isUnAptss=1
if [[ $1 == aptss ]] || [[ $2 == aptss ]]|| [[ $3 == aptss ]]; then
	export isUnAptss=0
fi
sudo rm -rf grub-deb
sudo apt install debootstrap debian-archive-keyring \
	debian-ports-archive-keyring qemu-user-static genisoimage \
	squashfs-tools -y
# 构建核心系统
set -e
if [[ $1 == loong64 ]]; then
	sudo debootstrap --no-check-gpg --keyring=/usr/share/keyrings/debian-ports-archive-keyring.gpg \
	--include=debian-ports-archive-keyring,debian-archive-keyring,live-task-recommended,live-task-standard,live-config-systemd,live-boot \
	--arch $1 unstable $debianRootfsPath https://mirror.sjtu.edu.cn/debian-ports/
else
	sudo debootstrap --arch $1 \
	--include=debian-ports-archive-keyring,debian-archive-keyring,live-task-recommended,live-task-standard,live-config-systemd,live-boot \
	bookworm $debianRootfsPath https://mirrors.sdu.edu.cn/debian/
fi
# 修改系统主机名
echo "gxde-os" | sudo tee $debianRootfsPath/etc/hostname
# 写入源
if [[ $1 == loong64 ]]; then
	sudo cp $programPath/debian-unreleased.list $debianRootfsPath/etc/apt/sources.list -v
else
	sudo cp $programPath/debian.list $debianRootfsPath/etc/apt/sources.list -v
	#sudo cp $programPath/debian-backports.list $debianRootfsPath/etc/apt/sources.list.d/debian-backports.list -v
	sudo cp $programPath/99bookworm-backports $debianRootfsPath/etc/apt/preferences.d/ -v
fi
sudo cp $programPath/os-release $debianRootfsPath/usr/lib/os-release
sudo sed -i "s/main/main contrib non-free non-free-firmware/g" $debianRootfsPath/etc/apt/sources.list
sudo cp $programPath/gxde-temp.list $debianRootfsPath/etc/apt/sources.list.d/temp.list -v
set +e
# 安装应用

sudo $programPath/pardus-chroot $debianRootfsPath
util_chroot_run apt install debian-ports-archive-keyring -y
util_chroot_run apt install debian-archive-keyring -y
util_chroot_run apt update -o Acquire::Check-Valid-Until=false
if [[ $2 == "unstable" ]]; then
	util_chroot_run apt install gxde-testing-source -y
	util_chroot_run apt update -o Acquire::Check-Valid-Until=false
fi
util_chroot_run apt install aptss -y
util_chroot_run aptss update -o Acquire::Check-Valid-Until=false

# 
util_chroot_package_control install gxde-desktop --install-recommends -y
if [[ $1 != "mips64el" ]]; then
	util_chroot_package_control install calamares-settings-gxde --install-recommends -y
else
	util_chroot_package_control install gxde-installer --install-recommends -y
fi

sudo rm -rf $debianRootfsPath/var/lib/dpkg/info/plymouth-theme-gxde-logo.postinst
util_chroot_package_control install live-task-recommended live-task-standard live-config-systemd \
	live-boot -y
util_chroot_package_control install fcitx5-pinyin libudisks2-qt5-0 fcitx5 -y
# 
if [[ $1 != "i386" ]]; then
	util_chroot_run apt install spark-store -y
else
	if [[ $1 == "mips64el" ]]; then
		util_chroot_run apt install loongsonapplication -y
	else
		util_chroot_run apt install aptss -y
	fi
fi

util_chroot_package_control update -o Acquire::Check-Valid-Until=false

util_chroot_package_control full-upgrade -y
if [[ $1 == loong64 ]]; then
	util_chroot_run aptss install cn.loongnix.lbrowser -y
elif [[ $1 == amd64 ]];then
	util_chroot_run aptss install firefox-spark -y
	util_chroot_run aptss install spark-deepin-cloud-print spark-deepin-cloud-scanner -y
	util_chroot_package_control install dummyapp-wps-office dummyapp-spark-deepin-wine-runner -y
elif [[ $1 == arm64 ]];then
	util_chroot_run aptss install firefox-spark -y
	util_chroot_package_control install dummyapp-wps-office dummyapp-spark-deepin-wine-runner -y
else 
	#util_chroot_package_control install chromium chromium-l10n -y
	util_chroot_package_control install firefox-esr firefox-esr-l10n-zh-cn -y
fi
#if [[ $1 == arm64 ]] || [[ $1 == loong64 ]]; then
#	util_chroot_package_control install spark-box64 -y
#fi
util_chroot_package_control install network-manager-gnome -y
#util_chroot_run apt install grub-efi-$1 -y
#if [[ $1 != amd64 ]]; then
#	util_chroot_run apt install grub-efi-$1 -y
#fi
# 卸载无用应用
util_chroot_package_control remove  mlterm mlterm-tiny deepin-terminal-gtk deepin-terminal ibus systemsettings deepin-wine8-stable  -y
# 安装内核
if [[ $1 != amd64 ]]; then
	util_chroot_package_control autopurge "linux-image-*" "linux-headers-*" -y
fi
util_chroot_package_control install linux-kernel-gxde-$1 -y
# 如果为 amd64/i386 则同时安装 oldstable 内核
if [[ $1 == amd64 ]] || [[ $1 == i386 ]] || [[ $1 == mips64el ]]; then
	util_chroot_package_control install linux-kernel-oldstable-gxde-$1 -y
fi
#util_chroot_package_control install linux-firmware -y
util_chroot_package_control install firmware-linux -y
util_chroot_package_control install firmware-iwlwifi firmware-realtek -y
util_chroot_package_control install grub-common -y
# 清空临时文件
util_chroot_package_control autopurge -y
util_chroot_package_control clean
# 下载所需的安装包
util_chroot_package_control install grub-pc --download-only -y
util_chroot_package_control install grub-efi-$1 --download-only -y
util_chroot_package_control install grub-efi --download-only -y
util_chroot_package_control install grub-common --download-only -y
util_chroot_package_control install cryptsetup-initramfs cryptsetup keyutils --download-only -y

mkdir grub-deb
sudo cp $debianRootfsPath/var/cache/apt/archives/*.deb grub-deb
# 清空临时文件
util_chroot_package_control clean
sudo touch $debianRootfsPath/etc/deepin/calamares
sudo rm $debianRootfsPath/etc/apt/sources.list.d/debian.list -rf
sudo rm $debianRootfsPath/etc/apt/sources.list.d/debian-backports.list -rf
sudo rm -rf $debianRootfsPath/var/log/*
sudo rm -rf $debianRootfsPath/root/.bash_history
sudo rm -rf $debianRootfsPath/etc/apt/sources.list.d/temp.list
sudo rm -rf $debianRootfsPath/initrd.img.old
sudo rm -rf $debianRootfsPath/vmlinuz.old
# 卸载文件
sleep 5
gxde_target_os_unmount $debianRootfsPath
# 封装
cd $debianRootfsPath
set -e
sudo rm -rf ../filesystem.squashfs
sudo mksquashfs * ../filesystem.squashfs
cd ..
#du -h filesystem.squashfs
# 构建 ISO
if [[ ! -f iso-template/$1-build.sh ]]; then
	echo 不存在 $1 架构的构建模板，不进行构建
	exit
fi
cd iso-template/$1
# 清空废弃文件
rm -rfv live/*
rm -rfv deb/*/
mkdir -p live
mkdir -p deb
# 添加 deb 包
cd deb
./addmore.py ../../../grub-deb/*.deb
cd ..
# 拷贝内核
# 获取内核数量
kernelNumber=$(ls -1 ../../$debianRootfsPath/boot/vmlinuz-* | wc -l)
vmlinuzList=($(ls -1 ../../$debianRootfsPath/boot/vmlinuz-* | sort -rV))
initrdList=($(ls -1 ../../$debianRootfsPath/boot/initrd.img-* | sort -rV))
for i in $( seq 0 $(expr $kernelNumber - 1) )
do
	if [[ $i == 0 ]]; then
		cp ../../$debianRootfsPath/boot/${vmlinuzList[i]} live/vmlinuz -v
		cp ../../$debianRootfsPath/boot/${initrdList[i]} live/initrd.img -v
	fi
	if [[ $i == 1 ]]; then
		cp ../../$debianRootfsPath/boot/${vmlinuzList[i]} live/vmlinuz-oldstable -v
		cp ../../$debianRootfsPath/boot/${initrdList[i]} live/initrd.img-oldstable -v
	fi
done
sudo mv ../../filesystem.squashfs live/filesystem.squashfs -v
cd ..
bash $1-build.sh
mv gxde.iso ..
cd ..
du -h gxde.iso
