class Presence < Troph::Bee
  
  attr_writer :last_presence_request_time
  
  event_loop 5 do |bee|
    if (Time.now - 5) >= bee.last_presence_request_time
      bee.send_to_queue("presence", "#{bee.my_ip}")
      bee.last_presence_request_time = Time.now
    end
  end
  
  def after_create
    @last_presence_request_time = Time.now
  end
  
  def last_presence_request_time
    @last_presence_request_time ||= Time.now
  end
  
  # When a bee gets handed a payload, this method, on_data
  # is called for the bee
  def on_data(payload)
    # Do stuff with the payload
    Troph::Log.info "received presence message: #{payload}"
  end

end