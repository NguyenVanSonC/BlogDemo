class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  before_action :find_micropost, only: %i(edit update)

  def create
    @micropost = current_user.microposts.build micropost_params
    respond_to do |format|
      if @micropost.save
        format.html{redirect_to current_user}
        format.js
      else
        @feed_items = []
        format.html{render "static_pages/home"}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @micropost.destroy
        flash[:success] = t "destroy"
        format.html{current_user}
        format.js
      else
        format.html{render current_user}
      end
    end

  end

  def edit; end

  def update
    respond_to do |format|
      if @micropost.update_attributes micropost_params
        format.html{redirect_to current_user}
        format.js
      else
        flash[:danger] = t "not-edit"
        format.html{render current_user}
      end
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end

  def find_micropost
    @micropost = Micropost.find_by id: params[:id]
  end
end
