class Dashboard::FeedbackController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    @feedback = Feedback.new
  end

  def create

    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      redirect_to dashboard_tunnels_url
    else
      flash[:error] = "表单存在拼写错误"
      redirect_to dashboard_tunnels_url
    end
  end


  private
    def feedback_params
      params.require(:feedback).permit(:username,
                    :user_id,
                    :content
                  )
    end
end
