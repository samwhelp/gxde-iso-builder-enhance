#!/usr/bin/env bash




##
## # Build GXDE ISO / Steps
##


##
## ## Main / Init
##

REF_BASE_DIR_PATH="$(cd -- "$(dirname -- "$0")" ; pwd)"
REF_CMD_FILE_NAME="$(basename "$0")"


DEFAULT_IS_DEBUG="false"
IS_DEBUG="${IS_DEBUG:=$DEFAULT_IS_DEBUG}"


##
## ## Main / Util
##

util_error_echo () {
	echo "${@}" 1>&2
}

util_debug_echo () {

	if is_debug; then
		echo "${@}" 1>&2
	fi

}

is_debug () {

	if [[ "${IS_DEBUG}" == "true" ]]; then
		return 0
	fi

	return 1

}

is_not_debug () {

	! is_debug

}


##
## ## Main / Variable
##

main_var_init () {

	##
	## ## Plan / Path
	##

	REF_MAIN_SUBJECT_NAME="gxde"
	REF_PLAN_DIR_PATH="${REF_BASE_DIR_PATH}"



	REF_PLAN_ASSET_DIR_NAME="asset"
	REF_PLAN_ASSET_DIR_PATH="${REF_PLAN_DIR_PATH}/${REF_PLAN_ASSET_DIR_NAME}"


	REF_PLAN_FACTORY_DIR_NAME="factory"
	REF_PLAN_FACTORY_DIR_PATH="${REF_PLAN_DIR_PATH}/${REF_PLAN_FACTORY_DIR_NAME}"


	REF_PLAN_TMP_DIR_NAME="tmp"
	REF_PLAN_TMP_DIR_PATH="${REF_PLAN_DIR_PATH}/${REF_PLAN_TMP_DIR_NAME}"

	#REF_PLAN_TMP_DIR_PATH="${HOME}/${REF_PLAN_TMP_DIR_NAME}/${REF_MAIN_SUBJECT_NAME}"
	REF_PLAN_TMP_DIR_PATH="/opt/${REF_PLAN_TMP_DIR_NAME}/${REF_MAIN_SUBJECT_NAME}"


	REF_PLAN_WORK_DIR_NAME="work"
	REF_PLAN_WORK_DIR_PATH="${REF_PLAN_TMP_DIR_PATH}/${REF_PLAN_WORK_DIR_NAME}"

	REF_PLAN_OUT_DIR_NAME="out"
	REF_PLAN_OUT_DIR_PATH="${REF_PLAN_TMP_DIR_PATH}/${REF_PLAN_OUT_DIR_NAME}"


	return 0
}

main_var_dump () {

	is_not_debug && return 0


	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Tips"
	util_debug_echo "##"
	util_debug_echo
	util_debug_echo "> Hide Dump Info"
	util_debug_echo
	util_debug_echo "\$ export IS_DEBUG=false"
	util_debug_echo


	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Dump / main_var_dump"
	util_debug_echo "##"

	util_debug_echo
	util_debug_echo "REF_BASE_DIR_PATH=${REF_BASE_DIR_PATH}"
	util_debug_echo "REF_CMD_FILE_NAME=${REF_CMD_FILE_NAME}"

	util_debug_echo
	util_debug_echo "DEFAULT_IS_DEBUG=${DEFAULT_IS_DEBUG}"
	util_debug_echo "IS_DEBUG=${IS_DEBUG}"




	util_debug_echo
	util_debug_echo "REF_MAIN_SUBJECT_NAME=${REF_MAIN_SUBJECT_NAME}"
	util_debug_echo "REF_PLAN_DIR_PATH=${REF_PLAN_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_ASSET_DIR_NAME=${REF_PLAN_ASSET_DIR_NAME}"
	util_debug_echo "REF_PLAN_ASSET_DIR_PATH=${REF_PLAN_ASSET_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_FACTORY_DIR_NAME=${REF_PLAN_FACTORY_DIR_NAME}"
	util_debug_echo "REF_PLAN_FACTORY_DIR_PATH=${REF_PLAN_FACTORY_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_TMP_DIR_NAME=${REF_PLAN_TMP_DIR_NAME}"
	util_debug_echo "REF_PLAN_TMP_DIR_PATH=${REF_PLAN_TMP_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_WORK_DIR_NAME=${REF_PLAN_WORK_DIR_NAME}"
	util_debug_echo "REF_PLAN_WORK_DIR_PATH=${REF_PLAN_WORK_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PLAN_OUT_DIR_NAME=${REF_PLAN_OUT_DIR_NAME}"
	util_debug_echo "REF_PLAN_OUT_DIR_PATH=${REF_PLAN_OUT_DIR_PATH}"




	return 0
}

main_var_init

main_var_dump


##
## ## Master / Variable
##

master_var_init () {


	##
	## ## Master / Args
	##

	DEFAULT_BUILD_ARCH="amd64"
	REF_BUILD_ARCH="${REF_BUILD_ARCH:=$DEFAULT_BUILD_ARCH}"
	REF_BUILD_ARCH_OPTION_LIST="amd64 arm64 mips64el loong64 i386"


	DEFAULT_IS_USE_APTSS="false"
	REF_IS_USE_APTSS="${REF_IS_USE_APTSS:=$DEFAULT_IS_USE_APTSS}"


	##
	## ## Master / Opts
	##

	DEFAULT_MAIN_RUN="steps"
	REF_MAIN_RUN="${REF_MAIN_RUN:=$DEFAULT_MAIN_RUN}"

	DEFAULT_BUILD_LOCALE="en_us"
	REF_BUILD_LOCALE="${REF_BUILD_LOCALE:=$DEFAULT_BUILD_LOCALE}"
	REF_BUILD_LOCALE_OPTION_LIST="en_us zh_tw zh_cn zh_hk ja_jp ko_kr"


	##
	## ## Target OS / Path
	##

	REF_TARGET_OS_ROOT_DIR_NAME="rootfs"
	REF_TARGET_OS_ROOT_DIR_PATH="${REF_PLAN_WORK_DIR_PATH}/${REF_TARGET_OS_ROOT_DIR_NAME}"


	REF_TARGET_OS_ARCHIVE_FILE_NAME="filesystem.squashfs"
	REF_TARGET_OS_ARCHIVE_FILE_PATH="${REF_PLAN_WORK_DIR_PATH}/${REF_TARGET_OS_ARCHIVE_FILE_NAME}"


	##
	## ## Target OS / debootstrap args
	##

	#DEFAULT_BUILD_ARCH="amd64"
	#REF_BUILD_ARCH="${REF_BUILD_ARCH:=$DEFAULT_BUILD_ARCH}"

	DEFAULT_BUILD_SUITE="bookworm"
	REF_BUILD_SUITE="${REF_BUILD_SUITE:=$DEFAULT_BUILD_SUITE}"

	DEFAULT_PACKAGE_REPO_URL="https://mirrors.tuna.tsinghua.edu.cn/debian/"
	REF_PACKAGE_REPO_URL="${REF_PACKAGE_REPO_URL:=$DEFAULT_PACKAGE_REPO_URL}"

	DEFAULT_BUILD_INCLUDE="debian-ports-archive-keyring,debian-archive-keyring,live-task-recommended,live-task-standard,live-config-systemd,live-boot"
	REF_BUILD_INCLUDE="${REF_BUILD_INCLUDE:=$DEFAULT_BUILD_INCLUDE}"


	## for --arch=loong64
	DEFAULT_BUILD_KEYRING_FOR_LOONG64="/usr/share/keyrings/debian-ports-archive-keyring.gpg"
	REF_BUILD_KEYRING_FOR_LOONG64="${REF_BUILD_KEYRING_FOR_LOONG64:=$DEFAULT_BUILD_KEYRING_FOR_LOONG64}"

	DEFAULT_PACKAGE_REPO_URL_FOR_LOONG64="https://mirror.sjtu.edu.cn/debian-ports/"
	REF_PACKAGE_REPO_URL_FOR_LOONG64="${REF_PACKAGE_REPO_URL_FOR_LOONG64:=$DEFAULT_PACKAGE_REPO_URL_FOR_LOONG64}"


	##
	## ## Overlay / Path
	##

	REF_OVERLAY_DIR_NAME="overlay"
	REF_OVERLAY_DIR_PATH="${REF_PLAN_ASSET_DIR_PATH}/${REF_OVERLAY_DIR_NAME}"

	REF_FACTORY_OVERLAY_DIR_NAME="${REF_OVERLAY_DIR_NAME}"
	REF_FACTORY_OVERLAY_DIR_PATH="${REF_PLAN_FACTORY_DIR_PATH}/${REF_FACTORY_OVERLAY_DIR_NAME}"


	##
	## ## Package List / Path
	##

	REF_PACKAGE_LIST_DIR_NAME="package"
	REF_PACKAGE_LIST_DIR_PATH="${REF_PLAN_ASSET_DIR_PATH}/${REF_PACKAGE_LIST_DIR_NAME}"


	REF_PACKAGE_INSTALL_DIR_NAME="install"
	REF_PACKAGE_INSTALL_DIR_PATH="${REF_PACKAGE_LIST_DIR_PATH}/${REF_PACKAGE_INSTALL_DIR_NAME}"


	REF_PACKAGE_REMOVE_DIR_NAME="remove"
	REF_PACKAGE_REMOVE_DIR_PATH="${REF_PACKAGE_LIST_DIR_PATH}/${REF_PACKAGE_REMOVE_DIR_NAME}"


	##
	## ## Hook / Path
	##

	REF_HOOK_DIR_NAME="hook"
	REF_HOOK_DIR_PATH="${REF_PLAN_FACTORY_DIR_PATH}/${REF_HOOK_DIR_NAME}"


	##
	## ## ISO Template / Path
	##

	REF_ISO_TEMPLATE_SOURCE_DIR_NAME="iso-template"
	REF_ISO_TEMPLATE_SOURCE_DIR_PATH="${REF_PLAN_FACTORY_DIR_PATH}/${REF_ISO_TEMPLATE_SOURCE_DIR_NAME}"


	REF_ISO_TEMPLATE_TARGET_DIR_NAME="${REF_ISO_TEMPLATE_SOURCE_DIR_NAME}"
	REF_ISO_TEMPLATE_TARGET_DIR_PATH="${REF_PLAN_WORK_DIR_PATH}/${REF_ISO_TEMPLATE_TARGET_DIR_NAME}"


	##
	## ## Live Deb / Path
	##

	REF_LIVE_DEB_MIDDLE_DIR_NAME="live-deb"
	REF_LIVE_DEB_MIDDLE_DIR_PATH="${REF_PLAN_WORK_DIR_PATH}/${REF_LIVE_DEB_MIDDLE_DIR_NAME}"


	REF_LIVE_DEB_SOURCE_DIR_NAME="archives"
	REF_LIVE_DEB_SOURCE_DIR_PATH="${REF_TARGET_OS_ROOT_DIR_PATH}/var/cache/apt/${REF_LIVE_DEB_SOURCE_DIR_NAME}"


	return 0
}

