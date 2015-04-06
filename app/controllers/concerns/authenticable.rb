module Authenticable
  # Devise methods overwrites
  def current_user
    puts params
    @current_user ||= User.find_by(auth_token: request.headers['Token'])
  end
  
  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless current_user.present?
  end
  
  def user_signed_in?
    current_user.present?
  end
end