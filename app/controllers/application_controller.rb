class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :count_messages

  def count_messages
    return unless current_user
    @unread_count = current_user.unread_messages.count
  end
end
