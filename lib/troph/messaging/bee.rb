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
    attr_reader :hive, :comm
    
    def initialize(hive=nil)
      @hive = hive
      @comm = hive.comm
      after_create
    end
    
    def init
      setup_periodic_block
      setup_local_listener
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
    
    # The name of the queue this bee listens on is 
    # the class name of the queue
    def queue_name;@queue_name ||= self.class.to_s.downcase;end    
    def self.queue_name;self.to_s.downcase;end
    
    def self.accepts_header(bool=false);@accepts_header ||= bool;end
    def accepts_header?;self.class.accepts_header == true;end
    
    # Private bee
    def private?;self.class.private?;end
    def self.private_bee(n=false);@private_bee = n;end
    def self.private?;@private_bee == true;end
    
    # Setup the periodic_timer block
    def setup_periodic_block
      self.class.run_after_blocks.each {|s, b| Thread.new {EM.run {EM.add_periodic_timer(s, Proc.new {b.call(self)})}} }
    end
    
    def setup_local_listener
      pid = fork do
         Signal.trap(:USR1) { shutdown }
         Signal.trap(:TERM) { shutdown }
         Signal.trap(:INT)  { shutdown }
         comm.setup_subscription(self)
       end
       Process.detach(pid)      
    end
    
    def shutdown
      Troph::Log.info "Stopping #{self}"
      teardown_subscription(self)
      exit()
    end
    
    # Idea taken so graciously from nanite
    def identity
      @identity ||= "%04x%04x%04x%04x%04x" % [rand(0x0001000),rand(0x0010000),rand(0x0000100),rand(0x1000000),rand(0x1000000)]
    end
    
    def self.hive
      @hive ||= []
    end
    
    def self.inherited(receiver)
      sym = receiver.to_s.snake_case.to_sym
      hive << sym unless hive.include?(sym)
    end
    
    def method_missing(m,*a,&block)
      if hive && hive.respond_to?(m)
        hive.send(m,*a,&block)
      elsif comm && comm.respond_to?(m)
        comm.send(m,*a,&block)
      else
        super
      end
    end
    
  end
end