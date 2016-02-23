class Admin::EntrancesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  layout 'admin'
  def index
    @entrances = Entrance.all

    @entrance = Entrance.new
  end

  def create
    @entrance = Entrance.new(entrance_params)

    if @entrance.save
      redirect_to admin_entrances_url
    else
      flash[:error] = "表单存在拼写错误"
      redirect_to admin_entrances_url
    end
  end

  private
    def entrance_params
      params.require(:entrance).permit(:name,
                    :name,
                    :domain,
                    :ip,
                    :port,
                    :status
                  )
    end
end
