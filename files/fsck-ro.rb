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
    fsentry = line.split(%r{\s+})

    @device = fsentry[0]
    @mountpoint = fsentry[1]
    @fstype = fsentry[2]
    @options = fsentry[3].split(',')
    @dump = fsentry[4]
    @pass = fsentry[5]
  end

  def ro?
    @options.include?('ro')
  end
end

def get_ro_mounts(file)
  ro_array = []

  File.foreach(file) do |line|
    # skip comments and empty lines
    next if line =~ /^\s*(#.*|)$/

    fsentry = FSEntry.new(line)

    if FSTYPES.include?(fsentry.fstype)
      ro_array << fsentry.mountpoint if fsentry.ro?
    end
  end

  ro_array
end

failed_mounts = get_ro_mounts('/proc/mounts') - get_ro_mounts('/etc/fstab')

abort "Filesystem readonly check FAILED for: #{failed_mounts.join(' ')}" if ! failed_mounts.empty?
