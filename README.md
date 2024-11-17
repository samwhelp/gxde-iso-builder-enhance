

# gxde-iso-builder-enhance

> Prototype: [gxde-iso-builder](https://github.com/GXDE-OS/gxde-iso-builder)

| Link | GitHub |
| ---- | ------ |
| [gxde-iso-builder-enhance](https://samwhelp.github.io/gxde-iso-builder-enhance/) | [GitHub](https://github.com/samwhelp/gxde-iso-builder-enhance) |
| [gxde-iso-builder-refactoring](https://samwhelp.github.io/gxde-iso-builder-refactoring/) | [GitHub](https://github.com/samwhelp/gxde-iso-builder-refactoring) |
| [gxde-iso-builder-remix](https://samwhelp.github.io/gxde-iso-builder-remix/) | [GitHub](https://github.com/samwhelp/gxde-iso-builder-remix) |




## Subject

* [Clone](#clone)
* [Usage](#usage)
* [Config File](#config-file)
* [Link](#link)




## Clone

> clone

``` sh
git clone https://github.com/samwhelp/gxde-iso-builder-enhance.git
```

> cd work dir

``` sh
cd gxde-iso-builder-enhance
```




## Usage

* [build](#build)
* [build locale](#build-locale)
* [test](#test)


> [Makefile](Makefile)




### build

> build: loacle=en_us, arch=amd64

``` sh
make build
```

> /opt/tmp/gxde/work/iso-template/gxde.iso




### build locale

> [make en_us](Makefile#L27-L29)

``` sh
sudo REF_BUILD_LOCALE=en_us ./steps.sh amd64
```


> [make zh_tw](Makefile#L32-L34)

``` sh
sudo REF_BUILD_LOCALE=zh_tw ./steps.sh amd64
```


> [make zh_cn](Makefile#L37-L39)

``` sh
sudo REF_BUILD_LOCALE=zh_cn ./steps.sh amd64
```


> [make zh_hk](Makefile#L42-L44)

``` sh
sudo REF_BUILD_LOCALE=zh_hk ./steps.sh amd64
```


> [make ja_jp](Makefile#L47-L49)

``` sh
sudo REF_BUILD_LOCALE=ja_jp ./steps.sh amd64
```


> [make ko_kr](Makefile#L52-L54)

``` sh
sudo REF_BUILD_LOCALE=ko_kr ./steps.sh amd64
```




### test

> for developer testing

``` sh
sudo REF_MAIN_RUN=test ./steps.sh amd64
```




## Config File

> Build Target OS / Config File

| Mousebind |
| --------------------- |
| [~/.config/deepin-kwinrc](./asset/overlay/etc/skel/.config/deepin-kwinrc#L50-L56) |


| Keybind |
| --------------------- |
| [~/.config/kglobalshortcutsrc](./asset/overlay/etc/skel/.config/kglobalshortcutsrc#L45-L197) |
| [~/.config/deepin/dde-daemon/keybinding/custom.ini](./asset/overlay/etc/skel/.config/deepin/dde-daemon/keybinding/custom.ini) |
| [/usr/share/glib-2.0/schemas/95_gxde-adjustment-keybind.gschema.override](./asset/overlay/usr/share/glib-2.0/schemas/95_gxde-adjustment-keybind.gschema.override) |




## Link

* [gxde-adjustment](https://github.com/samwhelp/gxde-adjustment) / gxde-config / [Deepin-Light](https://github.com/samwhelp/gxde-adjustment/tree/main/prototype/main/gxde-config/locale/en_us/Deepin-Light)
* [debian-iso-builder-start](https://github.com/samwhelp/debian-iso-builder-start)
