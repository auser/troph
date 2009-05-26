module Troph
    
  def self.prepare_message(type, o={})
    [{:message_type => Troph::MESSAGES[type.to_sym]}.merge(o).to_json].pack("m*")
  end
  
  def self.receive_message(msg)
    JSON.parse(msg.unpack("m*").first)
  end
  
  # Grab the message type
  def self.message_type(hsh)
    hsh.delete(:message_type) || hsh
  end
  
  # Get the queue and publish the type to the queue
  def self.send_to_queue(host, q, t, o={})
    get_remote_queue(host, q).publish(Troph.prepare_message(t.to_sym, o))
  end
  
  def self.get_remote_queue(host, queue_name)
    conn = connection_to(host)
    channel = MQ.new(conn)
    MQ::Queue.new(channel, queue_name)    
  end
  
  def self.connection_to(host, retry_times=3)
    count = 0
    while true do
      begin        
        return AMQP.connect(:host => host, :logging => false)
      rescue
        puts "Error connecting to #{host}... retrying #{count} more times"
        count += 1
        raise NoConnectionError.new(host) if count >= retry_times
      end
    end    
  end
  
end

class NoConnectionError < StandardError
  def initialize(hst)
    "Could not connect to #{hst}"
  end
end