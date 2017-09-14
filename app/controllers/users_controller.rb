class UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'profile'

  DEFAULT_PER_PAGE = 10.freeze

  def index
    if params[:q].present?
      @users = User.all_except(current_user).where('email LIKE ?', "%#{params[:q]}%")
    else
      @users = User
    end
    @users = @users.all_except(current_user)
                   .paginate(per_page: DEFAULT_PER_PAGE, page: params[:page])
  end
end
