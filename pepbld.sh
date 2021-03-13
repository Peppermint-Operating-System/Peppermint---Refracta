#!/bin/bash
#Set the working folder variable
uchinanchu="$(pwd)"
#the name of the iso working folder
mkdir fusato
cd fusato

#--archive-areas "main contrib non-free" 
##ARCHIVE_AREA|"ARCHIVE_AREAS" defines which package archive areas of a debian packages archive should be used for configured debian package mirrors. By default, this is set to main. Remember to check the licenses of each packages with respect to their redistributability in your juristiction when enabling contrib or non-free with this mechanism.

#--architectures amd64
##ARCHITECTURE defines the architecture of the to be build image. By default, this is set to the host architecture. Note that you cannot crossbuild for another architecture if your host system is not able to execute binaries for the target architecture natively. For example, building amd64 images on i386 and vice versa is possible if you have a 64bit capable i386 processor and the right kernel. But building powerpc images on an i386 system is not possible.

#--apt-recommends true 
##true|false defines if apt should install recommended packages automatically. By default, this is true.

#--binary-images iso-hybrid 
## iso|iso-hybrid|netboot|tar|hdd defines the image type to build. By default, for images using syslinux this is set to iso-hybrid to build CD/DVD images that may also be used like hdd images, for non-syslinux images, it defaults to iso.

#--cache true 
##true|false defines globally if any cache should be used at all. Different caches can be controlled through the their own options.

#--distribution bullseye 
##CODENAME defines the distribution of the resulting live system.

#--debian-installer live 
## true|cdrom|netinst|netboot|businesscard|live|false defines which type, if any, of the debian-installer should be included in the resulting binary image. By default, no installer is included. All available flavours except live are the identical configurations used on the installer media produced by regular debian-cd. When live is chosen, the live-installer udeb is included so that debian-installer will behave different than usual - instead of installing the debian system from packages from the medium or the network, it installs the live system to the disk.

#--debian-installer-gui true 
##true|false defines if the debian-installer graphical GTK interface should be true or not. In Debian mode and for most versions of Ubuntu, this option is true, whereas otherwise false, by default.

#--iso-application Peppermint Live
##NAME sets the APPLICATION field in the header of a resulting CD/DVD image and defaults to "Debian Live" in debian mode, and "Ubuntu Live" in ubuntu mode.

#--linux-flavours amd64
##FLAVOUR|"FLAVOURS" sets the kernel flavours to be installed. Note that in case you specify more than that the first will be configured the default kernel that gets booted. Optionally you can use an architecture qualifier, e.g. amd64:amd64. Given an i386 system you can enable amd64 foreign architecture thanks to the commands: "dpkg --add-architecture amd64 ; apt-get update". This enables you to use "686 amd64:amd64" as a linux flavour. The amd64 kernel will be installed alongside the i386's 686 kernel.

##URL sets the location of the derivatives security package mirror that should end up configured in the final image. This defaults to http://security.debian.org/.
#--mode debian

## debian|progress-linux defines a global mode to load project specific defaults. By default this is set to debian.
#--security true 
##true|false defines if the security repositories specified in the security mirror options should be used or not.

#--updates true
##true|false defines if debian updates package archives should be included in the image or not

#--win32-loader false
##true|false defines if win32-loader should be included in the binary image or not.

#set of the structure to be used for the ISO and Live system
#Up above is the manual description of what options I used so far.
lb config \
--archive-areas "main contrib non-free" \
--architectures amd64 \
--apt-recommends true \
--apt-secure false \
--backports true \
--binary-images iso-hybrid \
--binary-filesystem ext4 \
--cache true \
--distribution bullseye \
--linux-flavours amd64 \
--iso-volume PepDeb11 \
--initramfs live-boot \
--firmware-binary true \
--firmware-chroot true \
--security false \
--updates true \
--win32-loader false \

#Not used at the moment##
##Commented..Have not yest decided to use them yet.##
#--checksums sha256 \#
#--clean \#
#--mode debian \#
#--iso-application Peppermint Live \#
#--iso-preparer PeppermintOS-https://peppermintos.com/ \#
#--iso-publisher PeppermintOS-https://forum.peppermintos.com/ #
#--debian-installer live \#
#--debian-installer-distribution bullseye \#
#--debian-installer-gui true  \#
##

# Install the XFCE Desktop 
echo xfce4 > $uchinanchu/fusato/config/package-lists/desktop.list.chroot \
# Install software
echo \
arandr \
arc-theme \
calamares-settings-debian \
calamares \
curl \
dconf-editor \
dkms \
gnome-disk-utility \
gufw \
gvfs-backends \
firmware-linux-nonfree \
firmware-linux \
firmware-misc-nonfree \
firmware-realtek \
firmware-atheros \
firmware-bnx2 \
firmware-bnx2x \
firmware-brcm80211 \
firmware-intelwimax \
firmware-libertas \
firmware-netxen \
firmware-zd1211 \
menulibre \
mugshot \
neofetch \
nemo \
screenfetch \
xfce4-goodies \
yad \
> $uchinanchu/fusato/config/package-lists/packages.list.chroot


