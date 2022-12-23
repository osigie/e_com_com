class Api::V1::UsersController < ApplicationController

  before_action :set_user, only: %i[show update destroy]
  before_action :check_owner, only: %i[update destroy]


  # DELETE /users/1
  def destroy
    @user.destroy
    head 204
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      # render json: @user, status: :ok
       render json: UserSerializer.new(@user).serializable_hash.to_json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end


  # GET /users/1
  def show
    # render json: User.find(params[:id])
    render json: UserSerializer.new(@user).serializable_hash.to_json
  end
#   POST  /users
  def create
    @user = User.new({password:params[:password], **user_params})
    if(@user.save)
      # render json: @user, status: :created
       render json: UserSerializer.new(@user).serializable_hash.to_json, status: :created
    else
      puts :show
      render json: @user.errors, status: :unprocessable_entity

    end
  end

# Only allow a trusted parameter "white list" through.
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  private
  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end
end
