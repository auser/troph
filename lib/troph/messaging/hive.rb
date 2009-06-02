=begin rdoc
  Base hive
=end
module Troph
  class Hive
    
    def self.setup(base_dir=Dir.pwd)
      Dir["#{base_dir}/bees/*.rb"].each {|bee| require bee }
      super
    end
        
    # Bees this hive responds to (locally)
    def self.bees(*hive)
      @bees ||= (hive.empty? ? Bee.hive : hive)
    end
    
    # Queues based on the bees in the queue
    def self.queues
      bees.map {|b| b.private? ? nil : b.queue_name }.compact
    end
        
    # Start this hive (server)
    # First load all the bees from the bees directory
    # and then set them up
    def self.start(base_dir=Dir.pwd)
      setup(base_dir)      
      bees.map {|b| b.new(self) }.each do |bee|
        Troph::Log.info "Adding #{bee.queue_name} bee"
        b.init
      end
      Troph::Log.info "Started and running troph"
    end
    
    def self.comm
      @instance ||= comm_klass.send(:new, o)
    end
    
    def self.comm_klass(n=nil)
      @comm_klass ||= n ? n : Troph::Bunny
    end
    
  end
end