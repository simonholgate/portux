#!/usr/local/bin/ruby
# Testing the PDP context for a network connection
      require 'net/telnet'
      tn = Net::Telnet.new('Host' => '192.168.0.1', 
# Port 5454 for T&T
      			   'Port' => 5454)     {|str| print str }
      tn.cmd(	'String'	=>	"at+cfun=?", 
      		'Match'		=>	/OK|ERROR/,
      		'Timeout'	=>	2)  	{|str| print str }
      tn.cmd(	'String'	=>	"at+cfun=1,1", 
      		'Match'		=>	/OK|ERROR/,
      		'Timeout'	=>	20)  	{|str| print str }
      tn.close
