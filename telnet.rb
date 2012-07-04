# Sample code from Programing Ruby, page 704
      require 'net/telnet'
      tn = Net::Telnet.new('Host' => '192.168.0.1')     {|str| print str.gsub(/\n\s*\n/, "\n").gsub(/^Trying.*\n/, "") }
#      tn.login("guest", "secret")  {|str| print str }
    tn.login("guest", "secret")  {|str| print str.gsub(/testuser/, 'guest').gsub(/\n\s*\n/, "\n").gsub(/\A[\s\n]+/, "") }
      tn.cmd("date")               {|str| print str }
      tn.close
