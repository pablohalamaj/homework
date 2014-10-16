###################################
#
# EVM Automate Method: clone
#
# Notes: This method is run from "VM Lifecycle - Clone (vm_clone)"
# FQN  : Sample / Methods / clone
#
###################################
begin
  @method = 'clone'
  $evm.log("info", "===== EVM Automate Method: <#{@method}> Started")

  # Log the inbound object
  $evm.log("info", "===========================================")
  process = $evm.object("process")
  $evm.log("info", "Listing Process Attributes:")
  process.attributes.sort.each { |k, v| $evm.log("info", "\t#{k}: #{v}")}
  $evm.log("info", "===========================================")

  # start working
  current = $evm.object
  $evm.log("info", "Got current object")

  vm        = current["vm"]
  $evm.log("info", "Got VM from current object")
  ems       = vm.ext_management_system
  $evm.log("info", "Got EMS from VM")
  host      = vm.host
  $evm.log("info", "Got Host from VM")

  #Find the tagged host(s) with the least number of vms
  tag       = "/managed/function/citrix"
  hosts     = $evm.vmdb(:host).find_tagged_with(:all => tag, :ns => "*")
  $evm.log("info", "Got #{hosts.length} Hosts tagged with #{tag}")
  dest_host = hosts.sort{|a,b| a.vms.length <=> b.vms.length}.first
  $evm.log("info", "Sorted Hosts")
  dest_host = dest_host.name
  $evm.log("info", "Selected Host = #{dest_host}")

  # Find tagged storage(s) with least number of VMs
  storages     = $evm.vmdb(:storage).find_tagged_with(:all=>tag, :ns=>"*")
  $evm.log("info", "Got #{storages.length} Storages tagged with #{tag}")
  dest_storage = storages.sort{|a,b| a.vms.length <=> b.vms.length}.first
  $evm.log("info", "Sorted Storages")
  dest_storage = dest_storage.name
  $evm.log("info", "Selected Storage = #{dest_storage}")

  vm_finder = $evm.vmdb(:vm)
  $evm.log("info", "Got VMFinder Object")
  # Name the VM, takes the vm name passed and adds 1 thru 99 till name does not exist in vmdb
  vm2 = nil
  99.times do |i|
    vm2 = vm.name + "_#{i+1}"
    $evm.log("info", "Trying #{vm2}")
    break unless vm_finder.find_by_name(vm2)
  end
  $evm.log("info", "Selected VM2 = #{vm2}")

  # Build the Perl command using the VMDB information
  cmd  = "nohup perl /usr/lib/vmware-viperl/apps/vm/vmclone.pl"
  cmd += " --url https://#{ems.ipaddress}:443/sdk/vimservice"
  cmd += " --username \"#{ems.authentication_userid}\""
  cmd += " --password \"#{ems.authentication_password}\""
  cmd += " --vmname \"#{vm.name}\""
  cmd += " --vmname_destination \"#{vm2}\""
  cmd += " --datastore \"#{dest_storage}\""
  cmd += " --vmhost \"#{dest_host}\""
  cmd += " &"
  $evm.log("info", "Running: #{cmd}")
  #results = `#{cmd}`
  results = system(cmd)
  #Continue the Trap error

  #
  # Exit method
  #
  $evm.log("info", "===== EVM Automate Method: <#{@method}> Ended")
  exit MIQ_OK

  #
  # Set Ruby rescue behavior
  #
rescue => err
  $evm.log("error", "<#{@method}>: [#{err}]\n#{err.backtrace.join("\n")}")
  exit MIQ_STOP
end
