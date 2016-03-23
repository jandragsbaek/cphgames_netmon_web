class TrafficScheduler
  def self.perform
    Switch.all.each do |switch|
      if switch.readings.where('created_at > ?', switch.parsed_at).count > 0
        switch.update_attributes parsed_at: Time.now
        Resque.enqueue_to('medium', TrafficParser, switch.id)
      end
    end
  end
end
