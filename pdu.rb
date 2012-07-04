#!/usr/local/bin/ruby
# Constructing PDU format SMS messages for use with BGAN (esp. NERA)
# All information taken from http://www.dreamfabric.com/sms/

# Simon Holgate 18/10/06 (simonh@pol.ac.uk)

# NB rewrite as classes and methods. Script will take 2 arguments, the destination phone number and the string to send

require 'net/telnet'

string_to_send = "hellohello"
# Temporary array
b = Array.new
encoded_string = Array.new
# Counters
i = 0
j = 0

string_to_send.each_byte { |d|
  b[i] = d.to_s(2)
  if j>0 then
    encoded_string[i-1] = b[i][(7-j)..6]<<b[i-1]
    encoded_string[i-1] = (encoded_string[i-1].to_i(2)).to_s(16)
    if j>=7
      j=0
      next
    end
    b[i] = b[i][0..(6-j)]
  end
  i=i+1
  j=j+1

}
encoded_string[i] = b[i-1]
encoded_string[i] = (encoded_string[i].to_i(2)).to_s(16)

# Now construct the PDU message.
#
# Length of SMSC information. Here the length is 0, which means that the SMSC stored in the phone should be used. Note: This octet is optional. On some phones this octet should be omitted! (Using the SMSC stored in phone is thus implicit)
pdu_message="00"
# First octet of SMS-SUBMIT
pdu_message << "11"
# TP-Message-Reference.
# The "00" value here lets the phone set the message reference number itself.
pdu_message << "00"
# Address-Length. Length of the sender number (0C hex = 12 dec)
pdu_message << "OC"
# Type-of-Address. (91 indicates international format of the phone number).
pdu_message << "91"
# The phone number in semi octets (e.g. 46708251358). If the length of the phone number is odd (11), then a trailing F has been added, as if the phone number were "46708251358F". Using the unknown format (i.e. the Type-of-Address 81 instead of 91) would yield the phone number octet sequence 7080523185 (0708251358). Note that this has the length 10 (A), which is even.
# We'll send to +447905456789 which has 12 characters and is even
phone_number = "447905456789"
if (phone_number.length)%2 != 0 then
  phone_number<<"F"
end
0.step((phone_number.length)-1,2) {|x|
  i = phone_number[x]
  j = phone_number[x+1]
  phone_number[x] = j
  phone_number[x+1] = i
}
pdu_message << phone_number
# TP-PID. Protocol identifier
pdu_message << "00"
# TP-DCS. Data coding scheme.This message is coded according to the 7bit default alphabet. Having "04" instead of "00" here, would indicate that the TP-User-Data field of this message should be interpreted as 8bit rather than 7bit (used in e.g. smart messaging, OTA provisioning etc).
pdu_message << "00"
# TP-Validity-Period. "AA" means 4 days. Note: This octet is optional, see bits 4 and 3 of the first octet
pdu_message << "AA"
# TP-User-Data-Length. Length of message. The TP-DCS field indicated 7-bit data, so the length here is the number of septets (10). If the TP-DCS field were set to 8-bit data or Unicode, the length would be the number of octets.
pdu_message << sprintf("%02x",string_to_send.length).upcase
# TP-User-Data. These octets represent the message "hellohello". How to do the transformation from 7bit septets into octets is shown here
pdu_message << encoded_string.to_s.upcase
printf pdu_message
# Add Ctrl-z to finish
pdu_message << 26

# Send message
# Connect to NERA
tn = Net::Telnet.new('Host' => '192.168.0.1',
                     'Port' => 9998)     {|str| print str }
#                     'Port' => 5454)     {|str| print str }
# Set PDU mode
tn.cmd(   'String'        =>      "at+cmgf=0",
          'Match'         =>      /OK/,
          'Timeout'       =>      2)      {|str| print str }
# Check if modem supports SMS commands
tn.cmd(   'String'        =>      "AT+CSMS=0",
          'Match'         =>      /OK/,
          'Timeout'       =>      2)      {|str| print str }
# Send message, 23 octets (excluding the two initial zeros)
tn.cmd(   'String'        =>      "AT+CMGS=" << ((pdu_message.length/2)-1).to_s,
          'Match'         =>      />/,
          'Timeout'       =>      2)      {|str| print str }
# Write message
tn.cmd(   'String'        =>      pdu_message,
          'Match'         =>      /OK/,
          'Timeout'       =>      30)      {|str| print str }
# End session
tn.close
