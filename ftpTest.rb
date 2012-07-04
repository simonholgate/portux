#!/usr/local/bin/ruby
require 'net/ftp'
ftp = Net::FTP.new('ftp.somewhere.com')
ftp.login
files = ftp.chdir('pub/')
files = ftp.list('g*')
ftp.getbinaryfile('ex1.txt', 'example.txt', 1024)
ftp.close


