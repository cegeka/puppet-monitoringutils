#!/usr/bin/ruby

abort "Sorry: root must run this script" if Process.uid != 0

abort "Cannot find 'cciss_vol_status' command" if ! File.executable?('/usr/bin/cciss_vol_status')

status = %x[cciss_vol_status /dev/cciss/c*d0]

rc = $?.to_i

abort "CCISS disk check failed with:\n#{status}" unless rc == '0'
