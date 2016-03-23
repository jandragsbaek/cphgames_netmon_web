class Switch < ActiveRecord::Base

  has_many :readings

  attr_accessor :level
  attr_accessor :fake

  def uptime_css_class
    return 'blue' if fake
    return 'green' if alive
    'red'
  end

  def uptime_text
    total_seconds = uptime / 100

    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / (60 * 60)

    format("%02dh%02dm", hours, minutes)
  end

  def downstream_traffic_text
    "#{(in_speed.to_f / 1024).round(2)} MiB/s"
  end

  def upstream_traffic_text
    "#{(out_speed.to_f / 1024).round(2)} MiB/s"
  end

  def up_cache
    @up ||= upstream_traffic
  end

  def down_cache
    @down ||= downstream_traffic
  end

  def bandwidth_used_up
    dataz = readings.all.where('created_at > ?', Time.new(2016, 03, 23, 15, 0, 0)).where(direction: 'out').where(port: 24).order('created_at')
    
    total_bytes_count = 0
    first_taken = false

    prev = 0

    if dataz.count > 2

      dataz.each do |d|
        unless first_taken
          prev = d.bytes
          first_taken = true
          next
        end

        delta = d.bytes.to_f - prev.to_f
        if delta >= 0
          total_bytes_count += delta
        end
        prev = d.bytes
      end
    end
    total_bytes_count.to_f / 1024 / 1024 / 1024 / 1024 
  end
  
  def bandwidth_used_down
    dataz = readings.all.where('created_at > ?', Time.new(2016, 03, 23, 15, 0, 0)).where(direction: 'in').where(port: 24).order('created_at')

    total_bytes_count = 0
    first_taken = false
    prev = 0
    

    if dataz.count > 2

      dataz.each do |d|
        unless first_taken
          prev = d.bytes
          first_taken = true
          next
        end

        delta = d.bytes.to_i - prev.to_i
        if delta >= 0
          total_bytes_count += delta
        end
        prev = d.bytes
      end
    end
    total_bytes_count.to_f / 1024 / 1024 / 1024 / 1024
  end

  def downstream_traffic
    two = readings.all.where(direction: 'in').where(port: 24).order('created_at DESC').limit(2)

    if two.count == 2
      first = two[1]
      second = two[0]

      # this means it has looped
      if second.bytes < first.bytes
        return 0
      end


      delta_bytes = second.bytes - first.bytes
      delta_time = second.created_at - first.created_at

      (delta_bytes / delta_time / 1024) * 8
    else
      0
    end
  end

  def upstream_traffic
    two = readings.all.where(direction: 'out').where(port: 24).order('created_at DESC').limit(2)

    if two.count == 2
      first = two[1]
      second = two[0]
      
      # this means it has looped
      if second.bytes < first.bytes
        return 0
      end

      delta_bytes = second.bytes - first.bytes
      delta_time = second.created_at - first.created_at

      (delta_bytes / delta_time / 1024) * 8
    else
      0
    end
  end
end
