class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: %i(home)

  def home
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.by_order.paginate page: params[:page]
  end

  def help; end
end
