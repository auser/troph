=begin rdoc
  Bee is the base worker in troph
  
  Usage:
    class Presence < Troph::Bee
      
      run_after 30 do
        # Do this after seconds
      end
      # When a bee gets handed a payload, this method, on_data
      # is called for the bee
      def on_data(payload)
        # Do stuff with the payload
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
    
    def self.run_after(seconds_to_wait=60, &block)
      run_after_blocks << [seconds_to_wait, block]
    end
    
    def self.run_after_blocks
      @run_after_blocks ||= []
    end
    
    def queue_name
      @queue_name ||= self.class.to_s.camelcase
    end
    
    def self.hive
      @hive ||= []
    end
    
    def self.inherited(receiver)
      hive << receiver.queue_name unless hive.include?(receiver.queue_name)      
    end
    
    def setup_periodic_blocks
      self.class.run_after_blocks.each {|seconds, block| EM.add_periodic_timer(seconds, &block) }
    end
    
  end
end