#!/usr/local/bin/ruby -w
# Usage: send_sms.rb 'host_type' 'text_string'
#
# where host_type is one of 'HUGHES', 'NERA' or 'TT'
# and text_string is the text of the message to be sent
#
# dial_number is set to a default in bgan.rb but can be changed
# below if desired

require 'bgan'
      
host_type = ARGV[0]
text_string = ARGV[1]
            
bgan = BGAN.new(host_type)
#bgan.dial_number="+870772133573"

#puts bgan.dial_number
bgan.text_send(text_string)
#bgan.pdu_send(text_string)

