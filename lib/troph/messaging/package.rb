module Troph
  class Package
    
    attr_accessor :token, :payload, :action
    
    def initialize(o={})
      @token = UUID.generate
      o.each {|k,v| self.send("#{k}=", v) } if o
    end
    
    def self.from_data(data)
      package = Marshal.load(data)
      package.payload = Honey.unwrap(package.payload) if package.payload
      package
    end
    
    def dump
      @payload = Honey.package(payload) if payload
      Marshal.dump(self)
    end
    
  end
end