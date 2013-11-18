module Authentication
  module ActiveRecordHelpers

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def find_for_oauth(auth)
        # binding.pry
        record = User.find_by(access_token: auth.credentials.token) || where(provider: auth.provider, uid: auth.uid.to_s).first 
        record || create(provider: auth.provider, uid: auth.uid, email: (auth.uid+"@gmail.com") , password: Devise.friendly_token[0,20])
      end
    end
  end
end