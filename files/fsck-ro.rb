#!/usr/bin/ruby

# Configuration
FSTYPES = [ 'ext3', 'ext4' ]

# Local variables
failed_mounts = []

class FSEntry

  attr_reader :device
  attr_reader :mountpoint
  attr_reader :fstype
  attr_reader :options
  attr_reader :dump
  attr_reader :pass

  def initialize(line)
    array = line.split(%r{\s+})

    @device = array[0]
    @mountpoint = array[1]
    @fstype = array[2]
    @options = array[3].split(',')
    @dump = array[4]
    @pass = array[5]
  end
end

def get_ro_mounts(file)
  ro_array = []

  File.foreach(file) do |line|
    # skip comments
    next if line =~ /^\s*#/
    # parse line if it's not empty
    fsentry = FSEntry.new(line) unless line =~ /^$/

    if FSTYPES.include?(fsentry.fstype)
      if fsentry.options.include?('ro')
        ro_array << fsentry.mountpoint
      end
    end
  end

  return ro_array
end

failed_mounts = get_ro_mounts('/proc/mounts') - get_ro_mounts('/etc/fstab')

abort "Filesystem readonly check FAILED for: #{failed_mounts.join(' ')}" if ! failed_mounts.empty?
