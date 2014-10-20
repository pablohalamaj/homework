###################################
#
# EVM Automate Method: InspectMe
#
# Notes: Dump the objects in storage to the automation.log
#
###################################
begin
  @method = 'InspectMe'
  $evm.log("info", "#{@method} - EVM Automate Method Started")

  # Turn of verbose logging
  @debug = true


  #########################
  #
  # Method: dumpRoot
  # Description: Dump Root information
  #
  ##########################
  def dumpRoot
    $evm.log("info", "#{@method} - Root:<$evm.root> Begin Attributes")
    $evm.root.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - Root:<$evm.root> Attributes - #{k}: #{v}")}
    $evm.log("info", "#{@method} - Root:<$evm.root> End Attributes")
    $evm.log("info", "")
  end


  #########################
  #
  # Method: dumpServer
  # Inputs: $evm.root['miq_server']
  # Description: Dump MIQ Server information
  #
  ##########################
  def dumpServer
    $evm.log("info","#{@method} - Server:<#{$evm.root['miq_server'].name}> Begin Attributes")
    $evm.root['miq_server'].attributes.sort.each { |k, v| $evm.log("info", "#{@method} - Server:<#{$evm.root['miq_server'].name}> Attributes - #{k}: #{v.inspect}")}
    $evm.log("info","#{@method} - Server:<#{$evm.root['miq_server'].name}> End Attributes")
    $evm.log("info", "")
  end


  #########################
  #
  # Method: dumpUser
  # Inputs: $evm.root['user']
  # Description: Dump User information
  #
  ##########################
  def dumpUser
    user = $evm.root['user']
    unless user.nil?
      $evm.log("info","#{@method} - User:<#{user.name}> Begin Attributes [user.attributes]")
      user.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - User:<#{user.name}> Attributes - #{k}: #{v.inspect}")}
      $evm.log("info","#{@method} - User:<#{user.name}> End Attributes [user.attributes]")
      $evm.log("info", "")

      $evm.log("info","#{@method} - User:<#{user.name}> Begin Associations [user.associations]")
      user.associations.sort.each { |assc| $evm.log("info", "#{@method} - User:<#{user.name}> Associations - #{assc}")}
      $evm.log("info","#{@method} - User:<#{user.name}> End Associations [user.associations]")
      $evm.log("info","")

      unless user.tags.nil?
        $evm.log("info","#{@method} - User:<#{user.name}> Begin Tags [user.tags]")
        user.tags.sort.each { |tag_element| tag_text = tag_element.split('/'); $evm.log("info", "#{@method} - User:<#{user.name}> Category:<#{tag_text.first.inspect}> Tag:<#{tag_text.last.inspect}>")}
        $evm.log("info","#{@method} - User:<#{user.name}> End Tags [user.tags]")
        $evm.log("info","")
      end

      #$evm.log("info","#{@method} - User:<#{user.name}> Begin Virtual Columns [user.virtual_column_names]")
      #user.virtual_column_names.sort.each { |vcn| $evm.log("info", "#{@method} - User:<#{user.name}> Virtual Columns - #{vcn}: #{user.send(vcn).inspect}")}
      #$evm.log("info","#{@method} - User:<#{user.name}> End Virtual Columns [user.virtual_column_names]")
      #$evm.log("info","")
    end
  end


  #########################
  #
  # Method: dumpGroup
  # Inputs: $evm.root['user'].miq_group
  # Description: Dump User's Group information
  #
  ##########################
  def dumpGroup
    user = $evm.root['user']
    unless user.nil?
      miq_group = user.miq_group
      unless miq_group.nil?
        $evm.log("info","#{@method} - Group:<#{miq_group.description}> Begin Attributes [miq_group.attributes]")
        miq_group.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - Group:<#{miq_group.description}> Attributes - #{k}: #{v.inspect}")} unless $evm.root['user'].miq_group.nil?
        $evm.log("info","#{@method} - Group:<#{miq_group.description}> End Attributes [miq_group.attributes]")
        $evm.log("info", "")

        $evm.log("info","#{@method} - Group:<#{miq_group.description}> Begin Associations [miq_group.associations]")
        miq_group.associations.sort.each { |assc| $evm.log("info", "#{@method} - Group:<#{miq_group.description}> Associations - #{assc}")}
        $evm.log("info","#{@method} - Group:<#{miq_group.description}> End Associations [miq_group.associations]")
        $evm.log("info","")

        unless miq_group.tags.nil?
          $evm.log("info","#{@method} - Group:<#{miq_group.description}> Begin Tags [miq_group.tags]")
          miq_group.tags.sort.each { |tag_element| tag_text = tag_element.split('/'); $evm.log("info", "#{@method} - Group:<#{miq_group.description}> Category:<#{tag_text.first.inspect}> Tag:<#{tag_text.last.inspect}>")}
          $evm.log("info","#{@method} - Group:<#{miq_group.description}> End Tags [miq_group.tags]")
          $evm.log("info","")
        end

        $evm.log("info","#{@method} - Group:<#{miq_group.description}> Begin Virtual Columns [miq_group.virtual_column_names]")
        miq_group.virtual_column_names.sort.each { |vcn| $evm.log("info", "#{@method} - Group:<#{miq_group.description}> Virtual Columns - #{vcn}: #{miq_group.send(vcn).inspect}")}
        $evm.log("info","#{@method} - Group:<#{miq_group.description}> End Virtual Columns [miq_group.virtual_column_names]")
        $evm.log("info","")
      end
    end
  end

  #########################
  #
  # Method: dumpHost
  # Inputs: $evm.root['host']
  # Description: Dump Host information
  #
  ##########################
  def dumpHost(host)
    $evm.log("info","#{@method} - Host:<#{host.name}> Begin Attributes [host.attributes]")
    host.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - Host:<#{host.name}> Attributes - #{k}: #{v.inspect}")}
    $evm.log("info","#{@method} - Host:<#{host.name}> End Attributes [host.attributes]")
    $evm.log("info","")

    $evm.log("info","#{@method} - Host:<#{host.name}> Begin Associations [host.associations]")
    host.associations.sort.each { |assc| $evm.log("info", "#{@method} - Host:<#{host.name}> Associations - #{assc}")}
    $evm.log("info","#{@method} - Host:<#{host.name}> End Associations [host.associations]")
    $evm.log("info","")

    $evm.log("info","#{@method} - Host:<#{host.name}> Begin Hardware [host.hardware]")
    host.hardware.attributes.each { |k,v| $evm.log("info", "#{@method} - Host:<#{host.name}> Hardware - #{k}: #{v.inspect}")}
    $evm.log("info","#{@method} - Host:<#{host.name}> End Hardware [host.hardware]")
    $evm.log("info","")

    $evm.log("info","#{@method} - Host:<#{host.name}> Begin Lans [host.lans]")
    host.lans.each { |lan| lan.attributes.sort.each { |k,v| $evm.log("info", "#{@method} - Host:<#{host.name}> Lan:<#{lan.name}> - #{k}: #{v.inspect}")}}
    $evm.log("info","#{@method} - Host:<#{host.name}> End Lans [host.lans]")
    $evm.log("info","")

    $evm.log("info","#{@method} - Host:<#{host.name}> Begin Switches [host.switches]")
    host.switches.each { |switch| switch.attributes.sort.each { |k,v| $evm.log("info", "#{@method} - Host:<#{host.name}> Swtich:<#{switch.name}> - #{k}: #{v.inspect}")}}
    $evm.log("info","#{@method} - Host:<#{host.name}> End Switches [host.switches]")
    $evm.log("info","")

    $evm.log("info","#{@method} - Host:<#{host.name}> Begin Operating System [host.operating_system]")
    host.operating_system.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - Host:<#{host.name}> Operating System - #{k}: #{v.inspect}")}
    $evm.log("info","#{@method} - Host:<#{host.name}> End Operating System [host.operating_system]")
    $evm.log("info","")

    $evm.log("info","#{@method} - Host:<#{host.name}> Begin Guest Applications [host.guest_applications]")
    host.guest_applications.each { |guest_app| guest_app.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - Host:<#{host.name}> Guest Application:<#{guest_app.name}> - #{k}: #{v.inspect}")}}
    $evm.log("info","#{@method} - Host:<#{host.name}> End Guest Applications [host.guest_applications]")
    $evm.log("info","")

    unless host.tags.nil?
      $evm.log("info","#{@method} - Host:<#{host.name}> Begin Tags [host.tags]")
      host.tags.sort.each { |tag_element| tag_text = tag_element.split('/'); $evm.log("info", "#{@method} - Host:<#{host.name}> Category:<#{tag_text.first.inspect}> Tag:<#{tag_text.last.inspect}>")}
      $evm.log("info","#{@method} - Host:<#{host.name}> End Tags [host.tags]")
      $evm.log("info","")
    end

    $evm.log("info","#{@method} - Host:<#{host.name}> Begin Virtual Columns [host.virtual_column_names]")
    host.virtual_column_names.sort.each { |vcn| $evm.log("info", "#{@method} - Host:<#{host.name}> Virtual Columns - #{vcn}: #{host.send(vcn).inspect}")}
    $evm.log("info","#{@method} - Host:<#{host.name}> End Virtual Columns [host.virtual_column_names]")
    $evm.log("info", "")
  end


  #########################
  #
  # Method: dumpVM
  # Inputs: $evm.root['vm']
  # Description: Dump VM information
  #
  ##########################
  def dumpVM(vm)
    $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Attributes [vm.attributes]")
    vm.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - VM:<#{vm.name}> Attributes - #{k}: #{v.inspect}")}
    $evm.log("info","#{@method} - VM:<#{vm.name}> End Attributes [vm.attributes]")
    $evm.log("info","")

    $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Associations [vm.associations]")
    vm.associations.sort.each { |assc| $evm.log("info", "#{@method} - VM:<#{vm.name}> Associations - #{assc}")}
    $evm.log("info","#{@method} - VM:<#{vm.name}> End Associations [vm.associations]")
    $evm.log("info","")

    $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Hardware Attributes [vm.hardware]")
    vm.hardware.attributes.each { |k,v| $evm.log("info", "#{@method} - VM:<#{vm.name}> Hardware - #{k}: #{v.inspect}")}
    $evm.log("info","#{@method} - VM:<#{vm.name}> End Hardware Attributes [vm.hardware]")
    $evm.log("info","")

    $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Hardware Associations [vm.hardware.associations]")
    vm.hardware.associations.sort.each { |assc| $evm.log("info", "#{@method} - VM:<#{vm.name}> hardware Associations - #{assc}")}
    $evm.log("info","#{@method} - VM:<#{vm.name}> End hardware Associations [vm.hardware.associations]")
    $evm.log("info","")

    $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Neworks [vm.hardware.nics]")
    vm.hardware.nics.each { |nic| nic.attributes.sort.each { |k,v| $evm.log("info", "#{@method} - VM:<#{vm.name}> VLAN:<#{nic.device_name}> - #{k}: #{v.inspect}")}}
    $evm.log("info","#{@method} - VM:<#{vm.name}> End Networks [vm.hardware.nics]")
    $evm.log("info","")

    unless vm.ext_management_system.nil?
      $evm.log("info","#{@method} - VM:<#{vm.name}> Begin EMS [vm.ext_management_system]")
      vm.ext_management_system.attributes.sort.each { |ems_k, ems_v| $evm.log("info", "#{@method} - VM:<#{vm.name}> EMS:<#{vm.ext_management_system.name}> #{ems_k} - #{ems_v.inspect}")}
      $evm.log("info","#{@method} - VM:<#{vm.name}> End EMS [vm.ext_management_system]")
      $evm.log("info","")
    end

    unless vm.owner.nil?
      $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Owner [vm.owner]")
      vm.owner.attributes.each { |k,v| $evm.log("info", "#{@method} - VM:<#{vm.name}> Owner - #{k}: #{v.inspect}")}
      $evm.log("info","#{@method} - VM:<#{vm.name}> End Owner [vm.owner]")
      $evm.log("info","")
    end

    unless vm.operating_system.nil?
      $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Operating System [vm.operating_system]")
      vm.operating_system.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - VM:<#{vm.name}> Operating System - #{k}: #{v.inspect}")}
      $evm.log("info","#{@method} - VM:<#{vm.name}> End Operating System [vm.operating_system]")
      $evm.log("info","")
    end

    unless vm.guest_applications.nil?
      $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Guest Applications [vm.guest_applications]")
      vm.guest_applications.each { |guest_app| guest_app.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - VM:<#{vm.name}> Guest Application:<#{guest_app.name}> - #{k}: #{v.inspect}")}} unless vm.guest_applications.nil?
      $evm.log("info","#{@method} - VM:<#{vm.name}> End Guest Applications [vm.guest_applications]")
      $evm.log("info","")
    end

    unless vm.snapshots.nil?
      $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Snapshots [vm.snapshots]")
      vm.snapshots.each { |ss| ss.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - VM:<#{vm.name}> Snapshot:<#{ss.name}> - #{k}: #{v.inspect}")}} unless vm.snapshots.nil?
      $evm.log("info","#{@method} - VM:<#{vm.name}> End Snapshots [vm.snapshots]")
      $evm.log("info","")
    end

    unless vm.storage.nil?
      $evm.log("info","#{@method} - VM:<#{vm.name}> Begin VM Storage [vm.storage]")
      vm.storage.attributes.sort.each { |stor_k, stor_v| $evm.log("info", "#{@method} - VM:<#{vm.name}> Storage:<#{vm.storage.name}> #{stor_k} - #{stor_v.inspect}")}
      $evm.log("info","#{@method} - VM:<#{vm.name}> End VM Storage [vm.storage]")
      $evm.log("info","")
    end

    unless vm.tags.nil?
      $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Tags [vm.tags]")
      vm.tags.sort.each { |tag_element| tag_text = tag_element.split('/'); $evm.log("info", "#{@method} - VM:<#{vm.name}> Category:<#{tag_text.first.inspect}> Tag:<#{tag_text.last.inspect}>")}
      $evm.log("info","#{@method} - VM:<#{vm.name}> End Tags [vm.tags]")
      $evm.log("info","")
    end

    $evm.log("info","#{@method} - VM:<#{vm.name}> Begin Virtual Columns [vm.virtual_column_names]")
    vm.virtual_column_names.sort.each { |vcn| $evm.log("info", "#{@method} - VM:<#{vm.name}> Virtual Columns - #{vcn}: #{vm.send(vcn).inspect}")}
    $evm.log("info","#{@method} - VM:<#{vm.name}> End Virtual Columns [vm.virtual_column_names]")
    $evm.log("info","")
  end


  #########################
  #
  # Method: dumpCluster
  # Inputs: $evm.root['ems_cluster']
  # Description: Dump Cluster information
  #
  ##########################
  def dumpCluster(cluster)
    $evm.log("info","#{@method} - Cluster:<#{cluster.name}> Begin Attributes [cluster.attributes]")
    cluster.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - Cluster:<#{cluster.name}> Attributes - #{k}: #{v.inspect}")}
    $evm.log("info","#{@method} - Cluster:<#{cluster.name}> End Attributes [cluster.attributes]")
    $evm.log("info","")

    $evm.log("info","#{@method} - Cluster:<#{cluster.name}> Begin Associations [cluster.associations]")
    cluster.associations.sort.each { |assc| $evm.log("info", "#{@method} - Cluster:<#{cluster.name}> Associations - #{assc}")}
    $evm.log("info","#{@method} - Cluster:<#{cluster.name}> End Associations [cluster.associations]")
    $evm.log("info","")

    unless cluster.tags.nil?
      $evm.log("info","#{@method} - Cluster:<#{cluster.name}> Begin Tags [cluster.tags]")
      cluster.tags.sort.each { |tag_element| tag_text = tag_element.split('/'); $evm.log("info", "#{@method} - Cluster:<#{cluster.name}> Category:<#{tag_text.first.inspect}> Tag:<#{tag_text.last.inspect}>")}
      $evm.log("info","#{@method} - Cluster:<#{cluster.name}> End Tags [cluster.tags]")
      $evm.log("info","")
    end

    $evm.log("info","#{@method} - Cluster:<#{cluster.name}> Begin Virtual Columns [cluster.virtual_column_names]")
    cluster.virtual_column_names.sort.each { |vcn| $evm.log("info", "#{@method} - Cluster:<#{cluster.name}> Virtual Columns - #{vcn}: #{cluster.send(vcn)}")}
    $evm.log("info","#{@method} - Cluster:<#{cluster.name}> End Virtual Columns [cluster.virtual_column_names]")
    $evm.log("info","")
  end


  #########################
  #
  # Method: dumpEMS
  # Inputs: $evm.root['ext_managaement_system']
  # Description: Dump EMS information
  #
  ##########################
  def dumpEMS(ems)
    $evm.log("info","#{@method} - EMS:<#{ems.name}> Begin Attributes [ems.attributes]")
    ems.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - EMS:<#{ems.name}> Attributes - #{k}: #{v.inspect}")}
    $evm.log("info","#{@method} - EMS:<#{ems.name}> End Attributes [ems.attributes]")
    $evm.log("info","")

    $evm.log("info","#{@method} - EMS:<#{ems.name}> Begin Associations [ems.associations]")
    ems.associations.sort.each { |assc| $evm.log("info", "#{@method} - EMS:<#{ems.name}> Associations - #{assc}")}
    $evm.log("info","#{@method} - EMS:<#{ems.name}> End Associations [ems.associations]")
    $evm.log("info","")

    $evm.log("info","#{@method} - EMS:<#{ems.name}> Begin EMS Folders [ems.ems_folders]")
    ems.ems_folders.each { |ef| ef.attributes.sort.each { |k,v| $evm.log("info", "#{@method} - EMS:<#{ems.name}> EMS Folder:<#{ef.name}> #{k}: #{v.inspect}")}}
    $evm.log("info","#{@method} - EMS:<#{ems.name}> End EMS Folders [ems.ems_folders]")
    $evm.log("info","")

    unless ems.tags.nil?
      $evm.log("info","#{@method} - EMS:<#{ems.name}> Begin Tags [ems.tags]")
      ems.tags.sort.each { |tag_element| tag_text = tag_element.split('/'); $evm.log("info", "#{@method} - EMS:<#{ems.name}> Category:<#{tag_text.first.inspect}> Tag:<#{tag_text.last.inspect}>")}
      $evm.log("info","#{@method} - EMS:<#{ems.name}> End Tags [ems.tags]")
      $evm.log("info","")
    end

    $evm.log("info","#{@method} - EMS:<#{ems.name}> Begin Virtual Columns [ems.virtual_column_names]")
    ems.virtual_column_names.sort.each { |vcn| $evm.log("info", "#{@method} - EMS:<#{ems.name}> Virtual Columns - #{vcn}: #{ems.send(vcn)}")}
    $evm.log("info","#{@method} - EMS:<#{ems.name}> End Virtual Columns [ems.virtual_column_names]")
    $evm.log("info","")
  end


  #########################
  #
  # Method: dumpStorage
  # Inputs: $evm.root['storage']
  # Description: Dump Storage information
  #
  ##########################
  def dumpStorage(storage)
    $evm.log("info","#{@method} - Storage:<#{storage.name}> Begin Attributes [storage.attributes]")
    storage.attributes.sort.each { |k, v| $evm.log("info", "#{@method} - Storage:<#{storage.name}> Attributes - #{k}: #{v.inspect}")}
    $evm.log("info","#{@method} - Storage:<#{storage.name}> End Attributes [storage.attributes]")
    $evm.log("info","")

    $evm.log("info","#{@method} - Storage:<#{storage.name}> Begin Associations [storage.associations]")
    storage.associations.sort.each { |assc| $evm.log("info", "#{@method} - Storage:<#{storage.name}> Associations - #{assc}")}
    $evm.log("info","#{@method} - Storage:<#{storage.name}> End Associations [storage.associations]")
    $evm.log("info","")

    unless storage.tags.nil?
      $evm.log("info","#{@method} - Storage:<#{storage.name}> Begin Tags [storage.tags]")
      storage.tags.sort.each { |tag_element| tag_text = tag_element.split('/'); $evm.log("info", "#{@method} - Storage:<#{storage.name}> Category:<#{tag_text.first.inspect}> Tag:<#{tag_text.last.inspect}>")}
      $evm.log("info","#{@method} - Storage:<#{storage.name}> End Tags [storage.tags]")
      $evm.log("info","")
    end

    $evm.log("info","#{@method} - Storage:<#{storage.name}> Begin Virtual Columns [storage.virtual_column_names]")
    storage.virtual_column_names.sort.each { |vcn| $evm.log("info", "#{@method} - Storage:<#{storage.name}> Virtual Columns - #{vcn}: #{storage.send(vcn)}")}
    $evm.log("info","#{@method} - Storage:<#{storage.name}> End Virtual Columns [storage.virtual_column_names]")
    $evm.log("info","")
  end


  # List the types of object we will try to detect
  obj_types = %w{ vm host storage ems_cluster ext_management_system }
  obj_type = $evm.root.attributes.detect { |k,v| obj_types.include?(k)}

  # dump root object attributes
  dumpRoot

  # dump miq_server object attributes
  dumpServer

  # dump user attributes
  dumpUser

  # dump miq_group attributes
  dumpGroup


  # If obj_type is NOT nil
  unless obj_type.nil?
    rootobj = obj_type.first
    obj = obj_type.second
    $evm.log("info", "#{@method} - Detected Object:<#{rootobj}>")
    $evm.log("info","")

    case rootobj
    when 'host' then dumpHost(obj)
    when 'vm' then dumpVM(obj)
    when 'ems_cluster' then dumpCluster(obj)
    when 'ext_management_system' then dumpEMS(obj)
    when 'storage' then dumpStorage(obj)
    end
  end

  #
  # Exit method
  #
  $evm.log("info", "#{@method} - EVM Automate Method Ended")
  exit MIQ_OK

  #
  # Set Ruby rescue behavior
  #
rescue => err
  $evm.log("error", "#{@method} - [#{err}]\n#{err.backtrace.join("\n")}")
  exit MIQ_ABORT
end
