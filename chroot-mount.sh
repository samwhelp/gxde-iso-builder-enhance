#!/usr/bin/env bash




##
## # Chroot Mount
##


DEFAULT_TARGET_OS_ROOT_DIR_PATH="/opt/tmp/gxde/work/rootfs"
REF_TARGET_OS_ROOT_DIR_PATH="${1}"

if [[ -z "${REF_TARGET_OS_ROOT_DIR_PATH}" ]]; then
	REF_TARGET_OS_ROOT_DIR_PATH="${DEFAULT_TARGET_OS_ROOT_DIR_PATH}"
fi


gxde_target_os_mount_for_chroot () {

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	core_target_os_mount_for_chroot "${rootfs}"

}

core_target_os_mount_for_chroot () {

	local rootfs="${1}"

	sudo mount --bind /dev "${rootfs}/dev"
	sudo mount --bind /run  "${rootfs}/run"
	#mount --bind /media  "${rootfs}/media"
	sudo mount -t devpts devpts "${rootfs}/dev/pts"
	sudo mount -t sysfs sysfs "${rootfs}/sys"
	sudo mount -t proc proc "${rootfs}/proc"
	sudo mount -t tmpfs tmpfs  "${rootfs}/dev/shm"
	sudo mount --bind /tmp "${rootfs}/tmp"

	return 0
}

gxde_target_os_mount_for_chroot
