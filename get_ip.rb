# InfoBlox IPAM - Get IP Address
# -------------------------------------------------------
# Usage - Method belongs to InfoBlox StateMachine.
# -------------------------------------------------------
#
$evm.log("info", "********* InfoBlox - GetIP STARTED *********")


require 'rest_client'
require 'json'
require 'nokogiri'
require 'ipaddr'

##################################
# Get IP Address                 #
##################################
def getIP(hostname, ipaddress)
  begin
    url = 'https://' + @connection + '/wapi/v1.2.1/record:host'
    content = "\{\"name\":\"#{hostname}\",\"ipv4addrs\":\[\{\"ipv4addr\":\"#{ipaddress}\"\}\],\"configure_for_dns\":false\}"
    $evm.log("info", "API Call: #{url} #{content}")
    dooie = RestClient.post url, content, :content_type => :json, :accept => :json
    return true
  rescue Exception => e
    puts e.inspect
    puts dooie
    return false
  end
end

##################################
# Next Available IP Address      #
##################################
def nextIP(network)
  begin
    $evm.log("info", "my_GetIP --> NextIP on - #{network}")
    url = 'https://' + @connection + '/wapi/v1.2.1/' + network
    dooie = RestClient.post url, :_function => 'next_available_ip', :num => '1'
    doc = Nokogiri::XML(dooie)
    root = doc.root
    nextip = root.xpath("ips/list/value/text()")
    $evm.log("info", "my_GetIP --> NextIP is - #{nextip}")
    return nextip
  rescue Exception => e
    puts e.inspect
    return false
  end
end

##################################
# Fetch Network Ref              #
##################################
def fetchNetworkRef(cdir)
  begin
    $evm.log("info", "my_GetIP --> Network Search - #{cdir}")
    url = 'https://' + @connection + '/wapi/v1.2.1/network'
    dooie = RestClient.get url
    doc = Nokogiri::XML(dooie)
    root = doc.root
    networks = root.xpath("value/_ref/text()")
    networks.each do | a |
      a = a.to_s
      unless a.index(cdir).nil? 
        $evm.log("info", "my_GetIP --> Network Found - #{a}")
        return a 
      end
    end
    return nil
    rescue Exception => e
      puts e.inspect
      return false
  end
end

##################################
# Set netmask                    #
##################################
def netmask(cdir)
  netblock = IPAddr.new(cdir)
  netins =  netblock.inspect
  netmask = netins.match(/(?<=\/)(.*?)(?=\>)/)  
  $evm.log("info", "my_GetIP --> Netmask = #{netmask}")
  return netmask
end

##################################
# Set Options in prov	       #
##################################
def set_prov(prov, hostname, ipaddr, netmask, gateway)
  $evm.log("info", "my_GetIP --> Hostname = #{hostname}")
  $evm.log("info", "my_GetIP --> IP Address =  #{ipaddr}")
  $evm.log("info", "my_GetIP -->  Netmask = #{netmask}")
  $evm.log("info", "my_GetIP -->  Gateway = #{gateway}")
  prov.set_option(:addr_mode, ["static", "Static"])
  prov.set_option(:ip_addr, "#{ipaddr}")
  prov.set_option(:subnet_mask, "#{netmask}")
  prov.set_option(:gateway, "#{gateway}")
  prov.set_option(:vm_target_name, "#{hostname}")
  prov.set_option(:linux_host_name, "#{hostname}")
  prov.set_option(:vm_target_hostname, "#{hostname}")
  prov.set_option(:host_name, "#{hostname}")
  $evm.log("info", "my_GetIP --> #{prov.inspect}")
end

##################################
# Find my environment            #
##################################
def find_environment(environment)
  case environment
    when "qa"
      @gateway = "10.10.1.254"	
      @network = "10.10.1.0/24"
      @dnsdomain = "qa.zone.com"
    when "test"
      @gateway = "10.10.2.254"	
      @network = "10.10.2.0/24"
      @dnsdomain = "test.zone.com"
    when "production"
      @gateway = "10.10.3.254"	
      @network = "10.10.3.0/24"
      @dnsdomain = "prod.zone.com"
    else
      $evm.log("info", "my_GetIP --> Error, environment (#{environment}) is not valid.")
      exit MIQ_OK
  end      
end

#-----------------------MAIN PROGRAM-----------------------#
# Retrieve configuration values from model

username = nil
username ||= $evm.object['user']
password = nil
password ||= $evm.object['passw']
server = nil
server ||= $evm.object['grid_server']

@connection = "#{username}:#{password}@#{server}"

prov = $evm.root["miq_provision"]
$evm.log("info", "#{@method} - Inspecting prov:<#{prov.inspect}>")

$dialog_my_vm_name = ' '
$evm.root.attributes.sort.each { |k, v|
   $evm.log("info","<#{@method}>: #{k}---#{v}")
   if "#{k}" == "dialog_my_vm_name"
     $dialog_my_vm_name = "#{v}"
    $evm.log("info", "<#{@method}>: Found #{$dialog_my_vm_name}")
   end
 }


hostname = "#{$dialog_my_vm_name}"
environment = 'production'
$evm.log("info","my_GetIP --> Hostname = #{hostname}")

find_environment(environment)
vmtargetname = "#{$dialog_my_vm_name}"

netRef = fetchNetworkRef(@network)
nextIPADDR = nextIP(netRef)
result = getIP("#{vmtargetname}.#{@dnsdomain}", nextIPADDR)
if result ==  true
  $evm.log("info", "my_GetIP --> #{vmtargetname}.#{@dnsdomain} with IP Address #{nextIPADDR} created successfully")
  netmask = netmask(@network)
elsif result == false
  $evm.log("info", "my_GetIP --> #{vmtargetname}.#{@dnsdomain} with IP Address #{nextIPADDR} FAILED")
else
  $evm.log("info", "my_GetIP --> unknown error")
end

$evm.log("info", "********* InfoBlox - GetIP COMPLETED *********")
exit MIQ_OK

