module LoginHelper
  module Feature
    def login
      visit root_path
      click_link 'Twitterでログイン'
      sleep 0.1
    end
  end

  module Controller
    def login(user)
      session[:user_id] = user.id
    end
  end
end
