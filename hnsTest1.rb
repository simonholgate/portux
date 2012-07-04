# Sample code from Programing Ruby, page 704
      require 'net/telnet'
      tn = Net::Telnet.new('Host' => '192.168.128.100', 'Port' => 1829)     {|str| print str }
#      tn.login("guest", "secret")  {|str| print str }
#    tn.login("guest", "secret")  {|str| print str.gsub(/testuser/, 'guest').gsub(/\n\s*\n/, "\n").gsub(/\A[\s\n]+/, "") }
#      tn.cmd("at_ihwlan?")               {|str| print str }
      tn.cmd(	'String'	=>	"at+cpbs?", 
      		'Match'		=>	/OK/,
      		'Timeout'	=>	2)  	{|str| print str }
      tn.cmd(	'String'	=>	"at+cgatt?", 
      		'Match'		=>	/OK/,
      		'Timeout'	=>	2)  	{|str| print str }
      tn.cmd(	'String'	=>	"at+cgcont=?", 
      		'Match'		=>	/OK/,
      		'Timeout'	=>	2)  	{|str| print str }
      tn.cmd(	'String'	=>	"at+cgcont?,+cgdscont?", 
      		'Match'		=>	/OK/,
      		'Timeout'	=>	2)  	{|str| print str }
      tn.close
