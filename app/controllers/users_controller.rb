class UsersController < ApplicationController
  layout 'profile'

  DEFAULT_PER_PAGE = 10.freeze

  def index
    if params[:q].present?
      @users = User.where('email LIKE ?', "%#{params[:q]}%")
    else
      @users = User
    end
    @users = @users.paginate(per_page: DEFAULT_PER_PAGE, page: params[:page])
  end
end
