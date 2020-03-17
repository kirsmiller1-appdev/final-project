class WinesController < ApplicationController
  def index
    @wines = Wine.all.order({ :created_at => :desc })

    render({ :template => "wines/index.html.erb" })
  end

  def index_vintage
    vintage_search = params.fetch("vintage_from_path")
    @wines = Wine.where({ :vintage => vintage_search }).all.order({ :created_at => :desc })

    render({ :template => "wines/vintage.html.erb" })
  end

  def index_vineyard
    vineyard_search = params.fetch("vineyard_from_path")
    @wines = Wine.where({ :vineyard => vineyard_search }).all.order({ :created_at => :desc })

    render({ :template => "wines/vineyard.html.erb" })
  end

  def index_blend
    blend_search = params.fetch("blend_from_path")
    @wines = Wine.where({ :blend => blend_search }).all.order({ :created_at => :desc })

    render({ :template => "wines/blend.html.erb" })
  end

  def index_tag
    @tag = params.fetch("tag_from_path")
    tag_instances = Tag.where({ :tag => @tag}).all
    wines_with_tag = tag_instances.pluck(:wine_id)
    @wines = Wine.where({ :id => wines_with_tag }).all.order({ :created_at => :desc })

    render({ :template => "wines/tag.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @wine = Wine.where({:id => the_id }).at(0)

    render({ :template => "wines/show.html.erb" })
  end

  def create
    @wine = Wine.new
    @wine.vintage = params.fetch("vintage_from_query")
    @wine.vineyard = params.fetch("vineyard_from_query")
    @wine.blend = params.fetch("blend_from_query")
    @wine.expert_rating = params.fetch("expert_rating_from_query")
    @wine.expert_notes = params.fetch("expert_notes_from_query")
    @wine.photo_url = params.fetch("photo_url_from_query")
    @wine.external_url = params.fetch("external_url_from_query")

    if @wine.valid?
      @wine.save
      redirect_to("/wines", { :notice => "Wine created successfully." })
    else
      redirect_to("/wines", { :notice => "Wine failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @wine = Wine.where({ :id => the_id }).at(0)

    @wine.vintage = params.fetch("vintage_from_query")
    @wine.vineyard = params.fetch("vineyard_from_query")
    @wine.blend = params.fetch("blend_from_query")
    @wine.expert_rating = params.fetch("expert_rating_from_query")
    @wine.expert_notes = params.fetch("expert_notes_from_query")
    @wine.photo_url = params.fetch("photo_url_from_query")
    @wine.external_url = params.fetch("external_url_from_query")

    if @wine.valid?
      @wine.save
      redirect_to("/wines/#{@wine.id}", { :notice => "Wine updated successfully."} )
    else
      redirect_to("/wines/#{@wine.id}", { :alert => "Wine failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @wine = Wine.where({ :id => the_id }).at(0)

    @wine.destroy

    redirect_to("/wines", { :notice => "Wine deleted successfully."} )
  end
end
