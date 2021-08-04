# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers
# blu_spark changes by eng.stk

## AnyKernel setup
# begin properties
properties() { '
kernel.string=*** blu_spark kernel for OnePlus 5/T ***
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=OnePlus5
device.name2=cheeseburger
device.name3=OnePlus5T
device.name4=dumpling
supported.versions=10
'; } # end properties

# shell variables
block=boot;
is_slot_device=0;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## Trim partitions
$bin/busybox fstrim -v /cache;
$bin/busybox fstrim -v /data;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 750 750 $ramdisk/*;

## AnyKernel install
dump_boot;

write_boot;

## end install

