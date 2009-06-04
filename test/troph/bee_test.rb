require "#{File.dirname(__FILE__)}/../test_helper"
Dir["#{::File.dirname(__FILE__)}/bees/*.rb"].each {|lib| require lib }

class BeeTest < Test::Unit::TestCase
  context "hive" do
    should "have a hive of the available bees" do
      assert_equal [:announcement, :solitude], Troph::Bee.hive
    end
    should "be able to say if it's a private bee or not" do
      assert !Announcement.private?
      assert Solitude.private?
    end
    
    context "bee" do
      setup do
        @bee = Troph::Bee.new
      end

      should "be able to set it's ID as random" do
        assert_not_nil @bee.identity
      end
      
      should "have the queue name the same as the snake_cased class" do
        assert_equal "troph::bee", @bee.queue_name
      end
      
    end
  end
  
end