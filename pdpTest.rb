# Testing the PDP context for a network connection
      require 'net/telnet'
      tn = Net::Telnet.new('Host' => '192.168.128.100', 
# Port 1829 for Hughes 
      			   'Port' => 1829)     {|str| print str }
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
