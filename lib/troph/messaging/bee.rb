=begin rdoc
  Bee is the base worker in troph
  
  Usage:
    class Presence < Troph::Bee
      
      # When a bee gets handed a payload, this method, on_data
      # is called for the bee
      def on_data(payload)
        # Do stuff with the payload
      end
      
      # The periodic_run method is called every seconds_to_wait
      # seconds
      def periodic_run(seconds_to_wait)
        # Do this after seconds
      end

    end
    
  The above class will listen on the "presence" (from the class name) 
  queue and listen for payloads. They can also run after a set amount of time.
  This is accomplished by passing periodic_run as a method in the class
=end
module Troph
  class Bee
    
    def on_data(payload)
      raise Exception.new("#{self.class} does not accept on_data(payload)")
    end
    
    def periodic_run(seconds_to_wait=60)
      raise Exception.new("#{self.class} does not accept periodic_run(seconds_to_wait)")
    end
    
    def self.queue_name
      @queue_name ||= name.to_s.xcamelcase
    end
    
    def self.hive
      @hive ||= []
    end
    
    def self.inherited(receiver)
      hive << receiver.queue_name unless hive.include?(receiver.queue_name)      
    end
    
  end
end