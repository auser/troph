class Forker
  attr_reader :children, :run_block

  def initialize(prefork, max_clients_per_child, port, client_handler, run_block)
    @max_clients_per_child = max_clients_per_child
    @port = port
    @children = 0
    @client_handler = client_handler
    @run_block = run_block
  end

  def child_handler
    trap('INT', 'EXIT')
    @client_handler.before
    @max_clients_per_child.times {
        client = @server.accept or break
        @client_handler.handle_request(client)
        client.close
    }
    @client_handler.after
  end

  def spawn_child
    @child_count += 1
    fork {child_handler}
  end
  
  def reaper_handler
    Proc.new do
      trap('CHLD', @reaper)
      pid = Process.wait
      @child_count -= 1
    end
  end
  
  def interrupt_hanlder
    Proc.new do
      trap('CHLD', 'IGNORE')
      trap('INT', 'IGNORE')
      Process.kill('INT', 0)
      exit
    end
  end

  def run
    @server = TCPserver.open(@port)
    trap('CHLD', reaper_handler)
    trap('INT', interrupt_hanlder)
    loop &run_block
  end
end