class Admin::TunnelsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  layout 'admin'

  def index
    @tunnels = Tunnel.all
  end

end
