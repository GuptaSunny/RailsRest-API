class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]
  
  def_param_group :user do
    param :user, Hash, :action_aware => true do
      param :email, String, :required => true
      param :password, String, :required => true
      param :password_confirmation, String, :required => true
    end
  end
  
  api :GET, '/users/:id',"Show User"
  def show
    user=User.find(params[:id])
    render json: user, status: 200, location: [:api, user]
  end

  api :POST, '/users', "Create an User"
  param_group :user

  def create
    user = User.new(user_params)
    puts user.inspect
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  api :POST, '/users/:id', "Update an User"
   param_group :user

  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  api :DELETE, '/users/:id',"Delete an User"

  def destroy
    current_user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
