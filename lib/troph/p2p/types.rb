module Troph    
  MESSAGES = {
    :join => "join",
    :heartbeat => "alive?"
  }
  
  QUEUES = {
    :presence => "presence",
    :heartbeat => "ping",
    :nodes => "nodes"
  }
end