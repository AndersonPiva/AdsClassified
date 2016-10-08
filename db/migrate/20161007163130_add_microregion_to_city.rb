class AddMicroregionToCity < ActiveRecord::Migration
  def change
    add_column :cities, :microregion, :string
  end
end
