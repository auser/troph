$:.unshift(::File.dirname(__FILE__))
require "cloud_god"
Dir["#{File.dirname(__FILE__)}/bees/*.rb"].each {|lib| require lib }

class PoolPartyHive < Troph::Hive  
end