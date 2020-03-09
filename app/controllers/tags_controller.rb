class TagsController < ApplicationController
  def index
    @tags = Tag.all.order({ :created_at => :desc })

    render({ :template => "tags/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @tag = Tag.where({:id => the_id }).at(0)

    render({ :template => "tags/show.html.erb" })
  end

  def create
    @tag = Tag.new
    @tag.wine_id = params.fetch("wine_id_from_query")
    @tag.user_id = params.fetch("user_id_from_query")
    @tag.tag = params.fetch("tag_from_query")

    if @tag.valid?
      @tag.save
      redirect_to("/tags", { :notice => "Tag created successfully." })
    else
      redirect_to("/tags", { :notice => "Tag failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @tag = Tag.where({ :id => the_id }).at(0)

    @tag.wine_id = params.fetch("wine_id_from_query")
    @tag.user_id = params.fetch("user_id_from_query")
    @tag.tag = params.fetch("tag_from_query")

    if @tag.valid?
      @tag.save
      redirect_to("/tags/#{@tag.id}", { :notice => "Tag updated successfully."} )
    else
      redirect_to("/tags/#{@tag.id}", { :alert => "Tag failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @tag = Tag.where({ :id => the_id }).at(0)

    @tag.destroy

    redirect_to("/tags", { :notice => "Tag deleted successfully."} )
  end
end