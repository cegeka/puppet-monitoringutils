#!/bin/sh

# Local variables
error=0
passed_mountpoints=()
failed_mountpoints=()

# Check for root priv blkid won't run without
if [[ $(id -u) -ne 0 ]]; then
  printf "Sorry: Root must run this script\n"
  exit 1
fi

# Get EXT devices
blkid=$(blkid -o device)
for device in ${blkid}; do
  mountpoint=$(grep ${device} /proc/mounts | cut -d" " -f2)
  if [[ -d ${mountpoint} ]]; then
    $(touch -a ${mountpoint})
    result=$?
    if [[ $result -gt 0 ]]; then
      error=1
      failed_mountpoints=( "${failed_mountpoints[*]}" "${mountpoint}" )
    else
      passed_mountpoints=( "${passed_mountpoints[*]}" "${mountpoint}" )
    fi
  fi
done

if [[ ${error} == 1 ]]; then
  printf "Filesystem readonly-health tests FAILED for the following filesystems: ${failed_mountpoints[*]} \n"
  exit 1
else
  printf "Filesystem readonly-health tests PASSED for the following filesystems: ${passed_mountpoints[*]} \n"
  exit 0
fi
