
begin
  @method = 'my_tag_vm'
  $evm.log("info", "===== EVM Automate Method: <#{@method}> Started")

  # Turn of debugging
  @debug = true

  # Log the inbound object
  $evm.log("info", "===========================================")
  process = $evm.object("process")
  $evm.log("info", "Listing Process Attributes:")
  process.attributes.sort.each { |k, v| $evm.log("info", "\t#{k}: #{v}")} if @debug
  $evm.log("info", "===========================================")
  original_vm = $evm.root['vm']
  $evm.log("info","<#{@method}> Source VM #{original_vm.name}") if @debug


  ## Got the provided Name on the dialog
  $dialog_my_vm_name = ' '
  $evm.root.attributes.sort.each { |k, v|
        $evm.log("info","<#{@method}>: #{k}---#{v}")
        if "#{k}" == "dialog_my_vm_name"
                $dialog_my_vm_name = "#{v}"
        $evm.log("info", "<#{@method}>: Found #{$dialog_my_vm_name}")
        end
  }


  vm = $evm.vmdb('vm').find_by_name("#{dialog_my_vm_name}")
  $evm.log("info", "Got VM from root object")
  $evm.log("info","Inspecting vm: #{vm.inspect}") if @debug

  vm.tag_assign("cloned/true")
  vm.owner=(original_vm.owner)
  $evm.log("info","<#{@method}> Source OWNER #{original_vm.owner}") if @debug
  $evm.log("info","<#{@method}> New VM #{vm.name} owner #{vm.owner}") if @debug
  
  #
  # Exit method
  #
  $evm.log("info", "<#{@method}>--===== #{vm.name} not tagged with tag cloned ========")
  $evm.log("info", "===== EVM Automate Method: <#{@method}> Ended")
  exit MIQ_OK

  rescue => err
  $evm.log("error", "<#{@method}>: [#{err}]\n#{err.backtrace.join("\n")}")
  exit MIQ_STOP
end
