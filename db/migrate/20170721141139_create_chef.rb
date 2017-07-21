class CreateChef < ActiveRecord::Migration[5.0]
  def change
    create_table :chefs do |t|
      t.string :name
      t.string :email
    end
  end
end
