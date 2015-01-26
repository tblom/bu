class AddLatitudeAndLongitudeToUnicorn < ActiveRecord::Migration
  def change
    add_column :unicorns, :latitude, :float
    add_column :unicorns, :longitude, :float
  end
end
