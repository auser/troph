# $:.unshift(::File.dirname(__FILE__))
# require "cloud_god"
# Dir["#{File.dirname(__FILE__)}/bees/*.rb"].each {|lib| require lib }

Troph::Log.init("poolparty_troph", "#{File.dirname(__FILE__)}/log")

class PoolPartyHive < Troph::Hive
  # bees :nominations
  after_started do |hive|
    Troph::Log.debug "Started #{hive}"    
    hive.comm.send_to_queue("presence", hive.my_ip, :package => {:action => "a"})
  end
  
  def neighborhood
    @neighborhood ||= []
  end
  
  def cloud
    @cloud ||= clouds[cloud_name.to_sym]
  end
  
  def cloud_name
    @cloud_name ||= open("/etc/poolparty/cloudname").read rescue "test_cloud"
  end
  
  def my_ip
    require "macmap"
    Macmap.map_iface_to_ip(%x{ifconfig -a})["en0"]
  end
  
end