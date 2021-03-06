class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.where({ :end_date => nil }).all.order({ :created_at => :desc })

    @location_info = "your cellar"

    render({ :template => "inventories/index.html.erb" })
  end


  def index_chicago
    @inventories = Inventory.where({ :location => "Chicago" }).where({ :end_date => nil}).all.order({ :created_at => :desc })

    @location_info = "Chicago"

    render({ :template => "inventories/index.html.erb" })
  end

  def index_sf
    @inventories = Inventory.where({ :location => "SF" }).where({ :end_date => nil}).all.order({ :created_at => :desc })

    @location_info = "SF"
    
    render({ :template => "inventories/index.html.erb" })
  end

  def index_drank
    @inventories = Inventory.where.not({ :end_date => nil}).all.order({ :created_at => :desc })

    render({ :template => "inventories/drank.html.erb" })
  end

  def index_all
    @inventories = Inventory.all.order({ :end_date => :asc })

    render({ :template => "inventories/all_historical.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @inventory = Inventory.where({:id => the_id }).at(0)
    
    wine_id = @inventory.fetch(:wine_id)
    @wine = Wine.where({:id => wine_id}).at(0)

    @alive = @inventory.alive
    
    tags = Tag.where({ :wine_id => wine_id })
    @tags_count = tags.count
    if @tags_count != 0
      @tags = tags.pluck(:tag)
    end

    @avg_rating = @inventory.avg_rating

    @comments = @inventory.comments_array
    @comments_count = @comments.count

    render({ :template => "inventories/show.html.erb" })
  end

  def new
    render({ :template => "inventories/new.html.erb" })
  end

  def create
    ## check whether the wine exists in the wine table
    wine_check_vintage = params.fetch("vintage_from_query")
    wine_check_vineyard = params.fetch("vineyard_from_query")
    wine_check_blend = params.fetch("blend_from_query")
    wine_check = Wine.where({ :vintage => wine_check_vintage }).where({ :vineyard => wine_check_vineyard}).where({ :blend => wine_check_blend})
    
    if wine_check.any?
    ## if exists, then match it to that wine_id
      @wine = wine_check.at(0)
    ## if not, create a new one
    else 
      @wine = Wine.new
      @wine.vintage = params.fetch("vintage_from_query")
      @wine.vineyard = params.fetch("vineyard_from_query")
      @wine.blend = params.fetch("blend_from_query")
      @wine.external_url = params.fetch("external_url_from_query")
      @wine.photo_url = params.fetch("photo_url_from_query")
      @wine.expert_rating = params.fetch("expert_rating_from_query")
      @wine.expert_notes = params.fetch("expert_notes_from_query")
      
      if @wine.valid?
        then @wine.save
      else
        redirect_to("/inventories/new", { :notice => "Wine failed to create successfully." })
      end
    end

    @inventory = Inventory.new
    @inventory.wine_id = @wine.id
    @inventory.owner_id = @current_user.id
    @inventory.location = @current_user.location
    @inventory.price = params.fetch("price_from_query")

    if @inventory.valid?
      @inventory.save
      redirect_to("/inventories", { :notice => "Inventory created successfully." })
    else
      redirect_to("/inventories/new", { :notice => "Inventory failed to create successfully." })
    end
  end

  def change 
    the_id = params.fetch("id_from_path")
    @inventory = Inventory.where({:id => the_id }).at(0)

    render({ :template => "inventories/edit.html.erb" })
  end

  def update
    the_id = params.fetch("id_from_path")
    @inventory = Inventory.where({ :id => the_id }).at(0)

    @inventory.location = params.fetch("location_from_query")
    @inventory.price = params.fetch("price_from_query")

    if @inventory.valid?
      @inventory.save
      redirect_to("/inventories/#{@inventory.id}", { :notice => "Inventory updated successfully."} )
    else
      redirect_to("/inventories/#{@inventory.id}", { :alert => "Inventory failed to update successfully." })
    end
  end

  def remove
    the_id = params.fetch("id_from_path")
    @inventory = Inventory.where({ :id => the_id }).at(0)
    @inventory.end_date = Date.today

    if @inventory.valid?
      @inventory.save
      redirect_to("/inventories/#{@inventory.id}", { :notice => "Inventory updated successfully."} )
    else
      redirect_to("/inventories/#{@inventory.id}", { :alert => "Inventory failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @inventory = Inventory.where({ :id => the_id }).at(0)

    @inventory.destroy

    redirect_to("/inventories", { :notice => "Inventory deleted successfully."} )
  end
end
