module Troph    
  MESSAGES = {
    :join         => "join",
    :heartbeat    => "heartbeat",
    :presence     => "presence",
    :nominations  => "nominations"
  }
  
  QUEUES = {
    :presence     => "presence",
    :heartbeat    => "heartbeat",
    :nodes        => "nodes"
  }
end