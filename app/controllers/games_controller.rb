class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:edit, :update, :destroy, :end_game]


  def show_papers
    @room = Room.find_by(:name => params[:room_name])
    @game = Game.find_by(:id => params[:game_id])
    @papers = Paper.where(:game_id => @game.id)
    render 'papers/index'
  end

  def start
    @room = Room.find(params[:id])
    @game = Game.find_by(:id => params[:game_id])
    # @game.start_time = DateTime.now + 1.minute
    if @room.players.size < 3
        flash[:alert] = "برای شروع بازی باید تعداد اعضای اتاق باید بیشتر از ۲ نفر باشد."
    else
      @game.start_time = DateTime.now + 10.seconds
      @game.room.players.each do |p|
        unless @game.room.players.include? p
          paper = Paper.new
          paper.owner = p
          paper.game = @game
          paper.save
        end
      end
      @game.update
    end
    render 'rooms/start_game'
    # redirect_to @room
  end

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @room = Room.find(params[:id])
    @game = Game.find_by(:id => params[:game_id])
    @game.calculate_score
    if @game.is_stopped && @game.is_judged 
      render 'result'
    else
      #TODO CREATE PAPER IF THERE IS NO
      @paper = Paper.where(:game_id => @game.id , :owner_id => current_user.profile.id).first
      if not @paper
        @paper = Paper.new
        @paper.owner = current_user.profile
        @paper.game = @game
        @paper.save
      end
    end
  end

  def judgement
    @my_judgment_fields = {}
    @game = Game.find_by(:id => params[:g_id])
    @game.item_names.each do |item_name|
      @my_judgment_fields[item_name] = []
    end
    papers = @game.papers
    #papers = Paper.where(:game_id => @game.id)
    puts(current_user.profile)
   papers.each do |p|
     puts(p.paper_fields.length)
     p.paper_fields.each do |pf|
      if (pf.first_judge == current_user.profile or pf.second_judge == current_user.profile)
        @my_judgment_fields[pf.name]<<pf
      else
        puts(pf.first_judge)
        puts(pf.second_judge)

      end
     end
   end
  end

  # post /games/1/paper/1/item_name
  def save_paper_field
   @paper = Paper.find(params[:p_id])
   paper_filed_ids = @paper.paper_fields.map {|obj| obj.id.to_s}
   @pf = @paper.paper_fields[paper_filed_ids.find_index(params[:pf_id])]
   @pf.value = params["pf.value"]
   @pf.save
  end

  # post /games/1/paper/1
  def submit_paper

  end


  def accept_field
    @paper = Paper.find(params[:p_id])
    @field = @paper.paper_fields.find(params[:pf_id])
    if(@field.first_accept == nil and @field.first_judge == current_user.profile)
      @field.update(:first_accept => true)
    else
      if(@field.second_accept == nil and @field.second_judge == current_user.profile)
        @field.update(:second_accept => true)
      end
    end
    render 'games/judgement'

  end

  def reject_field
    @paper = Paper.find(params[:p_id])
    @field = @paper.paper_fields.find(params[:pf_id])
    if(@field.first_accept == nil and @field.first_judge == current_user.profile)
      @field.update(:first_accept => false)
    else
      if(@field.second_accept == nil and @field.second_judge == current_user.profile)
        @field.update(:second_accept => false)
      end
    end
    render 'games/judgement'
  end

  # GET /games/new
  def new
    @game = Game.new

  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'بازی جدید با موفقیت ساخته شد' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def end_game
    if(@game.first_stopped and @game.first_stop_player_id != current_user.profile.id.to_s )
      @game.update(:stopped => true)
      @game.update(:second_stop_player_id => current_user.profile.id.to_s)
      @game.update(:stop_time => DateTime.now)
      @game.update(:finish_time => DateTime.now + 1.minutes)
      @game.assign_judges()
    else
      if(@game.first_stopped == false)
        @game.update(:first_stopped => true)
        @game.update(:first_stop_player_id => current_user.profile.id.to_s)
        
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :game_id , :room_name, :stopped, :first_stopped, :first_stop_player_id, :second_stop_player_id)
    end
end
