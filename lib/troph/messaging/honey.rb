=begin rdoc
  Package the honey (packets)
=end
module Troph
  class Honey
    
    def self.package(msg)
      [msg].pack("m*")      
    end
    
    def self.unwrap(msg)
      msg.unpack("m*").first
    end
    
  end
end