class Dashboard::TraceroutesController < ApplicationController
  before_action :authenticate_user!

  layout "dashboard"
end
