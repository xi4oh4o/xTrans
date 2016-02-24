class Admin::FeedbacksController < ApplicationController
  layout 'admin'
  def index
    @feedbacks = Feedback.where(status: 0).all
  end

  def destroy

    Feedback.find(params[:id]).update(status: 1)
    flash[:success] = "已阅反馈"
    redirect_to admin_feedbacks_url
  end
end
