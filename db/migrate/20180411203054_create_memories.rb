class CreateMemories < ActiveRecord::Migration[5.1]
  def change
    create_table :memories do |t|
      t.string :name
      t.string :description
      t.integer :city_id
    end
  end
end
