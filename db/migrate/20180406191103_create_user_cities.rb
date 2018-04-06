class CreateUserCities < ActiveRecord::Migration[5.1]
  def change
    create_table :user_cities do |t|
      t.integer :user_id
      t.integer :city_id
    end
  end
end
