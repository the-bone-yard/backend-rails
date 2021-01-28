class AddUsersToParks < ActiveRecord::Migration[5.2]
  def change
    add_reference :parks, :user, foreign_key: true
  end
end