master_var_dump () {

	is_not_debug && return 0


	util_debug_echo

	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Dump / master_var_dump"
	util_debug_echo "##"




	##
	## ## Master / Args
	##

	util_debug_echo
	util_debug_echo "DEFAULT_BUILD_ARCH=${DEFAULT_BUILD_ARCH}"
	util_debug_echo "REF_BUILD_ARCH=${REF_BUILD_ARCH}"
	util_debug_echo "REF_BUILD_ARCH_OPTION_LIST=${REF_BUILD_ARCH_OPTION_LIST}"

	util_debug_echo
	util_debug_echo "DEFAULT_IS_USE_APTSS=${DEFAULT_IS_USE_APTSS}"
	util_debug_echo "REF_IS_USE_APTSS=${REF_IS_USE_APTSS}"


	##
	## ## Master / Opts
	##

	util_debug_echo
	util_debug_echo "DEFAULT_MAIN_RUN=${DEFAULT_MAIN_RUN}"
	util_debug_echo "REF_MAIN_RUN=${REF_MAIN_RUN}"

	util_debug_echo
	util_debug_echo "DEFAULT_BUILD_LOCALE=${DEFAULT_BUILD_LOCALE}"
	util_debug_echo "REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"
	util_debug_echo "REF_BUILD_LOCALE_OPTION_LIST=${REF_BUILD_LOCALE_OPTION_LIST}"


	##
	## ## Target OS / Path
	##

	util_debug_echo
	util_debug_echo "REF_TARGET_OS_ROOT_DIR_NAME=${REF_TARGET_OS_ROOT_DIR_NAME}"
	util_debug_echo "REF_TARGET_OS_ROOT_DIR_PATH=${REF_TARGET_OS_ROOT_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_TARGET_OS_ARCHIVE_FILE_NAME=${REF_TARGET_OS_ARCHIVE_FILE_NAME}"
	util_debug_echo "REF_TARGET_OS_ARCHIVE_FILE_PATH=${REF_TARGET_OS_ARCHIVE_FILE_PATH}"


	##
	## ## Target OS / debootstrap args
	##

	util_debug_echo
	util_debug_echo "DEFAULT_BUILD_SUITE=${DEFAULT_BUILD_SUITE}"
	util_debug_echo "REF_BUILD_SUITE=${REF_BUILD_SUITE}"

	util_debug_echo
	util_debug_echo "DEFAULT_PACKAGE_REPO_URL=${DEFAULT_PACKAGE_REPO_URL}"
	util_debug_echo "REF_PACKAGE_REPO_URL=${REF_PACKAGE_REPO_URL}"

	util_debug_echo
	util_debug_echo "DEFAULT_BUILD_INCLUDE=${DEFAULT_BUILD_INCLUDE}"
	util_debug_echo "REF_BUILD_INCLUDE=${REF_BUILD_INCLUDE}"

	util_debug_echo
	util_debug_echo "DEFAULT_BUILD_KEYRING_FOR_LOONG64=${DEFAULT_BUILD_KEYRING_FOR_LOONG64}"
	util_debug_echo "REF_BUILD_KEYRING_FOR_LOONG64=${REF_BUILD_KEYRING_FOR_LOONG64}"

	util_debug_echo
	util_debug_echo "DEFAULT_PACKAGE_REPO_URL_FOR_LOONG64=${DEFAULT_PACKAGE_REPO_URL_FOR_LOONG64}"
	util_debug_echo "REF_PACKAGE_REPO_URL_FOR_LOONG64=${REF_PACKAGE_REPO_URL_FOR_LOONG64}"


	##
	## ## Overlay / Path
	##

	util_debug_echo
	util_debug_echo "REF_OVERLAY_DIR_NAME=${REF_OVERLAY_DIR_NAME}"
	util_debug_echo "REF_OVERLAY_DIR_PATH=${REF_OVERLAY_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_FACTORY_OVERLAY_DIR_NAME=${REF_FACTORY_OVERLAY_DIR_NAME}"
	util_debug_echo "REF_FACTORY_OVERLAY_DIR_PATH=${REF_FACTORY_OVERLAY_DIR_PATH}"


	##
	## ## Package List / Path
	##

	util_debug_echo
	util_debug_echo "REF_PACKAGE_LIST_DIR_NAME=${REF_PACKAGE_LIST_DIR_NAME}"
	util_debug_echo "REF_PACKAGE_LIST_DIR_PATH=${REF_PACKAGE_LIST_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PACKAGE_INSTALL_DIR_NAME=${REF_PACKAGE_INSTALL_DIR_NAME}"
	util_debug_echo "REF_PACKAGE_INSTALL_DIR_PATH=${REF_PACKAGE_INSTALL_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_PACKAGE_REMOVE_DIR_NAME=${REF_PACKAGE_REMOVE_DIR_NAME}"
	util_debug_echo "REF_PACKAGE_REMOVE_DIR_PATH=${REF_PACKAGE_REMOVE_DIR_PATH}"


	##
	## ## Hook / Path
	##

	util_debug_echo
	util_debug_echo "REF_HOOK_DIR_NAME=${REF_HOOK_DIR_NAME}"
	util_debug_echo "REF_HOOK_DIR_PATH=${REF_HOOK_DIR_PATH}"


	##
	## ## ISO Template / Path
	##

	util_debug_echo
	util_debug_echo "REF_ISO_TEMPLATE_SOURCE_DIR_NAME=${REF_ISO_TEMPLATE_SOURCE_DIR_NAME}"
	util_debug_echo "REF_ISO_TEMPLATE_SOURCE_DIR_PATH=${REF_ISO_TEMPLATE_SOURCE_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_ISO_TEMPLATE_TARGET_DIR_NAME=${REF_ISO_TEMPLATE_TARGET_DIR_NAME}"
	util_debug_echo "REF_ISO_TEMPLATE_TARGET_DIR_PATH=${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"


	##
	## ## Live Deb / Path
	##

	util_debug_echo
	util_debug_echo "REF_LIVE_DEB_MIDDLE_DIR_NAME=${REF_LIVE_DEB_MIDDLE_DIR_NAME}"
	util_debug_echo "REF_LIVE_DEB_MIDDLE_DIR_PATH=${REF_LIVE_DEB_MIDDLE_DIR_PATH}"

	util_debug_echo
	util_debug_echo "REF_LIVE_DEB_SOURCE_DIR_NAME=${REF_LIVE_DEB_SOURCE_DIR_NAME}"
	util_debug_echo "REF_LIVE_DEB_SOURCE_DIR_PATH=${REF_LIVE_DEB_SOURCE_DIR_PATH}"



	util_debug_echo
	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Tips"
	util_debug_echo "##"
	util_debug_echo
	util_debug_echo "> Hide Dump Info"
	util_debug_echo
	util_debug_echo "\$ export IS_DEBUG=false"
	util_debug_echo




	return 0
}

