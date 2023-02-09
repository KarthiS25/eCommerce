class SessionsController < Devise::SessionsController
    def create
        super
    end

    def destroy
		super do |resource|
			redirect_to new_user_session_path
			return
		end        
    end
end