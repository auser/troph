module Troph
  class UUID
    def self.generate
      "%04x%04x%04x%04x%04x" % [rand(0x0001000),rand(0x0010000),rand(0x0000100),rand(0x1000000),rand(0x1000000)]
    end
  end
end