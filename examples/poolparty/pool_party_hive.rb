# $:.unshift(::File.dirname(__FILE__))
# require "cloud_god"
# Dir["#{File.dirname(__FILE__)}/bees/*.rb"].each {|lib| require lib }

Troph::Log.init("poolparty_troph", "#{File.dirname(__FILE__)}/log")

class PoolPartyHive < Troph::Hive
  # bees :nominations
  
  def my_ip
    require "macmap"
    Macmap.map_iface_to_ip(%x{ifconfig -a})["en0"]
  end
  
end