=begin rdoc
  Base hive
=end
module Troph
  class Hive
    
    def initialize(&block)
      instance_eval &block if block
    end
    
    def self.setup(base_dir=Dir.pwd)
      Dir["#{base_dir}/bees/*.rb"].each {|bee| require bee }
    end
    
    # Live bees... constantized symbols
    def hive
      self.class.bees.map do |bee|
        return bee unless bee.is_a?(Symbol)
        bee.to_s.constantize.send(:new, self)
      end
    end
    
    # Queues based on the bees in the queue
    def queues
      hive.map {|b| b.private? ? nil : b.queue_name }.compact
    end
        
    # Start this hive (server)
    # First load all the bees from the bees directory
    # and then set them up
    def self.start(base_dir=Dir.pwd)
      setup(base_dir)
      i = new do        
        hive.each {|bee| bee.init }
        Troph::Log.info "Started and running troph through #{self.class}"
      end
    end
    
    # Bees this hive responds to (locally)
    def self.bees(*hive)
      @bees ||= (hive.empty? ? Bee.hive : hive)
    end
    
    def comm
      @instance ||= comm_klass.send(:new)
    end
    
    def comm_klass(n=nil)
      @comm_klass ||= n ? n : Troph::Bunny
    end
    
  end
end