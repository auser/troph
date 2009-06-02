require './../test_helper'

class BunnyTest < Test::Unit::TestCase
  context "instance" do
    setup do
      @bunny = Troph::Bunny.new
    end

    should "be a new bunny client instance for .instance" do
      assert_equal Bunny::Client, @bunny.instance.class
    end
    
    should "cache the client instance" do
      b = @bunny.instance
      assert_equal b, @bunny.instance
    end
    
    should "be connected" do
      assert_equal :connected, @bunny.instance.status
    end
    
  end
  
end