master_var_init

master_var_dump




##
## ## Package Management / Util
##

util_package_find_list () {
	local file_path="$1"
	cat $file_path  | while IFS='' read -r line; do
		trim_line=$(echo $line) # trim

		## https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
		## ignore leading #
		if [ "${trim_line:0:1}" == '#' ]; then
			continue;
		fi

		## ignore empty line
		if [[ -z "$trim_line" ]]; then
			continue;
		fi

		echo "$line"
	done
}


##
## ## Target OS / Util
##

core_chroot_package_control () {

	local is_use_aptss="${REF_IS_USE_APTSS}"

	if [[ "${is_use_aptss}" == "true" ]]; then
		core_chroot_run aptss "$@"
	else
		core_chroot_run apt "$@"
	fi

}

core_chroot_run () {

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	local i=1

	for i in {1..5}; do

		sudo env DEBIAN_FRONTEND=noninteractive chroot "${rootfs}" "${@}"

		if [[ $? == 0 ]]; then
			break
		fi

		sleep 1

	done

}

gxde_target_os_mount_for_chroot () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Mount For Chroot"
	util_error_echo "##"
	util_error_echo

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	core_target_os_mount_for_chroot "${rootfs}"

}

core_target_os_mount_for_chroot () {

	local rootfs="${1}"

	mount --bind /dev "${rootfs}/dev"
	mount --bind /run  "${rootfs}/run"
	#mount --bind /media  "${rootfs}/media"
	mount -t devpts devpts "${rootfs}/dev/pts"
	mount -t sysfs sysfs "${rootfs}/sys"
	mount -t proc proc "${rootfs}/proc"
	mount -t tmpfs tmpfs  "${rootfs}/dev/shm"
	mount --bind /tmp "${rootfs}/tmp"

	return 0
}

gxde_target_os_unmount_for_chroot () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Unmount For Chroot"
	util_error_echo "##"
	util_error_echo

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	core_target_os_unmount_for_chroot "${rootfs}"

}

core_target_os_unmount_for_chroot () {

	local rootfs="${1}"

	#umount "${rootfs}/sys/firmware/efi/efivars"
	umount "${rootfs}/sys"
	umount "${rootfs}/dev/pts"
	umount "${rootfs}/dev/shm"
	umount "${rootfs}/dev"

	umount "${rootfs}/run"
	#umount "${rootfs}/media"
	umount "${rootfs}/proc"
	umount "${rootfs}/tmp"

	return 0
}


##
## ## GXDE / Build ISO / Package Required For Build
##

gxde_build_iso_package_required () {

	#return 0

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Check Package Required"
	util_error_echo "##"
	util_error_echo


	util_error_echo
	util_error_echo "apt-get install debootstrap debian-archive-keyring debian-ports-archive-keyring qemu-user-static genisoimage squashfs-tools -y"
	util_error_echo
	apt-get install debootstrap debian-archive-keyring debian-ports-archive-keyring qemu-user-static genisoimage squashfs-tools -y

	util_error_echo



}


##
## ## GXDE / Build ISO / Steps
##

gxde_build_iso_develop_test () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Run / gxde_build_iso_develop_test"
	util_error_echo "##"
	util_error_echo

	return 0

	gxde_build_iso_develop_test_overlay

	#gxde_build_iso_develop_test_package_management

}

gxde_build_iso_develop_test_overlay () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Run / gxde_build_iso_develop_test_overlay"
	util_error_echo "##"
	util_error_echo

	gxde_build_os_overlay_by_locale

	return 0
}

gxde_build_iso_develop_test_package_management () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Run / gxde_build_iso_develop_test_package_management"
	util_error_echo "##"
	util_error_echo


	#gxde_build_iso_package_required


	#gxde_build_os_dir_prepare
	#gxde_build_os_bootstrap
	gxde_target_os_mount_for_chroot


	#gxde_build_os_factory_overlay
	#gxde_build_os_factory_overlay_by_arch
	#gxde_build_os_factory_package_management
	#gxde_build_os_factory_locale
	#gxde_build_os_factory_package_management_for_aptss


	gxde_build_os_package_management
	#gxde_build_os_overlay
	#gxde_build_os_overlay_by_locale
	#gxde_build_os_locale
	#gxde_build_os_hook


	#gxde_build_os_clean
	sleep 5
	gxde_target_os_unmount_for_chroot
	sleep 5


	#gxde_build_os_archive
	#gxde_build_iso_create
	#gxde_build_iso_create_skel
	#gxde_build_iso_create_test


	return 0
}

gxde_build_iso_steps () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Run / gxde_build_iso_steps"
	util_error_echo "##"
	util_error_echo


	msg_master_args


	gxde_build_iso_package_required


	gxde_build_os_dir_prepare
	gxde_build_os_bootstrap
	gxde_target_os_mount_for_chroot


	gxde_build_os_factory_overlay
	gxde_build_os_factory_overlay_by_arch
	gxde_build_os_factory_package_management
	gxde_build_os_factory_locale
	gxde_build_os_factory_package_management_for_aptss


	gxde_build_os_package_management
	gxde_build_os_overlay
	gxde_build_os_overlay_by_locale
	gxde_build_os_locale
	gxde_build_os_hook


	gxde_build_os_clean
	sleep 5
	gxde_target_os_unmount_for_chroot
	sleep 5


	gxde_build_os_archive
	gxde_build_iso_create


	return 0
}


##
## ## GXDE / Build Target OS / Prepare
##

gxde_build_os_dir_prepare () {

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	if [[ -d "${rootfs}" ]]; then

		gxde_target_os_unmount_for_chroot

		util_error_echo
		util_error_echo rm -rf "${rootfs}"
		rm -rf "${rootfs}"

	fi

	mkdir -p "${rootfs}"

}


##
## ## GXDE / Build Target OS / Bootstrap
##