#> $uchinanchu/fusato/config/package-lists/packages.list.chroot \#
#this section install all the boot files.....
echo \
efibootmgr \
grub-common \
grub2-common \
grub-efi-amd64 \
grub-efi-amd64-bin \
grub-efi-amd64-signed \
grub-efi-ia32-bin \
grub-pc-bin \
libefiboot1 \
libefivar1 \
mokutil \
shim-helpers-amd64-signed \
shim-signed-common \
shim-unsigned \
> $uchinanchu/fusato/config/package-lists/grubuefi.list.binary \

#Setup the chroot structure
#mkdir -p $uchinanchu/fusato/config/includes.chroot/usr/share/applications#
mkdir -p $uchinanchu/fusato/config/includes.chroot/usr/share/backgrounds
mkdir -p $uchinanchu/fusato/config/includes.chroot/usr/share/desktop-base
mkdir -p $uchinanchu/fusato/config/includes.chroot/usr/share/icons/default
mkdir -p $uchinanchu/fusato/config/includes.chroot/usr/share/themes
mkdir -p $uchinanchu/fusato/config/includes.chroot/usr/share/lightdm
mkdir -p $uchinanchu/fusato/config/includes.chroot/usr/share/peppermint
mkdir -p $uchinanchu/fusato/config/includes.chroot/usr/share/pixmaps
mkdir -p $uchinanchu/fusato/config/includes.chroot/usr/share/plymouth
mkdir -p $uchinanchu/fusato/config/includes.chroot/etc/apt
mkdir -p $uchinanchu/fusato/config/includes.chroot/etc/calamares
mkdir -p $uchinanchu/fusato/config/includes.chroot/etc/default
mkdir -p $uchinanchu/fusato/config/includes.chroot/etc/skel

cp $uchinanchu/pepwallpaper/* $uchinanchu/fusato/config/includes.chroot/usr/share/backgrounds
cp $uchinanchu/pepiconsdf/* $uchinanchu/fusato/config/includes.chroot/usr/share/icons/default
cp $uchinanchu/peppixmaps/*  $uchinanchu/fusato/config/includes.chroot/usr/share/pixmaps
cp $uchinanchu/pepgrub/* $uchinanchu/fusato/config/includes.chroot/etc/default
cp $uchinanchu/pepissue/* $uchinanchu/fusato/config/includes.chroot/etc/
cp $uchinanchu/pepsources/* $uchinanchu/fusato/config/includes.chroot/etc/apt
cp  $uchinanchu/pepcal/calamares/settings.conf $uchinanchu/fusato/config/includes.chroot/etc/calamares
cp -r $uchinanchu/pepdesktopbase/desktop-base $uchinanchu/fusato/config/includes.chroot/usr/share/
cp -r $uchinanchu/pepicons/Flat-Remix-Red-Dark $uchinanchu/fusato/config/includes.chroot/usr/share/icons
cp -r $uchinanchu/pepicons/Obsidian-Red $uchinanchu/fusato/config/includes.chroot/usr/share/icons
cp -r $uchinanchu/peplightdm/lightdm.conf.d $uchinanchu/fusato/config/includes.chroot/usr/share/lightdm
cp -r $uchinanchu/peplightdm/lightdm-gtk-greeter.conf.d $uchinanchu/fusato/config/includes.chroot/usr/share/lightdm
cp -r $uchinanchu/peppermint/peppermint $uchinanchu/fusato/config/includes.chroot/usr/share/
cp -r $uchinanchu/pepplymouth/plymouth $uchinanchu/fusato/config/includes.chroot/usr/share/
cp -r $uchinanchu/peptheme/Arc-Dark $uchinanchu/fusato/config/includes.chroot/usr/share/themes
cp -r $uchinanchu/peptheme/Arc-Red-Dark $uchinanchu/fusato/config/includes.chroot/usr/share/themes
cp -r $uchinanchu/peptheme/Peppermint-10-Red-Dark $uchinanchu/fusato/config/includes.chroot/usr/share/themes
cp -r $uchinanchu/pepcal/calamares/branding $uchinanchu/fusato/config/includes.chroot/etc/calamares
cp -r $uchinanchu/pepcal/calamares/modules $uchinanchu/fusato/config/includes.chroot/etc/calamares


#Set the access permissions to things.#
chmod -R ugo+rw $uchinanchu/fusato 



#build the ISO
lb build
