=begin rdoc
  Base hive
=end
module Troph
  class Hive
        
    def self.load_hive(base_dir=Dir.pwd)
      Dir["#{base_dir}/bees/*.rb"].each {|bee| bees << bee }
    end
    
    def self.bees
      @bees ||= []
    end
    
    # TODO: Add availability of the bees here
    # Setup the bees in the hive
    # 
    # This sets up the periodic blocks from within the bees
    # and binds and subscribes the bees
    def self.setup_bees
      bees.each do |bee|
        bee.setup_periodic_blocks
        bee.setup_listener(Troph::Comm.instance)
      end
    end
    
    def self.start(base_dir=Dir.pwd)
      load_hive(base_dir)
      setup_bees
    end
    
  end
end