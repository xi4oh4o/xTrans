class Dashboard::HowtouseController < ApplicationController
  before_action :authenticate_user!

  layout 'dashboard'
end
