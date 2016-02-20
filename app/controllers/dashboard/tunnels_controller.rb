class Dashboard::TunnelsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]

  include Dashboard::TunnelsHelper

  layout "dashboard"

  def index
    @entrances = Entrance.all.collect {|entrance| [entrance.name, entrance.id]}

    @tunnels = Tunnel.where(user_id: current_user.id).all

    @tunnel = Tunnel.new
  end

  def create
    entrance_port = distr_port_by_entrance_id(tunnel_params[:entrance_id])
    tunnel_params.store("entrance_port", entrance_port)

    @tunnel = Tunnel.new(tunnel_params)

    if @tunnel.save
      BuildTunnelsJob.perform_later @tunnel
      redirect_to dashboard_tunnels_url
    else
      flash[:error] = "表单存在拼写错误"
      redirect_to dashboard_tunnels_url
    end
  end

  def destroy
    DestroyTunnelsJob.perform_later params[:id]

    Tunnel.find(params[:id]).destroy
    flash[:success] = "通道已被删除"
    redirect_to dashboard_tunnels_url
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

    # 确保用户已登录
    def logged_in_user
      unless user_signed_in?
        flash[:danger] = "请先登录"
        redirect_to new_user_session_url
      end
    end
end
