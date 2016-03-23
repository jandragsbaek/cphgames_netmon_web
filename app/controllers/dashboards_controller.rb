class DashboardsController < ApplicationController
  def index

  end

  def uptime
    @switches = Switch.order(:ip)
    @groups = Group.order('id DESC').includes(:switches)

    down_calc = 0
    up_calc = 0

    @bw_down = 0
    @bw_up = 0

    @groups.each do |g|
      down_calc += g.bandwidth[:down]
      up_calc += g.bandwidth[:up]
      @bw_down += g.bandwidth[:bw_down]
      @bw_up += g.bandwidth[:bw_up]
    end

    @total_down = (down_calc).round(2)
    @total_up = (up_calc).round(2)

    @bw_up = @bw_up.round(5)
    @bw_down = @bw_down.round(5)
  end

  def uptime_partial
    uptime
  end
end
