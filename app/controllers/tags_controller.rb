class TagsController < ApplicationController
  def index
    @tags = Tag.all.order({ :created_at => :desc })

    render({ :template => "tags/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @tag = Tag.where({:id => the_id }).at(0)

    wine_id = @tag.fetch(:wine_id)
    @wine = Wine.where({ :id => wine_id }).at(0)

    render({ :template => "tags/show.html.erb" })
  end

  def create
    @inventory_id = params.fetch("inventory_id_from_query")
    @wine_id = params.fetch("wine_id_from_query")

    tag_attempt = params.fetch("tag_from_query").to_s

    if tag_attempt.length == 0
      redirect_to("/inventories/"+@inventory_id, { :alert => "Tag failed to create successfully." })
    elsif Tag.where({ :wine_id => @wine_id }).where({ :tag => tag_attempt }).at(0).fetch(:id) != nil
      # check if this wine already has this tag
      redirect_to("/inventories/"+@inventory_id, { :alert => "This wine already has this tag" })
    else
      @tag = Tag.new
      @tag.wine_id = @wine_id
      @tag.user_id = @current_user.id
      @tag.tag = params.fetch("tag_from_query")

      if @tag.valid?
        @tag.save
        redirect_to("/inventories/"+@inventory_id, { :notice => "Tag created successfully." })
      else
        redirect_to("/inventories/"+@inventory_id, { :alert => "Tag failed to create successfully." })
      end
    end
  end

  def create_wine
    @wine_id = params.fetch("wine_id_from_query")

    tag_attempt = params.fetch("tag_from_query").to_s

    if tag_attempt.length == 0
      redirect_to("/wines/"+@wine_id, { :alert => "Tag failed to create successfully." })
    elsif Tag.where({ :wine_id => @wine_id }).where({ :tag => tag_attempt }).at(0).fetch(:id) != nil
      # check if this wine already has this tag
      redirect_to("/wines/"+@wine_id, { :alert => "This wine already has this tag" })
    else 
      @tag = Tag.new
      @tag.wine_id = params.fetch("wine_id_from_query")
      @tag.user_id = @current_user.id
      @tag.tag = params.fetch("tag_from_query")

      if @tag.valid?
        @tag.save
        redirect_to("/wines/"+@wine_id, { :notice => "Tag created successfully." })
      else
        redirect_to("/wines/"+@wine_id, { :alert => "Tag failed to create successfully." })
      end
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @tag = Tag.where({ :id => the_id }).at(0)

    @tag.user_id = @current_user.id
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
