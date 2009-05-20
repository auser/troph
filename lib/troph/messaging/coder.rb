
module Troph
  
  def self.get_queue(type)
    MQ.queue(Troph::QUEUES[type.to_sym])
  end
  
  def self.prepare_message(type, o={})
    [{:message_type => Troph::MESSAGES[type.to_sym]}.merge(o).to_json].pack("m*")
  end
  
  def self.receive_message(msg)
    JSON.parse(msg.unpack("m*").first)
  end
  
  def self.message_type(hsh)
    hsh.delete(:message_type)
  end
  
  # Get the queue and publish the type to the queue
  def self.send_to_queue(q, t, o={})
    Troph.get_queue(q.to_sym).publish(Troph.prepare_message(t.to_sym, o))
  end
  
end