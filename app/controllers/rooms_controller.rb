class RoomsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_room, only: [:show, :edit, :update, :destroy , :kick_out]
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.any_of( {:_id.in => current_user.profile.playing_rooms.map{ |u| u._id.to_s}}, {:is_private => false })
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    # redirect_to :action => :show_with_name, :name => @room.name
  end

  def show_with_name
    ## @room = Room.find_by_name(params[:name])
    # @room = Room.find_by(:name => params[:name])
    # render 'rooms/show'
  end

  def send_invitation
    new_member = Profile.find(params[:profile_id])
    if @room.players.include? new_member
      flash[:notice] ="این کاربر عضو اتاق است "
      render 'rooms/member_already_exist.js.erb'
    elsif (@room.players.length ==@room.capacity)
      flash[:notice] ="ظرفیت اتاق تکمیل است"
      render 'rooms/capacity_full.js.erb'
    elsif !(@room.pending_players.include? new_member)
      @room.pending_players << new_member
      @player = new_member
      flash[:notice] ="درخواست ارسال شد"
      render 'rooms/invite_member.js.erb'
    else 
      flash[:notice] ="درخواست شما قبلا به این آدم ارسال شده است"
      render 'rooms/invitaion_already_sent.js.erb'
    end

  end



  def accept_invitation
    @profile = Profile.find(params[:p_id])
    @room = Room.find(params[:r_id])
    @room.pending_players.delete(@profile)
    @room.players << @profile
    @room.update
    render 'rooms/accept_invitation.js.erb'
  end
  def reject_invitation
    @profile = Profile.find(params[:p_id])
    @room = Room.find(params[:r_id])
    @room.pending_players.delete(@profile)
    @room.update
    render 'rooms/reject_invitation.js.erb'
  end

  def join
    if (@room.players.length ==@room.capacity)
      flash[:notice] ="ظرفیت اتاق تکمیل است"
      render 'rooms/capacity_full.js.erb'
    else
      new_member = current_user.profile
      @room.players << new_member
      @player = new_member
      render 'rooms/join.js.erb'
    end
  end

  def kick_out
    kicked_out = Profile.find(params[:profile_id])
    @room.players.delete(kicked_out)
    @player = kicked_out
    render 'rooms/kick_out.js.erb'
  end

  def leave
    kicked_out = current_user.profile
    @room.players.delete(kicked_out)
    @player = kicked_out
    render 'rooms/leave.js.erb'
  end

  def new_game
   @game = Game.new
   render 'games/new'

  end

  def create_game
    @game = Game.new(game_params)
    @room = Room.find(params[:id])
    @game.room = @room

    (@room.players).each do |p|
      paper = Paper.new
      paper.owner = p
      paper.game = @game
    end
    if @game.save
      (@game.papers).each do |p|
        p.save
      end
      render 'create_game.js.erb'
    else
      render 'create_game.js.erb'
    end

  end



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


  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.enabled = false
    @room.update
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'اتاق با موفقیت غیرفعال شد.' }
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
      params.require(:room).permit(:name, :capacity,:is_private)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title)
    end

end
