module Troph    
  MESSAGES = {
    :join         => {:message_type => "join"},
    :heartbeat    => {:message_type => "heartbeat"},
    :presence     => {:message_type => "presence"},
    :nominations  => {:message_type => "nominations"}
  }
  
  QUEUES = {
    :presence     => "presence",
    :heartbeat    => "heartbeat",
    :nodes        => "nodes"
  }
end