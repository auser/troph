module Troph
  class BunnyComm
    
    def instance
      b = ::Bunny.new(:logging => true)
      b.start
      b
    end
    
  end
end