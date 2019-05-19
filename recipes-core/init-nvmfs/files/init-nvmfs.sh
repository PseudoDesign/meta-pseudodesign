#!/bin/bash
nvm_location="/media/nvm"
device="/dev/mmcblk0p4"

# Attempt to mount the NVM partition
if mount "${nvm_location}"; then
    echo "Successfully mounted existing NVM"
    exit
else
    echo "Unable to mount $nvm_location partition."
fi

# We couldn't mount the partition location.  See if the device exists
if [ ! -f "$device" ]; then
    echo "Device node $device does not exist"
    # TODO: Add partition to table and zero out the device node
else
    echo "Device node $device already exists and should have mounted.  Something is wrong, likely with the filesystem."
    # TODO: Exit with error
fi

# Attempt to mount the NVM partition
if mount "${nvm_location}"; then
    echo "Successfully mounted existing NVM"
    exit
else
    echo "Unable to mount $nvm_location partition."
fi

# We couldn't mount the partiton location.  We already created the partition, so create the filesystem
if mkfs.ext4 "$device"; then
    echo "Successfully made ext4fs"
else
    echo "Failed to make ext4fs"
    # TODO: Exit with failure
fi