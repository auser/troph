module Troph
  class Server
    attr_reader :topic, :presence_block
    attr_accessor :queues
    
    def initialize(t=nil, &block)
      @topic = t
      @queues = []
      instance_eval &block
      $server = self
    end
        
    def run
      
      Signal.trap('INT') { AMQP.stop }
      Signal.trap('TERM'){ AMQP.stop }
      
      AMQP.start(server_opts) do |server|
        MQ.topic(topic) if topic
        
        if presence_block
          queue("presence", :key => "presence", &presence_block)
        end
        queues.each {|q| q.apply(server) }
      end
    end
    
    def server_opts
      {:host => '127.0.0.1'}
    end
    
    def at_presence(&block)
      @presence_block ||= block
    end
    
    def queue(t, o={}, &block)
      if block
        @queues << Queue.new(t, o, &block)
      end      
    end
    
    at_exit do
      if $! != 0
        exit
      end
      puts "Running server..."
      $server.run
    end
        
  end
end