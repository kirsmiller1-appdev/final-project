class UserCommentsController < ApplicationController
  def index
    @user_comments = UserComment.all.order({ :created_at => :desc })

    render({ :template => "user_comments/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @user_comment = UserComment.where({:id => the_id }).at(0)

    render({ :template => "user_comments/show.html.erb" })
  end

  def create
    @user_comment = UserComment.new
    @user_comment.user_id = @current_user.id
    @user_comment.wine_id = params.fetch("wine_id_from_query")
    @user_comment.comment = params.fetch("comment_from_query")

    @inventory_id = params.fetch("inventory_id_from_query")

    if @user_comment.valid?
      @user_comment.save
      redirect_to("/inventories/"+@inventory_id, { :notice => "User comment created successfully." })
    else
      redirect_to("/inventories/"+@inventory_id, { :notice => "User comment failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @user_comment = UserComment.where({ :id => the_id }).at(0)

    @user_comment.user_id = @current_user.id
    @user_comment.wine_id = params.fetch("wine_id_from_query")
    @user_comment.comment = params.fetch("comment_from_query")

    if @user_comment.valid?
      @user_comment.save
      redirect_to("/user_comments/#{@user_comment.id}", { :notice => "User comment updated successfully."} )
    else
      redirect_to("/user_comments/#{@user_comment.id}", { :alert => "User comment failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @user_comment = UserComment.where({ :id => the_id }).at(0)

    @user_comment.destroy

    redirect_to("/user_comments", { :notice => "User comment deleted successfully."} )
  end
end