gxde_build_os_bootstrap () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Bootstrap"
	util_error_echo "##"
	util_error_echo

	local build_arch="${REF_BUILD_ARCH}"
	local build_suite="${REF_BUILD_SUITE}"
	local build_include="${REF_BUILD_INCLUDE}"
	local package_repo_url="${REF_PACKAGE_REPO_URL}"

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	local build_keyring_for_loong64="${REF_BUILD_KEYRING_FOR_LOONG64}"
	local package_repo_url_for_loong64="${REF_PACKAGE_REPO_URL_FOR_LOONG64}"


	if [[ "${build_arch}" == "loong64" ]]; then

		build_suite="unstable"

		#util_error_echo
		#util_error_echo debootstrap --no-check-gpg --keyring="${build_keyring_for_loong64}" --include="${build_include}" --arch="${build_arch}" "${build_suite}" "${rootfs}" "${package_repo_url_for_loong64}"
		#util_error_echo
		#debootstrap --no-check-gpg --keyring="${build_keyring_for_loong64}" --include="${build_include}" --arch="${build_arch}" "${build_suite}" "${rootfs}" "${package_repo_url_for_loong64}"

		util_error_echo
		util_error_echo debootstrap --no-check-gpg --keyring="${build_keyring_for_loong64}" --arch="${build_arch}" "${build_suite}" "${rootfs}" "${package_repo_url_for_loong64}"
		util_error_echo
		debootstrap --no-check-gpg --keyring="${build_keyring_for_loong64}" --arch="${build_arch}" "${build_suite}" "${rootfs}" "${package_repo_url_for_loong64}"

	else

		util_error_echo
		util_error_echo debootstrap --arch="${build_arch}" "${build_suite}" "${rootfs}" "${package_repo_url}"
		util_error_echo
		debootstrap --arch="${build_arch}" "${build_suite}" "${rootfs}" "${package_repo_url}"

	fi

}


##
## ## GXDE / Build Target OS / Overlay
##

gxde_build_os_factory_overlay () {

	local overlay_dir_path="${REF_FACTORY_OVERLAY_DIR_PATH}"
	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Factory Overlay"
	util_error_echo "##"
	util_error_echo

	util_error_echo
	util_error_echo cp -rf "${overlay_dir_path}/." "${rootfs}"
	cp -rf "${overlay_dir_path}/." "${rootfs}"

	return 0
}

gxde_build_os_factory_overlay_by_arch () {

	local build_arch="${REF_BUILD_ARCH}"

	local overlay_dir_path="${REF_FACTORY_OVERLAY_DIR_PATH}-by-arch/${build_arch}"
	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Factory Overlay By Arch"
	util_error_echo "##"
	util_error_echo

	util_error_echo
	util_error_echo cp -rf "${overlay_dir_path}/." "${rootfs}"
	cp -rf "${overlay_dir_path}/." "${rootfs}"

	return 0
}

gxde_build_os_overlay_by_locale () {

	local build_locale="${REF_BUILD_LOCALE}"

	local overlay_dir_path="${REF_FACTORY_OVERLAY_DIR_PATH}-by-locale/${build_locale}"
	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Overlay By Locale"
	util_error_echo "##"
	util_error_echo

	util_error_echo
	util_error_echo cp -rf "${overlay_dir_path}/." "${rootfs}"
	cp -rf "${overlay_dir_path}/." "${rootfs}"

	return 0
}

gxde_build_os_overlay () {

	local overlay_dir_path="${REF_OVERLAY_DIR_PATH}"
	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Overlay"
	util_error_echo "##"
	util_error_echo

	util_error_echo
	util_error_echo cp -rf "${overlay_dir_path}/." "${rootfs}"
	cp -rf "${overlay_dir_path}/." "${rootfs}"

	return 0
}


##
## ## GXDE / Build Target OS / Locale
##

gxde_build_os_factory_locale () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Factory Locale"
	util_error_echo "##"
	util_error_echo

	util_error_echo
	util_error_echo core_chroot_run apt install locales -y
	util_error_echo
	core_chroot_run apt install locales -y

	util_error_echo
	util_error_echo core_chroot_run locale-gen
	util_error_echo
	core_chroot_run locale-gen

	return 0

}

gxde_build_os_locale () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Locale"
	util_error_echo "##"
	util_error_echo

	#util_error_echo
	#util_error_echo core_chroot_package_control install locales -y
	#util_error_echo
	#core_chroot_package_control install locales -y

	util_error_echo
	util_error_echo core_chroot_run locale-gen
	util_error_echo
	core_chroot_run locale-gen

	return 0

}


##
## ## GXDE / Build Target OS / Package Management
##

gxde_build_os_factory_package_management () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Factory Package Management"
	util_error_echo "##"
	util_error_echo




	gxde_build_os_factory_package_install_keyring




	return 0
}


gxde_build_os_factory_package_management_for_aptss () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Factory Package Management"
	util_error_echo "##"
	util_error_echo




	gxde_build_os_factory_package_install_aptss



	return 0
}

gxde_build_os_package_management () {


	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Package Management"
	util_error_echo "##"
	util_error_echo




	gxde_build_os_package_install_keyring




	gxde_build_os_package_install_gxde_desktop
	gxde_build_os_package_install_installer
	gxde_build_os_package_install_live
	gxde_build_os_package_install_network
	gxde_build_os_package_install_input_method
	gxde_build_os_package_install_text_editor



	gxde_build_os_package_install_app_store
	gxde_build_os_package_install_web_browser




	gxde_build_os_package_install_each
	gxde_build_os_package_remove_each




	gxde_build_os_package_install_kernel
	gxde_build_os_package_install_driver
	gxde_build_os_package_install_grub




	gxde_build_os_package_clean
	gxde_build_os_package_downlod




	return 0
}

gxde_build_os_factory_package_install_keyring () {

	util_error_echo
	util_error_echo core_chroot_run apt install debian-ports-archive-keyring debian-archive-keyring -y
	util_error_echo
	core_chroot_run apt install debian-ports-archive-keyring debian-archive-keyring -y

	util_error_echo
	util_error_echo core_chroot_run apt update -o Acquire::Check-Valid-Until=false
	util_error_echo
	core_chroot_run apt update -o Acquire::Check-Valid-Until=false


	return 0
}

gxde_build_os_factory_package_install_aptss () {

	util_error_echo
	util_error_echo core_chroot_run apt install aptss -y
	util_error_echo
	core_chroot_run apt install aptss -y

	util_error_echo
	util_error_echo core_chroot_run aptss update -o Acquire::Check-Valid-Until=false
	util_error_echo
	core_chroot_run aptss update -o Acquire::Check-Valid-Until=false


	return 0
}

