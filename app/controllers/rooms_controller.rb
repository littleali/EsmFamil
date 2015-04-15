class RoomsController < ApplicationController
  load_and_authorize_resource
  before_action :set_room, only: [:show, :edit, :update, :destroy , :kick_out]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    redirect_to :action => :show_with_name, :name => @room.name
  end

  def show_with_name
    # @room = Room.find_by_name(params[:name])
    @room = Room.find_by(:name => params[:name])
    render 'rooms/show'
  end

  def kick_out
    kicked_out = Profile.find(params[:user_id])
    @room.players.delete(kicked_out)
    render 'rooms/show'
  end

  def new_game
   @game = Game.new
   render 'games/new'

  end

  def create_game
    @game = Game.new(game_params)
    @room = Room.find_by(:name => params[:name])
    @game.room = @room

    (@room.players).each do |p|
      paper = Paper.new
      paper.owner = p
      paper.game = @game
    end
    respond_to do |format|
      if @game.save
        (@game.papers).each do |p|
          p.save
        end
        format.html { redirect_to @room, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end


  #for URLs
  #def to_param
  #  name
  #end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end



  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    @room.admin = current_user.profile
    @room.players << current_user.profile
    @room.enabled = true
    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'اتاق با موفقیت ساخته شد.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    @room = Room.find params[:id]
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'اتاق با موفقیت به‌روز شد' }
        #format.json { render :show, status: :ok, location: @room }
        format.json { respond_with_bip(@room) }
      else
        format.html { render :edit }
        #format.json { render json: @room.errors, status: :unprocessable_entity }
        format.json { respond_with_bip(@room) }
      end
    end
  end

=begin
  def update
    @user = User.find params[:id]

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@user) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@user) }
      end
    end
  end
=end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.enabled = false
    @room.update
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'اتاق با موفقیت غیر فعال شد.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :capacity)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title)
    end

end
