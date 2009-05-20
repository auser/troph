module Troph    
  MESSAGES = {
    :join         => "m1",
    :heartbeat    => "m2",
    :nominations  => "m3"
  }
  
  QUEUES = {
    :presence     => "q1",
    :heartbeat    => "q2",
    :nodes        => "q3"
  }
end