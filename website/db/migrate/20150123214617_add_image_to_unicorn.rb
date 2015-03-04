class AddImageToUnicorn < ActiveRecord::Migration
 def self.up
    add_attachment :unicorns, :image
  end

  def self.down
    remove_attachment :unicorns, :image
  end
end
