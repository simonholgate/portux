#!/usr/local/bin/ruby
# Test to try out SMS messaging
#
# Usage: smsSendText.rb 'host_type' 'text_string'
#
# where host_type is one of 'HUGHES', 'NERA' or 'TT'
# and text_string is the text of the message to be sent
#
      require 'net/telnet'

      host_type = ARGV[0]
      case host_type
      when "HUGHES"
        host_ip = '192.168.128.100'
	port_number = 1829
      when "NERA"
        host_ip = '192.168.0.1'
	port_number = 9998
      when "TT"
        host_ip = '192.168.0.1'
	port_number = 5454
      else
        print "Unknown host type: #{host_type}"
      end

      tn = Net::Telnet.new(     'Host' => host_ip,
                                'Port' => port_number)     {|str| print str }

      tn.cmd(   'String'        =>      "at+cmgf=1",
                'Match'         =>      /OK/,
                'Timeout'       =>      2)      {|str| print str }

      tn.cmd(   'String'        =>      %/at+csca="+870772001799"/,
                'Match'         =>      /OK/,
                'Timeout'       =>      2)      {|str| print str }
      tn.cmd(   'String'        =>      %/at+cmgs="+447970456789"/,
                'Match'         =>      />/,
                'Timeout'       =>      20)      {|str| print str }

      data_string = ""
      data_string << ARGV[1]
# Append a Ctrl-z to the string to finish...
      data_string << 26
#      print data_string
      tn.cmd(   'String'        =>      data_string,
                'Match'         =>      /OK/,
                'Timeout'       =>      30)      {|str| print str }
      tn.close
