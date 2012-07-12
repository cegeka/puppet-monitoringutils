#!/usr/bin/ruby

# Local variables
devices = []
failed_mountpoints = []
fstypes = [ 'ext3', 'ext4' ]

# Check for root priv blkid won't run without
abort "Sorry: root must run this script" if Process.uid != 0

# Get EXT devices
blkid = fstypes.each { |type|
  devices + %x[blkid -o device -t TYPE=#{type}].split
}

blkid.each { |device|
  mountpoint = %x[mount | grep \"^#{device} \"].split[2]
  unless mountpoint.nil?
    if Dir[mountpoint]
      return_value = %x[touch -a #{mountpoint}]
      result = $?.to_i
      if result > 0
        failed_mountpoints << mountpoint
      end
    end
  end
}

abort "Filesystem readonly healthcheck FAILED for the following filesystems: #{failed_mountpoints.join(' ')}" if ! failed_mountpoints.empty?
