#!/usr/bin/ruby
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
        puts "Sorry: there is something wrong with #{mountpoint}"
        exit 1
      end
    end 
  end
}
