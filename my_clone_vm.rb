###################################
#
# EVM Automate Method: my_clone_vm
#
# Notes:This method is used to clone a VM with the exact same parameters as the origin
#	but the resulting VM will have the "cloned" Tag.
#
###################################

@method = 'my_clone_vm'
$evm.log("info", "===== EVM Automate Method: <#{@method}> Started")

#
#            Automate Method
#
#
#            Method Code Goes here
#

#!/usr/bin/ruby
require 'rubygems'
require 'rest_client'

vm = $evm.root['vm']
ext_management_system = vm.ext_management_system
ems_cluster = vm.ems_cluster

$evm.log("info", "<#{@method}>: VM Name - #{vm.name}")
$evm.log("info", "<#{@method}>: RHEVM Name - #{ext_management_system.name}")
$evm.log("info", "<#{@method}>: Cluster Name - #{ems_cluster.name}")

$dialog_my_vm_name = ' '
$evm.root.attributes.sort.each { |k, v| 
   $evm.log("info","<#{@method}>: #{k}---#{v}") 
   if "#{k}" == "dialog_my_vm_name" 
     $dialog_my_vm_name = "#{v}"
    $evm.log("info", "<#{@method}>: Found #{$dialog_my_vm_name}")
   end
 }    

if "#{$dialog_my_vm_name}" == "#{vm.name}"
	$evm.log("error", "<#{@method}>: Nueva VM con mismo nombre que anterior <#{$dialog_my_vm_name}> y <#{vm.name}>")
        exit MIQ_STOP
end


rhevm = "https://#{ext_management_system.ipaddress}/api/vms"
rhevadmin = 'admin@internal'
rhevadminpass = 'r3dh@t1!'
resource = RestClient::Resource.new(rhevm, :user => rhevadmin, :password => rhevadminpass)

  $evm.log("info", "<#{@method}>: ******** <vm><name>#{dialog_vm_prefix}</name><cluster><name>#{ems_cluster.name}</name></cluster><template><name>#{vm.name}</name></template><memory>#{vm.hardware.memory_cpu}</memory><os><boot dev='hd'/></os></vm>****")
  cloneTemplate = resource.post "<vm><name>#{dialog_vm_prefix}</name><cluster><name>#{ems_cluster.name}</name></cluster><template><name>#{vm.name}</name></template><memory>#{vm.hardware.memory_cpu}</memory><os><boot dev='hd'/></os></vm>", :content_type => 'application/xml', :accept => 'application/xml'
  $evm.log("info", "Result - #{cloneTemplate}")



#
#
#
$evm.log("info", "Automate Method Ended")
exit MIQ_OK

