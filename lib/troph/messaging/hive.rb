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
    def self.setup_bees
      bees.each do |bee|
        bee.setup_periodic_blocks
        c = Troph::Comm.instance
        queue = c.queue(bee.queue_name)
        exch = b.exchange(bee.queue_name + "_exchange")
        queue.bind(exch, :key => "troph")
        queue.subscribe(:consumer_tag => 'testtag1') do |msg|
          bee.on_data(msg)
        end
      end
    end
    
    def self.start
      load_hive
      setup_bees
    end
    
  end
end