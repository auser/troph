=begin rdoc
  Base hive
=end
module Troph
  class Hive
        
    def self.load_hive(base_dir=$cwd)
      Dir["#{base_dir}/bees/*.rb"].each {|bee| require bee }
    end
    
    def self.bees
      @bees ||= Bee.hive
    end
    
    # TODO: Add availability of the bees here
    # Setup the bees in the hive
    # 
    # This sets up the periodic blocks from within the bees
    # and binds and subscribes the bees
    def self.setup_bees
      bees.map {|b| b.new }.each do |bee|
        bee.setup_listener(Troph::Comm.instance)
      end
    end
    
    # Start this hive (server)
    # First load all the bees from the bees directory
    # and then set them up
    def self.start(base_dir=$cwd)
      load_hive(base_dir)
      setup_bees
      EM.run do
        puts "in EM.run"
        p [:bees, bees, $cwd]
        bees.each {|bee| bee.periodic_block.call }
      end
    end
    
  end
end