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
    attr_accessor :hive_proxy
    
    def initialize
      after_create
    end
    
    def after_create
    end
    
    def on_data(payload)
      raise Exception.new("#{self.class} does not accept on_data(payload)")
    end
    
    def self.event_loop(time, &block)
      run_after_blocks << [time, block]
    end
    
    def self.run_after_blocks
      @run_after_blocks ||= []
    end
    
    def queue_name
      @queue_name ||= self.class.to_s.downcase
    end
    
    def self.queue_name
      self.to_s.downcase
    end
    
    def self.private?
      @private_bee
    end
    
    def self.private_bee(n=false)
      @private_bee = n
    end
    
    def self.hive
      @hive ||= []
    end
    
    def self.inherited(receiver)
      hive << receiver unless hive.include?(receiver)
    end
    
    def setup_periodic_block
      self.class.run_after_blocks.each {|s, b| Thread.new {EM.run do
          EM.add_periodic_timer(s, Proc.new {b.call(self)})
        end
      } }
    end
    
    def setup_listener
      Troph::Comm.setup_subscription(self)
    end
    
    # Idea taken so graciously from nanite
    def identity
      @identity ||= "%04x%04x%04x%04x%04x" % [rand(0x0001000),rand(0x0010000),rand(0x0000100),rand(0x1000000),rand(0x1000000)]
    end
    
    def method_missing(m,*a,&block)
      hive_proxy ? hive_proxy.send(m,*a,&block) : super
    end
    
  end
end