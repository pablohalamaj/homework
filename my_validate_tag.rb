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


  #Find the tags of the vm 
  unless vm.tags.nil?
  tag           = "cloned"
  vm.tags.sort.each {|tag_element| tag_text = tag_element.split('/');
    $evm.log("info", "#{@method} - VM:<#{vm.name}> Category:<#{tag_text.first.inspect}> Tag:<#{tag_text.last.inspect}>")
    first_tag = tag_text.first
    second_tag = tag_text.second
    if first_tag == "cloned"
      $evm.log("error", "<#{@method}>: VM Tagged with <#{tag_text.first.inspect}> y <#{tag_text.second.inspect}>")
        exit MIQ_STOP
    else
      $evm.log("")
    end }
   end


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
