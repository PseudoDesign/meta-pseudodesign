# meta-pseudodesign

## Classes

### sdcard_image-rpi-dualboot

Partitions an RPI SD card per the following schema.  The remaining space on the SD card is allocated to NVM via the [nvmfs recipe](#nvmfs).  The partition table format is outlined in the [bbclass file](./classes/sdcard_image-rpi-dualboot.bbclass).

To generate this image, add the following to your build's `local.conf`.

```bash
# Use the rpi dualboot image
IMAGE_CLASSES += " sdcard_image-rpi-dualboot "
IMAGE_FSTYPES += " rpi-dualboot-sdimg "
```

## Recipes

### recipes-core

#### base-files (append)

Adds the logo ascii image to `/etc/issue`.

#### nvmfs

Fills the remainder of the main flash memory device with an NVM partition at mmcblkNp4.
