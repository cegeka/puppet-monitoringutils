#!/usr/bin/ruby

# Local variables
error = 0
failed_mountpoints = []

# Check for root priv blkid won't run without
uid = Process.uid
if uid != 0
  puts "Sorry: Root must run this script"
  exit 1
end

# Get EXT devices
blkid = %x[blkid -o device]
blkid = blkid.split
blkid.each { |device|
  mountpoint = %x[grep #{device} /proc/mounts].split[1]
  unless mountpoint.nil?
    if Dir[mountpoint]
      return_value = %x[touch -a #{mountpoint}]
      result = $?.to_i
      if result > 0
        error = 1
        failed_mountpoints << mountpoint
			end
    end
  end
}

if error >= 1
  puts "Filesystem readonly-health tests FAILED for the following filesystems: #{failed_mountpoints.join(' ')}"
  exit 1
else
  exit 0
end
