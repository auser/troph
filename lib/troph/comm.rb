%w(bunny).each { |lib| require "comms/#{lib}" }

module Troph
  class Comm
    
    def self.instance
      @instance ||= new.instance
    end
    
    def instance
      Troph::BunnyComm.new.instance
    end
    
  end
end