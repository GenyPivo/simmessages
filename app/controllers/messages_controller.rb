class MessagesController < ApplicationController
  before_action :init_recipient, only: [:new, :create]

  layout 'profile'

  def new
    @message = Message.new
  end

  def create

  end

  private

  def init_recipient
    @recipient = User.find(params[:user_id]) if params[:user_id].present?
  end
end
