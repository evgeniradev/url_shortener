# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if (verified_user = User.find_by(id: user_id))
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def user_id
      @user_id ||= begin
        cookies
          .encrypted['_url_shortener_session']['warden.user.user.key']
          .first
          .first
      rescue StandardError
        # connection will be rejected if user is not logged in
      end
    end
  end
end
