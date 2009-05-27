=begin rdoc
  Base hive
=end
module Troph
  class Hive
    mattr_reader :bees, []
        
    def self.load_hive(base_dir=Dir.pwd)
      Dir["#{base_dir}/bees/*.rb"].each {|bee| require bee }
    end
    
    def self.setup_bees
      bees.each do |bee|
        EM.add_periodic_timer(bee.){
        }
      end
    end
    
    def self.start
      load_hive
      setup_bees
    end
    
  end
end