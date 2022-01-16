class ProfilesController < ApplicationController
  # authentication
  before_action :logged_in_user
  before_action -> { correct_user(params[:user_name]) }
  # set parameters
  before_action -> { set_user(name: params[:user_name]) }

  # GET /users/:user_id/profiles
  def index
  end

  # POST /users/:user_id/profiles
  def update
    respond_to do |format|
      if @user.profile.update(profile_params)
        format.html { redirect_to @user, notice: 'Profile was successfully updated' }
      else
        format.html { render :index, status: :unprocessable_entity, location: @user }
      end
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:name, :bio, :location)
    end
end
