class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :destroy , :update_field]

  # GET /profiles
  # GET /profiles.json
  def index
    # @profiles = Profile.all
    if user_signed_in?
      @profile = current_user.profile
      render :edit
    else
      #TODO remove it
      redirect_to :new_user_registration
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  def update_field
    if @profile.has_attribute?(params[:title])
      @profile.update(params[:title] => params[params[:title]])
    else
      @profile.user.update(params[:title] => params[params[:title]])
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @prfile = Profile.find params[:id]
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'اتاق با موفقیت به‌روز شد' }
        format.json { respond_with_bip(@profile) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@profile) }
      end
    end
  end
  # def update
  #   respond_to do |format|
  #     @profile.user.username = params[:username]
  #     @profile.user.email = params[:email]
  #     if @profile.update(profile_params)
  #       format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @profile }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @profile.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:fname, :lname)
    end
end
