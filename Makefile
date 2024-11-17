
default: help
.PHONY: default

help:
	@echo 'Usage:'
	@echo '	$$ make [action]'
	@echo
	@echo 'Ex:'
	@echo '	$$ make'
	@echo '	$$ make help'
	@echo
	@echo '	$$ make build'
	@echo
.PHONY: help




build:
	@./build.sh
.PHONY: build




en_us:
	sudo REF_BUILD_LOCALE=en_us ./steps.sh amd64
.PHONY: en_us


zh_tw:
	sudo REF_BUILD_LOCALE=zh_tw ./steps.sh amd64
.PHONY: zh_tw


zh_cn:
	sudo REF_BUILD_LOCALE=zh_cn ./steps.sh amd64
.PHONY: zh_cn


zh_hk:
	sudo REF_BUILD_LOCALE=zh_hk ./steps.sh amd64
.PHONY: zh_hk


ja_jp:
	sudo REF_BUILD_LOCALE=ja_jp ./steps.sh amd64
.PHONY: ja_jp


ko_kr:
	sudo REF_BUILD_LOCALE=ko_kr ./steps.sh amd64
.PHONY: ko_kr




#test:
#	sudo REF_MAIN_RUN=test ./steps.sh amd64
#.PHONY: test




clean:
	sudo rm -rf /opt/tmp/gxde
.PHONY: clean




chroot-mount:
	@./chroot-mount.sh
.PHONY: chroot-mount


chroot-unmount:
	@./chroot-unmount.sh
.PHONY: chroot-unmount

