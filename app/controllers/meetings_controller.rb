class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:show, :edit, :update, :destroy, :destroyAll]

  # GET /meetings
  # GET /meetings.json
  def index      
      @meetings = current_user.meetings
      @meetings_today = current_user.meetings.where("DATE(start_time) = ?", Date.today)
      @meetings_upcoming = current_user.meetings.where("DATE(start_time) > ?", Date.today)
      @meetings_previous = current_user.meetings.where("DATE(start_time) < ?", Date.today)
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    # raiseStandardError
    respond_to do |format|
      if @meeting.save
        @meeting.users << current_user
        format.html { redirect_to meetings_url, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
        MeetingMailer.with(meeting: @meeting, users: @meeting.users).meeting_scheduled.deliver_now
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|  
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    current_user.meetings.delete(@meeting)
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'You successfully opted out of the meeting' }
      format.json { head :no_content }
    end
  end

  def calendar
    @meetings = current_user.meetings
  end

  def destroyAll
    @meeting.delete

    respond_to do |format|
      format.html { redirect_to home_index_path, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:name, :start_time, :end_time, :room_id, user_ids: [])
    end
end
