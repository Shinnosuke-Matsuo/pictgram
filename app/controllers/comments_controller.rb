class CommentsController < ApplicationController
  def index
    @comment_topics = current_user.comment_topics
  end

  def new
    @comment = Comment.new
    @comment.topic_id = params[:topic_id]
  end

  def create
    @comment = Comment.new(description: params[:comment][:description])
    @comment.user_id = current_user.id
    @comment.topic_id = params[:comment][:topic_id]

    if @comment.save
      redirect_to topics_path, success: 'コメントに成功しました'
    else
      redirect_to topics_path, danger: 'コメントに失敗しました'
    end
  end

  private
  def comment_params
    params.require(:topic).permit(:image, :description)
  end
end
