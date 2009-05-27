%w(bunny).each { |lib| require "comms/#{lib}" }

module Troph
  class Comm
    
    def self.instance
      @instance ||= new.instance
    end
    
    def instance
      Troph::Bunny.instance
    end
    
  end
end