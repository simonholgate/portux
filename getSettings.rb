# Testing the PDP context for a network connection
      require 'net/telnet'
      tn = Net::Telnet.new('Host' => '192.168.128.100', 
# Port 1829 for Hughes 
      			   'Port' => 1829)     {|str| print str }
# Disable unsolicited signal strength
      tn.cmd(	'String'	=>	"at_isig=0", 
      		'Match'		=>	/OK|ERROR/,
      		'Timeout'	=>	2)  	{|str| print str }
# Get signal strength
      tn.cmd(	'String'	=>	"at_isig?", 
      		'Match'		=>	/OK/,
      		'Timeout'	=>	2)  	{|str| print str }
# Get battery charge
      tn.cmd(	'String'	=>	"at+cbc?", 
      		'Match'		=>	/OK|ERROR/,
      		'Timeout'	=>	2)  	{|str| print str }
# Get GPRS registration status
      tn.cmd(	'String'	=>	"at+cgreg?", 
      		'Match'		=>	/OK|ERROR/,
      		'Timeout'	=>	2)  	{|str| print str }
# Get GPS data
      tn.cmd(	'String'	=>	"at_igps?", 
      		'Match'		=>	/OK|ERROR/,
      		'Timeout'	=>	20)  	{|str| print str }
# Get temperature data
      tn.cmd(	'String'	=>	"at_itemp?", 
      		'Match'		=>	/OK|ERROR/,
      		'Timeout'	=>	20)  	{|str| print str }
      tn.close
