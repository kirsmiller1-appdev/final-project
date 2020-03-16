class ChangeExpertRatingToBeFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :wines, :expert_rating, :float
  end
end
