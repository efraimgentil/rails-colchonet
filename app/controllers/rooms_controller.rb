class RoomsController < ApplicationController
  before_filter :require_authentication, :only => [:new , :edit, :create , :update, :destroy]
  before_action :set_room, only: [ :edit, :update, :destroy]
  

  def index
    @rooms = Room.most_recent.map do |room|
      RoomPresenter.new( room, self , false )
    end
  end

  def show
    room_model = Room.find(params[:id])
    @room = RoomPresenter.new( room_model , self )
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, :notice => t('flash.notice.room_created')
    else
      render action: :new
    end
  end

  def update
    if @room.update(room_params)
      redirect_to @room, :notice => t('flash.notice.room_updated')
    else
      render :action => :edit
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    redirect_to rooms_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = current_user.rooms.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:title, :location, :description)
    end
end
