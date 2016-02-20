class Admin::TunnelsController < ApplicationController
  layout 'admin'

  def index
    @tunnels = Tunnel.all
  end
end
