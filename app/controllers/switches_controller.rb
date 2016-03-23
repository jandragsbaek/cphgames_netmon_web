class SwitchesController < ApplicationController
  def edit
    @switches = Switch.order(:source)
    @switches.unshift(Switch.new(source: 'core'))
    @switch = Switch.find(params[:id])
    @groups = Group.order('name')
  end

  def update
    Switch.find(params[:id]).update!(update_params)
    @switches = Switch.order(:ip)
    @groups = Group.order('id DESC').includes(:switches)
  end

  private
  def update_params
    params.require(:switch).permit(:description, :source, :destination, :group_id)
  end
end
