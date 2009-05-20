module Troph
  class BaseHandler
    
    def initialize(msg, &block)
      ty = Troph.message_type(msg)
      handle_message(ty, msg)
    end
    
    def handle_message(type, msg)
      raise Exception.new("This message handler doesn't implement handle_message yet")
    end
    
    class << self
      def queue_name(n=nil)
        if n
          @queue_name = n
        else
          @queue_name
        end
      end
    end
    
  end
end

$:.unshift("#{File.dirname(__FILE__)}/handlers")
Dir["#{File.dirname(__FILE__)}/handlers/*.rb"].each do |lib| 
  require File.basename(lib)
end