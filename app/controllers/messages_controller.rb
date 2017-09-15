class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :init_recipient, only: [:new, :create]
  before_action :init_conversation, only: [:new, :create]
  before_action :find_conversation, only: [:show]

  DEFAULT_PER_PAGE = 10.freeze

  layout 'profile'

  def index
    @conversations = current_user.conversations.includes(:sender, :recipient)
                                 .paginate(per_page: DEFAULT_PER_PAGE, page: params[:page])
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new
    @message.user = current_user
    @message.body = params[:body]
    if @message.save
      redirect_to messages_path
    else
      flash[:error] = @message.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @conversation.messages.where('read IS NULL AND user_id <> ?', current_user.id)
                          .update_all(read: true)
    @messages = @conversation.messages.order('id DESC')
                             .includes(:user)
                             .paginate(per_page: DEFAULT_PER_PAGE, page: params[:page])
    @recipient = @conversation.rcpt(current_user)
  end

  private

  def init_recipient
    @recipient = User.find(params[:user_id]) if params[:user_id].present?
  end

  def init_conversation
    @conversation = Conversation.between(current_user.id, @recipient.id).first
    if @conversation.blank?
      @conversation = Conversation.create!(sender: current_user,
                                           recipient: @recipient)
    end
  end

  def find_conversation
    @conversation = Conversation.find(params[:id])
  end
end
