class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all.order({ :created_at => :desc })

    render({ :template => "inventories/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @inventory = Inventory.where({:id => the_id }).at(0)

    render({ :template => "inventories/show.html.erb" })
  end

  def create
    @inventory = Inventory.new
    @inventory.wine_id = params.fetch("wine_id_from_query")
    @inventory.owner_id = params.fetch("owner_id_from_query")
    @inventory.location = params.fetch("location_from_query")
    @inventory.price = params.fetch("price_from_query")
    @inventory.end_date = params.fetch("end_date_from_query")

    if @inventory.valid?
      @inventory.save
      redirect_to("/inventories", { :notice => "Inventory created successfully." })
    else
      redirect_to("/inventories", { :notice => "Inventory failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @inventory = Inventory.where({ :id => the_id }).at(0)

    @inventory.wine_id = params.fetch("wine_id_from_query")
    @inventory.owner_id = params.fetch("owner_id_from_query")
    @inventory.location = params.fetch("location_from_query")
    @inventory.price = params.fetch("price_from_query")
    @inventory.end_date = params.fetch("end_date_from_query")

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
