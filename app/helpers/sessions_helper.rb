module SessionsHelper

def sign_out
   # self.current_user = nil
    cookies.delete(:remember_token)
  end
end
