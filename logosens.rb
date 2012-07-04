#!/usr/local/bin/ruby 

# Script to talk to an OTT Logosens logger over a serial connection

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
### Class definition for LogoSens
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class LSens

@@dev = ''

# Which instance variables can be read?
  attr_reader :dev

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Class method definitions
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def LSens.initialise

# Set up the sensor interface
  begin
# setup units on sensor
    unit_str = IO.popen("echo 'A' > /dev/ttyS#{@@dev}", "w+")
    unit_str.close_write
    STDOUT.puts "Response: #{unit_str.gets}"
    unit_str.close
  rescue StandardError => bang
    print "Error in writing initialising logger: " + bang + "\n"
    raise
  end

end

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Instance method definitions
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def initialize(dev)
# Class variable
  @@dev = dev
end

# Setter function for dial_number
def dial_number=(new_dial_number)
  @dial_number = new_dial_number
end

# Setter function for service_centre
def service_centre=(new_serive_centre)
  @service_centre = new_service_centre
end

end

require 'read_kalesto.rb'
