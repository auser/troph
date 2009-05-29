class Presence < Troph::Bee
  
  event_loop do
    sleep 30
    # Do this after 30 seconds
    puts "me!"
  end
  
  # When a bee gets handed a payload, this method, on_data
  # is called for the bee
  def on_data(payload, queue_instance)
    # Do stuff with the payload
  end

end