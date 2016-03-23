class Group < ActiveRecord::Base
  has_many :switches

  attr_accessor :down_speed, :up_speed


  def column_width
    "style=\"width: 410px\"" if switches.count > 13 && id != 1
    "style=\"width: 615px\"" if switches.count > 26 && id != 1
  end

  def bandwidth
    total_up = 0
    total_down = 0

    used_up = 0
    used_down = 0

    switches.each do |switch|
      total_up += (switch.out_speed.to_f / 1024)
      total_down += (switch.in_speed.to_f / 1024)

      used_up += switch.bandwidth_up
      used_down += switch.bandwidth_down
    end

    up_speed = total_up.to_f
    down_speed = total_down.to_f
    bw_down = used_down
    bw_up = used_up

    {text: "#{down_speed.round(2)}MiB/s | #{up_speed.round(2)}MiB/s", up: up_speed, down: down_speed, bw_down: bw_down, bw_up: bw_up}
  end
end
