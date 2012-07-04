#!/usr/local/bin/ruby
# Test to try out SMS messaging on the TT
      require 'net/telnet'
      tn = Net::Telnet.new(     'Host' => '192.168.0.1',
                                'Port' => 5454)     {|str| print str }

      tn.cmd(   'String'        =>      "at+cmgf=1",
                'Match'         =>      /OK/,
                'Timeout'       =>      2)      {|str| print str }

      tn.cmd(   'String'        =>      %/at+csca="+870772001799"\r/,
                'Match'         =>      /OK/,
                'Timeout'       =>      2)      {|str| print str }
      tn.cmd(   'String'        =>      %/at+cmgs="+870772133573"/,
                'Match'         =>      />/,
                'Timeout'       =>      20)      {|str| print str }
      data_string = ""
      data_string << ARGV[0]
# Append a Ctrl-z to the string to finish...
      data_string << 26
      data_string << "\r"
#      print data_string
      tn.cmd(   'String'        =>      data_string,
                'Match'         =>      /ERROR/,
                'Timeout'       =>      30)      {|str| print str }
      tn.close
