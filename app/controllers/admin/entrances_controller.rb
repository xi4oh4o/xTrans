class Admin::EntrancesController < ApplicationController
  layout 'admin'
  def index
    @entrances = Entrance.all

    @entrance = Entrance.new
  end
end
