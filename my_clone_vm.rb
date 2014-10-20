###################################
#
# EVM Automate Method: my_clone_vm
#
# Notes:This method is used to clone a VM with the exact same parameters as the origin
#	but the resulting VM will have the "cloned" Tag.
#
###################################

# Get vm from root object
#   vm = $evm.root['vm']
#     raise "#{@method} - VM object not found" if vm.nil?
#
#       # Get root attributes passed in from the service dialog
#         vram   = $evm.root['vram'].to_i
#
