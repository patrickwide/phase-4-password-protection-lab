class UsersController < ApplicationController
    def create
      user = User.new(user_params)
  
      if user.save
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      if current_user
        render json: current_user, status: :ok
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    def me
        if current_user
          render json: current_user, status: :ok
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
    
      private
    
      def user_params
        params.permit(:username, :password, :password_confirmation)
      end
    
      private
    
      def current_user
        # Implementation of the current_user method
        # You may need to customize this based on your authentication logic
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end
end
  