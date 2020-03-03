class MeetingMailer < ApplicationMailer
    helper :application

    default from: 'harshwardhan@commutatus.com'

    def meeting_scheduled
        @meeting = params[:meeting]
        @users = params[:users]
        mail(to: @users.map { |u| u.email }, subject: "New Meeting Confirmation")
    end
end
