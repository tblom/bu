class CreateUnicorns < ActiveRecord::Migration
  def change
    create_table :unicorns do |t|
      t.string :message

      t.timestamps null: false
    end
  end
end
