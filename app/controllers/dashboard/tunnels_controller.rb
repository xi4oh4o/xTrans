class Dashboard::TunnelsController < ApplicationController
  layout "dashboard"

  def index
    @entrances = Entrance.all.collect {|entrance| [entrance.name, entrance.id]}

    @entrance_port = '30000'
    @entrance_port = Tunnel.last.entrance_port += 1 unless Tunnel.last.nil?

    @tunnels = Tunnel.all

    @tunnel = Tunnel.new
  end

  def create
    @tunnel = Tunnel.new(tunnel_params)
    if @tunnel.save
      BuildTunnelsJob.perform_later tunnel_params
      redirect_to dashboard_tunnels_url
    else
      render 'new'
    end
  end

  private
    def tunnel_params
      params.require(:tunnel).permit(:name,
                    :user_id,
                    :entrance_id,
                    :entrance_port,
                    :target_address,
                    :destination_port
                  )
    end
end
