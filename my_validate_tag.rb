$evm.log("info", "********* my_validate_tag - GetIP STARTED *********")

begin
  @method = 'my_validate_tag'
  $evm.log("info", "===== EVM Automate Method: <#{@method}> Started")

  # Log the inbound object
  $evm.log("info", "<#{@method}>--===========================================")
  process = $evm.object("process")
  $evm.log("info", "<#{@method}>--Listing Process Attributes:")
  process.attributes.sort.each { |k, v| $evm.log("info", "\t#{k}: #{v}")}
  $evm.log("info", "<#{@method}>--===========================================")

  # start working
  current = $evm.object
  $evm.log("info", "<#{@method}>--Got current object")

  vm        = current["vm"]
  $evm.log("info", "<#{@method}>--Got VM #{vm} from current object")
  ems       = vm.ext_management_system
  $evm.log("info", "Got EMS from VM")
  host      = vm.host
  $evm.log("info", "Got Host from VM")

  #Find the tags of the vm  with the least number of vms
  tagged_vm	= nil
  tag		= "cloned"
  tagged_vm     = $evm.vmdb(:vm).tagged_with(:Custom_Tags,"cloned")
  $evm.log("info", "<#{@method}>--Got #{tagged_vm} Hosts tagged with #{tag}")

  if tagged_vm == nil
	  #
	  # Exit method
	  #
	  $evm.log("info", "<#{@method}>--===== #{vm.name} tagged with tag #{tag} =========")
	  $evm.log("info", "===== EVM Automate Method: <#{@method}> Ended")
	  exit MIQ_OK
  else
  #
  # Set Ruby rescue behavior
  #
	$evm.log("info", "<#{@method}>--===== #{vm.name} not tagged with tag #{tag} =========")
        $evm.log("info", "===== EVM Automate Method: <#{@method}> Ended")
	exit MIQ_STOP
  end

	rescue => err
        $evm.log("error", "<#{@method}>: [#{err}]\n#{err.backtrace.join("\n")}")
        exit MIQ_STOP
end
