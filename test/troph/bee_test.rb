require './../test_helper'
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
    
  end
  
end