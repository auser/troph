module Troph
  class BaseCaller
    attr_reader :server
    
    def initialize(server)
      @server = server
      handle_call
    end
    
    def handle_call(msg)
      raise Exception.new("This runtime caller doesn't implement handle_call yet")
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

$:.unshift("#{File.dirname(__FILE__)}/callers")
Dir["#{File.dirname(__FILE__)}/callers/*.rb"].each do |lib| 
  require File.basename(lib)
end