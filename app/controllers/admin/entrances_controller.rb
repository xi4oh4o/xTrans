class Admin::EntrancesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  layout 'admin'
  def index
    @entrances = Entrance.all

    @entrance = Entrance.new
  end
end
