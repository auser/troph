=begin rdoc
  Base hive
=end
module Troph
  class Hive
    mattr_reader :bees, []
    
    # Select bees to use, by default this will
    # use all the bees by default unless specified
    # with 
    #   use_bees :bee_name, :another_bee_name
    def use_bees(*bee_symbols)
      bee_symbols.each {|b| bees << b }
    end
    
    def self.load_hive(base_dir=Dir.pwd)
      Dir["#{base_dir}/*.rb"].each {|bee| require bee }
    end
    
    def self.run!
      load_hive
      
    end
    
  end
end