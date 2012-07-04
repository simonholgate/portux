#!/usr/local/bin/ruby
# Testing the PDP context for a network connection
      require 'net/telnet'
      tn = Net::Telnet.new('Host' => '192.168.0.1', 
# Port 9998 for NERA
      			   'Port' => 9998)     {|str| print str }
      tn.cmd(	'String'	=>	"at+cfun=?", 
      		'Match'		=>	/OK|ERROR/,
      		'Timeout'	=>	2)  	{|str| print str }
      tn.cmd(	'String'	=>	"at+cfun=1,1", 
      		'Match'		=>	/OK|ERROR/,
      		'Timeout'	=>	20)  	{|str| print str }
      tn.close
