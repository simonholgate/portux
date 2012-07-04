#!/usr/local/bin/ruby
# Sample code from Programing Ruby, page 704
      require 'net/telnet'
      tn = Net::Telnet.new('Host'       => '192.168.0.1',
			   'Port'       => 37,
                           'Timeout'    => 60,
                           'Telnetmode' => false)
      atomic_time = tn.recv(4).unpack('N')[0]
#      puts "Atomic time: " + Time.at(atomic_time - 2208988800).to_s
      puts "Atomic time: " + Time.at(atomic_time - 2208988802).to_s
      puts "Local time:  " + Time.now.to_s
    tn.close
