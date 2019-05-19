#!/bin/bash
nvm_location="/media/nvm"
device_node="/dev/mmcblk0"
partition_number="4"
partition_node="${device_node}p${partition_number}"
previous_partition_number=$(($partition_number-1))
previous_partition_node="${device_node}p${previous_partition_number}"

create_partition () {

# Start by getting the last sector of the previous partition
last_sector=$(fdisk -l $device_node | awk -v str="$previous_partition_node" '$0~str{print $3}')

# Feed input into fdisk to create the partition
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${device_node}
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  ${partition_number} # partition number 
  $(($last_sector+1))  # Start just after the end of the previous partition
    # default - extend to the end of the disk
  w # write the partition table
  q # and we're done
EOF
}

# Exit if the partition is already mounted
if df -h | grep -q "$nvm_location"; then
    echo "NVM partition is already mounted"
    exit 0
else
    echo "NVM partition is not mounted"
fi

mkdir -p $nvm_location

# Attempt to mount the NVM partition (it needs to exist in fstab)
if mount "${nvm_location}"; then
    echo "Successfully mounted existing NVM"
    exit 0
else
    echo "Unable to mount $nvm_location partition."
fi

# We couldn't mount the partition location.  See if the partition_node exists
if [ ! -f "$partition_node" ]; then
    echo "Device node $partition_node does not exist"
    # Add partition to table
    create_partition
    # TODO: zero out the node
else
    echo "Device node $partition_node already exists and should have mounted.  Something is wrong, likely with the filesystem."
    exit 1
fi

# Attempt to mount the NVM partition
if mount "${nvm_location}"; then
    echo "Successfully mounted existing NVM"
    exit 0
else
    echo "Unable to mount $nvm_location partition."
fi

# We couldn't mount the partiton location.  We already created the partition, so create the filesystem
if mkfs.ext4 "$partition_node"; then
    echo "Successfully made ext4fs"
else
    echo "Failed to make ext4fs"
    # TODO: Exit with failure
fi

# Try to mount again; return the exit code
mount "${nvm_location}"