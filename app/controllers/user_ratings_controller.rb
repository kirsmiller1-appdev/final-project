class UserRatingsController < ApplicationController
  def index
    @user_ratings = UserRating.all.order({ :created_at => :desc })

    render({ :template => "user_ratings/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @user_rating = UserRating.where({:id => the_id }).at(0)

    render({ :template => "user_ratings/show.html.erb" })
  end

  def create
    @user_rating = UserRating.new
    @user_rating.user_id = params.fetch("user_id_from_query")
    @user_rating.wine_id = params.fetch("wine_id_from_query")
    @user_rating.rating = params.fetch("rating_from_query")

    if @user_rating.valid?
      @user_rating.save
      redirect_to("/user_ratings", { :notice => "User rating created successfully." })
    else
      redirect_to("/user_ratings", { :notice => "User rating failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @user_rating = UserRating.where({ :id => the_id }).at(0)

    @user_rating.user_id = params.fetch("user_id_from_query")
    @user_rating.wine_id = params.fetch("wine_id_from_query")
    @user_rating.rating = params.fetch("rating_from_query")

    if @user_rating.valid?
      @user_rating.save
      redirect_to("/user_ratings/#{@user_rating.id}", { :notice => "User rating updated successfully."} )
    else
      redirect_to("/user_ratings/#{@user_rating.id}", { :alert => "User rating failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @user_rating = UserRating.where({ :id => the_id }).at(0)

    @user_rating.destroy

    redirect_to("/user_ratings", { :notice => "User rating deleted successfully."} )
  end
end
