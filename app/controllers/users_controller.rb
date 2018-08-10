class UsersController < ApplicationController
  before_action :correct_user?, only: %i(edit update)
  before_action :find_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(new create index show)
  before_action :load_microposts, only: %i(show)

  def index
    @users = User.select(:id, :name,
      :email).recent.paginate page: params[:page],
      per_page: Settings.pageuser
  end

  def show
    return if @user
    flash[:notice] = t "notice"
    render :show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = t "info_user"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "destroy"
    else
      flash[:success] = t "notdestroy"
    end
    redirect_to users_url
  end

  def following
    @title = t("following")
    @users = @user.following.paginate page: params[:page]
    render "show_follow"
  end

  def followers
    @title = t("follower")
    @users = @user.followers.paginate page: params[:page]
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user?
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "notfound"
    redirect_to root_url
  end

  def load_microposts
    @microposts = @user.microposts.by_order.paginate page: params[:page],
      per_page: Settings.pagemicropost
    if logged_in?
      @micropost = current_user.microposts.build
    end
  end
end
