class HomeController < ApplicationController
  before_action :must_be_admin

  def index
    @meetings = Meeting.all
    @users = User.all
  end
  private
  def must_be_admin
    unless current_user.admin?
        redirect_to meetings_path, alert: 'You do not have access'
    end
  end
end

