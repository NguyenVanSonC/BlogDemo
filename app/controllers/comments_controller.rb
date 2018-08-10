class CommentsController < ApplicationController
  before_action :find_micropost, except: %i(destroy)
  before_action :find_reply, only: %i(new edit)
  before_action :find_comment, only: %i(destroy edit update)

  def new
    @comment = current_user.comments.build
  end

  def create
    @comment = current_user.comments.build comment_params
    respond_to do |format|
      if @comment.save
        format.html{redirect_to @micropost }
        format.js
      else
        flash[:danger] = t "not-add-comment"
        format.html{render @micropost}
      end
    end
  end

  def destroy
    @comment_id = @comment.id
    respond_to do |format|
      if @comment.destroy
        flash[:success] = t "destroy"
        format.html
        format.js
      else
        flash[:danger] = t "notdestroy"
        format.html
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update_attributes comment_params
        format.html{redirect_to @product}
        format.js
      else
        flash[:danger] = t "not-edit-comment"
        format.html{render @micropost}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :reply_to, :micropost_id
  end

  def find_micropost
    @micropost = Micropost.find_by id: params[:micropost_id]
    valid_object? @micropost
  end

  def find_reply
    @reply_to = params[:comment_id]
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    valid_object? @comment
  end
end
