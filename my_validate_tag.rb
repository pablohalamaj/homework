$evm.log("info", "********* my_validate_tag - GetIP STARTED *********")

begin
  @method = 'my_validate_tag'
  $evm.log("info", "===== EVM Automate Method: <#{@method}> Started")

  # Turn of debugging
  @debug = true

  # Log the inbound object
  $evm.log("info", "===========================================")
  process = $evm.object("process")
  $evm.log("info", "Listing Process Attributes:")
  process.attributes.sort.each { |k, v| $evm.log("info", "\t#{k}: #{v}")} if @debug
  $evm.log("info", "===========================================")

  vm = $evm.root['vm']
  $evm.log("info", "Got VM from root object")
  $evm.log("info","Inspecting vm: #{vm.inspect}") if @debug

  ems       = vm.ext_management_system
  $evm.log("info", "Got EMS <#{ems.name}> from VM <#{vm.name}>")
  $evm.log("info","Inspecting ems: #{ems.inspect}") if @debug

  host      = vm.host
  $evm.log("info", "Got Host <#{host.name}> from VM <#{vm.name}>")
  $evm.log("info","Inspecting host: #{host.inspect}") if @debug

  tags = vm.tags
 
  $evm.log("info", "#{@method} Template Tags - #{vm.tags}")
 
  tags.each  do  |t|
   s = t.split("/")
    if s[0] == 'cloned'
      if s[1] == 'true'
        $evm.log("error", "<#{@method}>: VM Tagged with <#{s[0]}> y <#{s[1]}>")
        exit MIQ_ABORT
      end
    end
  end
  
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

