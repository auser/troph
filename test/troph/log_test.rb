require './../test_helper'

class LogTest < Test::Unit::TestCase
  context "log" do
    setup do
      Troph::Log.reset!
    end

    should "output to standard out by default" do
      Troph::Log.init
      o = redirect_stdout do
        Troph::Log.info "hi"
      end
      assert_match /INFO: hi/, o
    end
    
    should "output to a string if init'd with a string path" do      
      path = "#{File.dirname(__FILE__)}/../log"
      FileUtils.mkdir path unless File.directory?(path)
      File.unlink "#{path}/bee.log" if File.file?("#{path}/bee.log")
      Troph::Log.init "bee", path
      Troph::Log.info "hello bees"
      assert_match /INFO: hello bees/, open("#{path}/bee.log").read
      File.unlink "#{path}/bee.log" if File.file?("#{path}/bee.log")
    end
    
  end
  
  private
  def redirect_stdout(&block)
    old_stdout = $stdout
    str = StringIO.new
    $stdout = str
    begin
       block.call
    ensure
       $stdout = old_stdout
    end
    str.string
  end
end
