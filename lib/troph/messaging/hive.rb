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
    
    def self.queues
      bees.map {|b| b.private? ? nil : b.queue_name }.compact
    end
    
    # Start this hive (server)
    # First load all the bees from the bees directory
    # and then set them up
    def self.start(base_dir=$cwd)
      load_hive(base_dir)      
      bees.map {|b| b.new }.each do |bee|
        bee.hive_proxy = self
        Troph::Log.info "Adding #{bee.queue_name} bee"
        bee.setup_periodic_block
        fork {bee.setup_listener}
      end
      Troph::Log.info "Started and running troph. pzzzzz"
    end
    
  end
end