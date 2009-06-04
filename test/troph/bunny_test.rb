require "#{File.dirname(__FILE__)}/../test_helper"

class BunnyTest < Test::Unit::TestCase
  context "instance" do
    setup do
      @bunny = Troph::Bunny.new
      @bunny.testing = true
    end

    should "be a new bunny client instance for .instance" do
      assert_equal Bunny::Client, @bunny.instance.class
    end
    
    should "cache the client instance" do
      b = @bunny.instance
      assert_equal b, @bunny.instance
    end
    
    should "not be connected (in testing mode)" do
      assert_equal :not_connected, @bunny.instance.status
    end
    
  end
  
end