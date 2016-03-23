class TrafficParser
  def self.perform(switch_id)
    switch = Switch.find(switch_id)

    down = switch.down_cache
    up = switch.up_cache

    switch.update_attributes in_speed: down, out_speed: up, parsed_at: Time.now, bandwidth_up: switch.bandwidth_used_up, bandwidth_down: switch.bandwidth_used_down

    Datapoint.create(switch_id: switch_id, port: 24, direction: 'in', speed: down)
    Datapoint.create(switch_id: switch_id, port: 24, direction: 'out', speed: up)

    puts "Updated #{switch.source}! #{down}kb/s / #{up}kb/s - #{switch.bandwidth_used_down}/#{switch.bandwidth_used_up}"

  end
end
