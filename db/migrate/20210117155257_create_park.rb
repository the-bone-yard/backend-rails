# frozen_string_literal: true

class CreatePark < ActiveRecord::Migration[5.2]
  def change
    create_table :parks do |t|
      t.string :name
      t.string :formatted_address
      t.string :opening_hours
      t.string :photo
      t.string :rating
      t.string :email
      t.string :lat
      t.string :lng
    end
  end
end