gxde_build_os_package_install_keyring () {

	util_error_echo
	util_error_echo core_chroot_package_control install debian-ports-archive-keyring debian-archive-keyring -y
	util_error_echo
	core_chroot_package_control install debian-ports-archive-keyring debian-archive-keyring -y

	util_error_echo
	util_error_echo core_chroot_package_control update -o Acquire::Check-Valid-Until=false
	util_error_echo
	core_chroot_package_control update -o Acquire::Check-Valid-Until=false


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install gxde_desktop
##

gxde_build_os_package_install_gxde_desktop () {

	util_error_echo
	util_error_echo core_chroot_package_control install gxde-desktop -y --install-recommends
	util_error_echo
	core_chroot_package_control install gxde-desktop -y --install-recommends

	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install Installer
##

gxde_build_os_package_install_installer () {

	local build_arch="${REF_BUILD_ARCH}"

	if [[ "${build_arch}" != "mips64el" ]]; then

		util_error_echo
		util_error_echo core_chroot_package_control install calamares-settings-gxde -y --install-recommends
		util_error_echo
		core_chroot_package_control install calamares-settings-gxde -y --install-recommends

	else

		util_error_echo
		util_error_echo core_chroot_package_control install gxde-installer -y --install-recommends
		util_error_echo
		core_chroot_package_control install gxde-installer -y --install-recommends

	fi




	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo rm -rf "${rootfs}/var/lib/dpkg/info/plymouth-theme-gxde-logo.postinst"
	util_error_echo
	rm -rf "${rootfs}/var/lib/dpkg/info/plymouth-theme-gxde-logo.postinst"




	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install Live System Control
##

gxde_build_os_package_install_live () {

	util_error_echo
	util_error_echo core_chroot_package_control install live-task-recommended live-task-standard live-config-systemd live-boot -y
	util_error_echo
	core_chroot_package_control install live-task-recommended live-task-standard live-config-systemd live-boot -y


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install Network
##

gxde_build_os_package_install_network () {

	util_error_echo
	util_error_echo core_chroot_package_control install network-manager-gnome -y
	util_error_echo
	core_chroot_package_control install network-manager-gnome -y


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install Input Method
##

gxde_build_os_package_install_input_method () {

	util_error_echo
	util_error_echo core_chroot_package_control install im-config fcitx5 fcitx5-chewing fcitx5-pinyin -y
	util_error_echo
	core_chroot_package_control install im-config fcitx5 fcitx5-chewing fcitx5-pinyin -y


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install Text Editor
##

gxde_build_os_package_install_text_editor () {

	util_error_echo
	util_error_echo core_chroot_package_control install vim micro -y
	util_error_echo
	core_chroot_package_control install vim micro -y


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install App Store
##

gxde_build_os_package_install_app_store () {

	local build_arch="${REF_BUILD_ARCH}"


	if [[ "${build_arch}" == "mips64el" ]]; then

		util_error_echo
		util_error_echo core_chroot_run apt install loongsonapplication -y
		util_error_echo
		core_chroot_run apt install loongsonapplication -y

	elif [[ "${build_arch}" != "i386" ]]; then

		util_error_echo
		util_error_echo core_chroot_run apt install spark-store -y
		util_error_echo
		core_chroot_run apt install spark-store -y

	else

		util_error_echo
		util_error_echo core_chroot_run apt install aptss -y
		util_error_echo
		core_chroot_run apt install aptss -y

	fi




	util_error_echo
	util_error_echo core_chroot_package_control update -o Acquire::Check-Valid-Until=false
	util_error_echo
	core_chroot_package_control update -o Acquire::Check-Valid-Until=false


	util_error_echo
	util_error_echo core_chroot_package_control full-upgrade -y
	util_error_echo
	core_chroot_package_control full-upgrade -y


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install Web Browser
##

gxde_build_os_package_install_web_browser () {

	local build_arch="${REF_BUILD_ARCH}"


	if [[ "${build_arch}" == "loong64" ]]; then

		util_error_echo
		util_error_echo core_chroot_run aptss install cn.loongnix.lbrowser -y
		util_error_echo
		core_chroot_run aptss install cn.loongnix.lbrowser -y

	elif [[ "${build_arch}" == "amd64" ]]; then

		util_error_echo
		util_error_echo core_chroot_run aptss install firefox-spark -y
		util_error_echo
		core_chroot_run aptss install firefox-spark -y

		util_error_echo
		util_error_echo core_chroot_run aptss install spark-deepin-cloud-print spark-deepin-cloud-scanner -y
		util_error_echo
		core_chroot_run aptss install spark-deepin-cloud-print spark-deepin-cloud-scanner -y


		util_error_echo
		util_error_echo core_chroot_package_control install dummyapp-wps-office dummyapp-spark-deepin-wine-runner -y
		util_error_echo
		core_chroot_package_control install dummyapp-wps-office dummyapp-spark-deepin-wine-runner -y

	elif [[ "${build_arch}" == "arm64" ]]; then

		util_error_echo
		util_error_echo core_chroot_run aptss install firefox-spark -y
		util_error_echo
		core_chroot_run aptss install firefox-spark -y

		util_error_echo
		util_error_echo core_chroot_package_control install dummyapp-wps-office dummyapp-spark-deepin-wine-runner -y
		util_error_echo
		core_chroot_package_control install dummyapp-wps-office dummyapp-spark-deepin-wine-runner -y

	else

		#util_error_echo
		#util_error_echo core_chroot_package_control install chromium chromium-l10n -y
		#util_error_echo
		#core_chroot_package_control install chromium chromium-l10n -y


		util_error_echo
		util_error_echo core_chroot_package_control install firefox-esr firefox-esr-l10n-zh-tw firefox-esr-l10n-zh-cn -y
		util_error_echo
		core_chroot_package_control install firefox-esr firefox-esr-l10n-zh-tw firefox-esr-l10n-zh-cn -y

	fi


	return 0
}



##
## ## GXDE / Build Target OS / Package Management / Install By List File
##

gxde_build_os_package_install_each () {

	local list_dir_path="${REF_PACKAGE_INSTALL_DIR_PATH}"

	local list_file_path=""

	for list_file_path in "${list_dir_path}"/*.txt; do

		#util_error_echo ${list_file_path}

		util_error_echo
		util_error_echo core_chroot_package_control install $(util_package_find_list ${list_file_path}) -y
		util_error_echo
		core_chroot_package_control install $(util_package_find_list ${list_file_path}) -y

	done


	return 0

}


##
## ## GXDE / Build Target OS / Package Management / Remove By List File
##

gxde_build_os_package_remove_each () {

	local list_dir_path="${REF_PACKAGE_REMOVE_DIR_PATH}"

	local list_file_path=""

	for list_file_path in "${list_dir_path}"/*.txt; do

		#util_error_echo ${list_file_path}

		util_error_echo
		util_error_echo core_chroot_package_control remove $(util_package_find_list ${list_file_path}) -y
		util_error_echo
		core_chroot_package_control remove $(util_package_find_list ${list_file_path}) -y

	done


	return 0

}


##
## ## GXDE / Build Target OS / Package Management / Install Kernel
##

gxde_build_os_package_install_kernel () {

	local build_arch="${REF_BUILD_ARCH}"

	local kernel_package="linux-kernel-gxde-${build_arch}"

	local oldstable_kernel_package="linux-kernel-oldstable-gxde-${build_arch}"


	if [[ "${build_arch}" != "amd64" ]]; then

		util_error_echo
		util_error_echo core_chroot_package_control autopurge "linux-image-*" "linux-headers-*" -y
		util_error_echo
		core_chroot_package_control autopurge "linux-image-*" "linux-headers-*" -y

	fi


	##
	## ## install main kernel
	##
	#core_chroot_package_control install linux-headers-generic linux-image-generic -y

	util_error_echo
	util_error_echo core_chroot_package_control install ${kernel_package} -y
	util_error_echo
	core_chroot_package_control install ${kernel_package} -y


	##
	## ## install oldstable kernel
	##
	if [[ "${build_arch}" == "amd64" ]] || [[ "${build_arch}" == "i386" ]] || [[ "${build_arch}" == "mips64el" ]]; then

		util_error_echo
		util_error_echo core_chroot_package_control install ${oldstable_kernel_package} -y
		util_error_echo
		core_chroot_package_control install ${oldstable_kernel_package} -y

	fi


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install Driver
##

gxde_build_os_package_install_driver () {

	util_error_echo
	util_error_echo core_chroot_package_control install firmware-linux firmware-linux-free firmware-linux-nonfree -y
	util_error_echo
	core_chroot_package_control install firmware-linux firmware-linux-free firmware-linux-nonfree -y


	util_error_echo
	util_error_echo core_chroot_package_control install firmware-iwlwifi firmware-realtek -y
	util_error_echo
	core_chroot_package_control install firmware-iwlwifi firmware-realtek -y


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Install GRUB
##

gxde_build_os_package_install_grub () {

	util_error_echo
	util_error_echo core_chroot_package_control install grub-common -y
	util_error_echo
	core_chroot_package_control install grub-common -y


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Clean
##

gxde_build_os_package_clean () {

	util_error_echo
	util_error_echo core_chroot_package_control autopurge -y
	util_error_echo
	core_chroot_package_control autopurge -y


	util_error_echo
	util_error_echo core_chroot_package_control clean -y
	util_error_echo
	core_chroot_package_control clean -y


	return 0
}


##
## ## GXDE / Build Target OS / Package Management / Downlod Debian Package
##

gxde_build_os_package_downlod () {

	local build_arch="${REF_BUILD_ARCH}"


	##
	## ## download debian package
	##
	util_error_echo
	util_error_echo core_chroot_package_control install grub-pc -y --download-only
	util_error_echo
	core_chroot_package_control install grub-pc -y --download-only


	util_error_echo
	util_error_echo core_chroot_package_control install "grub-efi-${build_arch}" -y --download-only
	util_error_echo
	core_chroot_package_control install "grub-efi-${build_arch}" -y --download-only

	util_error_echo
	util_error_echo core_chroot_package_control install grub-efi -y --download-only
	util_error_echo
	core_chroot_package_control install grub-efi -y --download-only

	util_error_echo
	util_error_echo core_chroot_package_control install grub-common -y --download-only
	util_error_echo
	core_chroot_package_control install grub-common -y --download-only

	util_error_echo
	util_error_echo core_chroot_package_control install cryptsetup-initramfs cryptsetup keyutils -y --download-only
	util_error_echo
	core_chroot_package_control install cryptsetup-initramfs cryptsetup keyutils -y --download-only



	##
	## ## prepare middle dir
	##
	util_error_echo
	util_error_echo mkdir -p "${REF_LIVE_DEB_MIDDLE_DIR_PATH}"
	util_error_echo
	mkdir -p "${REF_LIVE_DEB_MIDDLE_DIR_PATH}"

	util_error_echo
	util_error_echo rm -rf "${REF_LIVE_DEB_MIDDLE_DIR_PATH}"
	util_error_echo
	rm -rf "${REF_LIVE_DEB_MIDDLE_DIR_PATH}"

	util_error_echo
	util_error_echo mkdir -p "${REF_LIVE_DEB_MIDDLE_DIR_PATH}"
	util_error_echo
	mkdir -p "${REF_LIVE_DEB_MIDDLE_DIR_PATH}"


	##
	## ## cp download debian package to middle dir
	##
	util_error_echo
	util_error_echo cp -v "${REF_LIVE_DEB_SOURCE_DIR_PATH}"/*.deb "${REF_LIVE_DEB_MIDDLE_DIR_PATH}"
	util_error_echo
	cp -v "${REF_LIVE_DEB_SOURCE_DIR_PATH}"/*.deb "${REF_LIVE_DEB_MIDDLE_DIR_PATH}"


	util_error_echo
	util_error_echo core_chroot_package_control clean -y
	util_error_echo
	core_chroot_package_control clean -y


	return 0
}


##
## ## GXDE / Build Target OS / Hook
##

gxde_build_os_hook () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Hook"
	util_error_echo "##"
	util_error_echo

	local hook_source_dir_path="${REF_HOOK_DIR_PATH}"
	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"
	local chroot_hook_dir_path="/opt/tmp/work/hook"
	local hook_middle_dir_path="${rootfs}${chroot_hook_dir_path}"


	util_error_echo
	util_error_echo rm -rf "${hook_middle_dir_path}"
	rm -rf "${hook_middle_dir_path}"


	util_error_echo
	util_error_echo mkdir -p "${hook_middle_dir_path}"
	mkdir -p "${hook_middle_dir_path}"


	util_error_echo
	util_error_echo cp -rf "${hook_source_dir_path}/." "${hook_middle_dir_path}"
	cp -rf "${hook_source_dir_path}/." "${hook_middle_dir_path}"


	local hook_file_path=""
	local hook_file_name=""
	local chroot_hook_file_path=""

	for hook_file_path in "${hook_middle_dir_path}"/*.hook.chroot; do

		hook_file_name="$(basename ${hook_file_path})"
		chroot_hook_file_path="${chroot_hook_dir_path}/${hook_file_name}"

		#util_error_echo "${hook_file_path}"
		#util_error_echo "${hook_file_name}"
		#util_error_echo "${chroot_hook_file_path}"

		if [[ ! -x "${hook_file_path}" ]]; then
			continue;
		fi


		util_error_echo
		util_error_echo
		util_error_echo "## > Hook:"


		util_error_echo
		util_error_echo core_chroot_run "${chroot_hook_file_path}"
		util_error_echo
		core_chroot_run "${chroot_hook_file_path}"

	done


	return 0

}


##
## ## GXDE / Build Target OS / Clean
##

gxde_build_os_clean () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Clean"
	util_error_echo "##"
	util_error_echo


	gxde_build_os_package_clean


	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	util_error_echo
	util_error_echo rm -rf "${rootfs}/var/log"/*
	rm -rf "${rootfs}/var/log"/*


	util_error_echo
	util_error_echo rm -rf "${rootfs}/root/.bash_history"
	util_error_echo
	rm -rf "${rootfs}/root/.bash_history"


	util_error_echo
	util_error_echo rm -rf "${rootfs}/initrd.img.old"
	util_error_echo
	rm -rf "${rootfs}/initrd.img.old"


	util_error_echo
	util_error_echo rm -rf "${rootfs}/vmlinuz.old"
	util_error_echo
	rm -rf "${rootfs}/vmlinuz.old"


	return 0
}


##
## ## GXDE / Build Target OS / Archive
##

gxde_build_os_archive () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build Target OS / Archive"
	util_error_echo "##"
	util_error_echo

	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"
	local os_archive_file_path="${REF_TARGET_OS_ARCHIVE_FILE_PATH}"

	util_error_echo
	util_error_echo cd "${rootfs}"
	cd "${rootfs}"

	util_error_echo
	util_error_echo rm -rf "${os_archive_file_path}"
	rm -rf "${os_archive_file_path}"

	util_error_echo
	util_error_echo mksquashfs * "${os_archive_file_path}"
	mksquashfs * "${os_archive_file_path}"


	util_error_echo
	util_error_echo cd "${OLDPWD}"
	cd "${OLDPWD}"

}


##
## ## GXDE / ISO Template / Prepare
##

gxde_iso_template_prepare () {

	local iso_template_target_dir_path="${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"
	local iso_template_source_dir_path="${REF_ISO_TEMPLATE_SOURCE_DIR_PATH}"


	util_error_echo
	util_error_echo rm -rf "${iso_template_target_dir_path}"
	rm -rf "${iso_template_target_dir_path}"

	util_error_echo
	util_error_echo mkdir -p "${iso_template_target_dir_path}"
	mkdir -p "${iso_template_target_dir_path}"


	util_error_echo
	util_error_echo cp -rf "${iso_template_source_dir_path}/." "${iso_template_target_dir_path}"
	cp -rf "${iso_template_source_dir_path}/." "${iso_template_target_dir_path}"




	##
	## ## prepare extra dir
	##
	local build_arch="${REF_BUILD_ARCH}"
	local build_arch_dir_path="${iso_template_target_dir_path}/${build_arch}"


	util_error_echo
	util_error_echo mkdir -p "${build_arch_dir_path}/live"
	mkdir -p "${build_arch_dir_path}/live"


	util_error_echo
	util_error_echo mkdir -p "${build_arch_dir_path}/deb"
	mkdir -p "${build_arch_dir_path}/deb"


	return 0
}


##
## ## GXDE / ISO Template / Prepare / copy Kernel
##

gxde_iso_template_prepare_copy_kernel () {


	local rootfs="${REF_TARGET_OS_ROOT_DIR_PATH}"

	local iso_template_target_dir_path="${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"

	local build_arch="${REF_BUILD_ARCH}"
	local build_arch_dir_path="${iso_template_target_dir_path}/${build_arch}"


	##
	## ## prepare dir
	##
	util_error_echo
	util_error_echo mkdir -p "${build_arch_dir_path}/live"
	mkdir -p "${build_arch_dir_path}/live"




	local kernel_number=$(ls -1 ${rootfs}/boot/vmlinuz-* | wc -l)
	local vmlinuz_list=($(ls -1 ${rootfs}/boot/vmlinuz-* | sort -rV))
	local initrd_list=($(ls -1 ${rootfs}/boot/initrd.img-* | sort -rV))

	#util_error_echo "kernel_number=${kernel_number}"
	#util_error_echo "vmlinuz_list=${vmlinuz_list}"
	#util_error_echo "initrd_list=${initrd_list}"

	local i=0

	for i in $( seq 0 $(expr ${kernel_number} - 1) ); do

		if [[ ${i} == 0 ]]; then
			cp "${vmlinuz_list[i]}" "${build_arch_dir_path}/live/vmlinuz" -v
			cp "${initrd_list[i]}" "${build_arch_dir_path}/live/initrd.img" -v
		fi

		if [[ ${i} == 1 ]]; then
			cp "${vmlinuz_list[i]}" "${build_arch_dir_path}/live/vmlinuz-oldstable" -v
			cp "${initrd_list[i]}" "${build_arch_dir_path}/live/initrd.img-oldstable" -v
		fi

	done


	return 0
}

##
## ## GXDE / ISO Template / Prepare / copy os archive
##


gxde_iso_template_prepare_copy_os_archive () {


	local iso_template_target_dir_path="${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"

	local build_arch="${REF_BUILD_ARCH}"
	local build_arch_dir_path="${iso_template_target_dir_path}/${build_arch}"

	local os_archive_file_path="${REF_TARGET_OS_ARCHIVE_FILE_PATH}"


	##
	## ## prepare dir
	##
	util_error_echo
	util_error_echo mkdir -p "${build_arch_dir_path}/live"
	mkdir -p "${build_arch_dir_path}/live"


	##
	## ## prepare os archive
	##

	util_error_echo
	util_error_echo mv "${os_archive_file_path}" "${build_arch_dir_path}/live/filesystem.squashfs" -v
	util_error_echo
	mv "${os_archive_file_path}" "${build_arch_dir_path}/live/filesystem.squashfs" -v

	#util_error_echo
	#util_error_echo cp "${os_archive_file_path}" "${build_arch_dir_path}/live/filesystem.squashfs" -v
	#util_error_echo
	#cp "${os_archive_file_path}" "${build_arch_dir_path}/live/filesystem.squashfs" -v


	util_error_echo


	return 0
}



##
## ## GXDE / ISO Template / Prepare / add debian package
##

gxde_iso_template_prepare_add_debian_package () {


	local iso_template_target_dir_path="${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"

	local build_arch="${REF_BUILD_ARCH}"
	local build_arch_dir_path="${iso_template_target_dir_path}/${build_arch}"

	local live_deb_middle_dir_path="${REF_LIVE_DEB_MIDDLE_DIR_PATH}/${build_arch}"


	##
	## ## add debian package / prepare dir
	##
	util_error_echo
	util_error_echo mkdir -p "${build_arch_dir_path}/deb"
	mkdir -p "${build_arch_dir_path}/deb"


	##
	## ## add debian package / head
	##
	util_error_echo
	util_error_echo cd "${build_arch_dir_path}/deb"
	cd "${build_arch_dir_path}/deb"


	##
	## ## add debian package / start
	##
	util_error_echo
	util_error_echo ./addmore.py "${live_deb_middle_dir_path}"/*.deb
	util_error_echo
	./addmore.py "${live_deb_middle_dir_path}"/*.deb


	##
	## ## add debian package / tail
	##
	util_error_echo
	util_error_echo cd "${OLDPWD}"
	cd "${OLDPWD}"


	return 0
}


##
## ## GXDE / Build ISO / Archive
##

gxde_build_iso_archive () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build ISO / Archive / Start"
	util_error_echo "##"
	util_error_echo


	local iso_template_target_dir_path="${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"
	local iso_template_source_dir_path="${REF_ISO_TEMPLATE_SOURCE_DIR_PATH}"

	local build_arch="${REF_BUILD_ARCH}"
	local build_agent_file_name="${build_arch}-build.sh"
	local build_agent="./${build_agent_file_name}"
	local build_agent_path="${iso_template_target_dir_path}/${build_agent_file_name}"


	##
	## ## iso build head
	##
	util_error_echo
	util_error_echo cd "${iso_template_target_dir_path}"
	cd "${iso_template_target_dir_path}"


	##
	## ## iso build start
	##
	util_error_echo
	util_error_echo bash "${build_agent}"
	util_error_echo
	bash "${build_agent}"


	##
	## ## iso build tail
	##
	util_error_echo
	util_error_echo "cd ${OLDPWD}"
	cd "${OLDPWD}"




	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build ISO / Archive / Done"
	util_error_echo "##"
	util_error_echo


	return 0
}


##
## ## GXDE / Build ISO / Create
##

gxde_build_iso_create () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build ISO / Create"
	util_error_echo "##"
	util_error_echo


	##
	## ## create iso template
	##
	gxde_iso_template_prepare


	local iso_template_target_dir_path="${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"
	local iso_template_source_dir_path="${REF_ISO_TEMPLATE_SOURCE_DIR_PATH}"

	local build_arch="${REF_BUILD_ARCH}"
	local build_agent_file_name="${build_arch}-build.sh"
	local build_agent="./${build_agent_file_name}"
	local build_agent_path="${iso_template_target_dir_path}/${build_agent_file_name}"


	if [[ ! -f "${build_agent_path}" ]]; then

		util_error_echo
		util_error_echo "##"
		util_error_echo "## ## Build iso script not exists: "
		util_error_echo "##"

		util_error_echo
		util_error_echo "> ${build_agent_path}"
		util_error_echo

		exit 1
	fi


	##
	## ## add debian package
	##
	gxde_iso_template_prepare_add_debian_package


	##
	## ## copy kernel
	##
	gxde_iso_template_prepare_copy_kernel


	##
	## ## copy os archive
	##
	gxde_iso_template_prepare_copy_os_archive


	##
	## ## create iso
	##
	gxde_build_iso_archive


	return 0
}

gxde_build_iso_create_skel () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build ISO / Create Skel"
	util_error_echo "##"
	util_error_echo


	##
	## ## create iso template
	##
	gxde_iso_template_prepare


	local iso_template_target_dir_path="${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"
	local iso_template_source_dir_path="${REF_ISO_TEMPLATE_SOURCE_DIR_PATH}"

	local build_arch="${REF_BUILD_ARCH}"
	local build_agent_file_name="${build_arch}-build.sh"
	local build_agent="./${build_agent_file_name}"
	local build_agent_path="${iso_template_target_dir_path}/${build_agent_file_name}"


	if [[ ! -f "${build_agent_path}" ]]; then

		util_error_echo
		util_error_echo "##"
		util_error_echo "## ## Build iso script not exists: "
		util_error_echo "##"

		util_error_echo
		util_error_echo "> ${build_agent_path}"
		util_error_echo

		exit 1
	fi


	##
	## ## create iso
	##
	gxde_build_iso_archive


	return 0
}

gxde_build_iso_create_test () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## GXDE / Build ISO / Create"
	util_error_echo "##"
	util_error_echo


	##
	## ## create iso template
	##
	gxde_iso_template_prepare


	local iso_template_target_dir_path="${REF_ISO_TEMPLATE_TARGET_DIR_PATH}"
	local iso_template_source_dir_path="${REF_ISO_TEMPLATE_SOURCE_DIR_PATH}"

	local build_arch="${REF_BUILD_ARCH}"
	local build_agent_file_name="${build_arch}-build.sh"
	local build_agent="./${build_agent_file_name}"
	local build_agent_path="${iso_template_target_dir_path}/${build_agent_file_name}"


	if [[ ! -f "${build_agent_path}" ]]; then

		util_error_echo
		util_error_echo "##"
		util_error_echo "## ## Build iso script not exists: "
		util_error_echo "##"

		util_error_echo
		util_error_echo "> ${build_agent_path}"
		util_error_echo

		exit 1
	fi


	##
	## ## add debian package
	##
	gxde_iso_template_prepare_add_debian_package


	##
	## ## copy kernel
	##
	#gxde_iso_template_prepare_copy_kernel


	##
	## ## copy os archive
	##
	#gxde_iso_template_prepare_copy_os_archive


	##
	## ## create iso
	##
	gxde_build_iso_archive


	return 0
}

##
## ## GXDE / Build ISO / Start
##

gxde_build_iso_start () {

	main_signal_bind

	limit_root_user_required


	local main_run="${REF_MAIN_RUN}"

	if [[ "${main_run}" == "test" ]]; then
		gxde_build_iso_develop_test
	else
		gxde_build_iso_steps
	fi


	return 0
}


##
## ## Limit / Root User Required
##

limit_root_user_required () {

	if [[ "${EUID}" == 0 ]]; then

		return 0

	else

		util_error_echo
		util_error_echo "##"
		util_error_echo "## ## Root User Required"
		util_error_echo "##"

		util_error_echo
		util_error_echo "> Please Run As Root"
		util_error_echo
		util_error_echo "Example: sudo ./${REF_CMD_FILE_NAME} amd64"
		util_error_echo

		#sleep 2
		exit 0
	fi

}


##
## ## Main / Signal
##

exit_on_signal_interrupted () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## **Script Interrupted**"
	util_error_echo "##"
	util_error_echo

	## TODO:

	sleep 2
	gxde_target_os_unmount_for_chroot


	exit 0

}

exit_on_signal_terminated () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## **Script Terminated**"
	util_error_echo "##"
	util_error_echo

	## TODO:

	sleep 2


	exit 0

}

main_signal_bind () {

	trap exit_on_signal_interrupted SIGINT
	trap exit_on_signal_terminated SIGTERM

}


##
## ## Msg / Help
##

msg_help_build_arch_required () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Build Arch Required"
	util_error_echo "##"

	util_error_echo
	msg_usage_body_main
	util_error_echo

}

msg_help_build_arch_not_supported () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Build Arch Not Supported"
	util_error_echo "##"

	util_error_echo
	msg_usage_body_main
	util_error_echo

}

msg_help_build_locale_not_supported () {

	util_error_echo
	util_error_echo "##"
	util_error_echo "## ## Build Locale Not Supported"
	util_error_echo "##"

	util_error_echo
	msg_usage_body_locale
	util_error_echo

}

msg_usage_body_main () {


	util_error_echo "> Build Arch Options: ${REF_BUILD_ARCH_OPTION_LIST}"
	util_error_echo
	util_error_echo "SYNOPSIS : sudo ./${REF_CMD_FILE_NAME} [build_arch] [aptss]"
	util_error_echo
	util_error_echo "Example  : sudo ./${REF_CMD_FILE_NAME} amd64"
	util_error_echo
	util_error_echo "Example  : sudo ./${REF_CMD_FILE_NAME} amd64 aptss"
	util_error_echo
	util_error_echo "Example  : sudo ./${REF_CMD_FILE_NAME} unstable aptss"


	return 0
}

msg_usage_body_locale () {


	util_error_echo "> Build Locale Options: ${REF_BUILD_LOCALE_OPTION_LIST}"
	util_error_echo
	util_error_echo "SYNOPSIS : sudo REF_BUILD_LOCALE=zh_tw ./${REF_CMD_FILE_NAME} [build_arch] [aptss]"
	util_error_echo
	util_error_echo "Example  : sudo REF_BUILD_LOCALE=zh_tw ./${REF_CMD_FILE_NAME} amd64"
	util_error_echo
	util_error_echo "Example  : sudo REF_BUILD_LOCALE=ez_cn ./${REF_CMD_FILE_NAME} amd64"


	return 0
}


##
## ## Msg / Args
##

msg_master_args () {

	util_error_echo
	util_error_echo "Build: REF_BUILD_ARCH=${REF_BUILD_ARCH}"
	util_error_echo "Build: REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"
	util_error_echo "Build: REF_IS_USE_APTSS=${REF_IS_USE_APTSS}"
	util_error_echo

	return 0
}

##
## ## Master / Args
##

master_arg_build_arch () {

	util_debug_echo
	util_debug_echo "Arg: 1=${1}"

	REF_BUILD_ARCH="${1}"


	if [[ -z "${REF_BUILD_ARCH}" ]]; then
		REF_BUILD_ARCH="${DEFAULT_BUILD_ARCH}"
	fi


	local not_allowed="true"
	local allow_build_arch=""

	for allow_build_arch in ${REF_BUILD_ARCH_OPTION_LIST}; do

		if [[ "${allow_build_arch}" == "${REF_BUILD_ARCH}" ]]; then

			util_debug_echo "allow_build_arch=${allow_build_arch}"
			not_allowed="false"
			break;

		fi

	done


	if [[ "${not_allowed}" == "true" ]]; then
		util_debug_echo "Var: REF_BUILD_ARCH=${REF_BUILD_ARCH}"

		msg_help_build_arch_not_supported

		util_error_echo "Arg: 1=${1}"
		util_error_echo "Var: REF_BUILD_ARCH=${REF_BUILD_ARCH}"
		exit;
	fi


	util_debug_echo "Var: REF_BUILD_ARCH=${REF_BUILD_ARCH}"

	return 0
}

master_arg_is_use_aptss () {

	util_debug_echo
	util_debug_echo "Arg: 2=${2}"


	if [[ "${1}" == "aptss" ]] || [[ "${2}" == "aptss" ]]|| [[ "${3}" == "aptss" ]]; then
		REF_IS_USE_APTSS="true"
	fi


	if [[ -z "${REF_IS_USE_APTSS}" ]]; then
		REF_IS_USE_APTSS="${DEFAULT_IS_USE_APTSS}"
	fi


	util_debug_echo "Var: REF_IS_USE_APTSS=${REF_IS_USE_APTSS}"

	return 0
}

master_arg_build_locale () {

	util_debug_echo


	if [[ -z "${REF_BUILD_LOCALE}" ]]; then
		REF_BUILD_LOCALE="${DEFAULT_BUILD_LOCALE}"
	fi


	local not_allowed="true"
	local allow_build_locale=""

	for allow_build_locale in ${REF_BUILD_LOCALE_OPTION_LIST}; do

		if [[ "${allow_build_locale}" == "${REF_BUILD_LOCALE}" ]]; then

			util_debug_echo "allow_build_locale=${allow_build_locale}"
			not_allowed="false"
			break;

		fi

	done


	if [[ "${not_allowed}" == "true" ]]; then

		util_debug_echo "Var: REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"

		msg_help_build_locale_not_supported

		util_error_echo "Var: REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"
		exit;

	fi


	util_debug_echo "Var: REF_BUILD_LOCALE=${REF_BUILD_LOCALE}"

	return 0
}


##
## ## Main / Args
##

_main_check_args_size_ () {

	local args_size="${1}"

	if [[ ${1} -le 0 ]]; then

		msg_help_build_arch_required

		exit 1

	fi

}

_main_init_args_ () {

	##
	## Example: `sudo ./steps.sh amd64 aptss`
	##

	util_debug_echo
	util_debug_echo "##"
	util_debug_echo "## ## Args / Init"
	util_debug_echo "##"


	master_arg_build_arch "${@}"

	master_arg_is_use_aptss "${@}"

	master_arg_build_locale "${@}"


	util_debug_echo

	return 0
}


##
## ## Main / Start
##

__main__ () {

	gxde_build_iso_start "${@}"

}

_main_check_args_size_ "${#}"

_main_init_args_ "${@}"

__main__ "${@}"
