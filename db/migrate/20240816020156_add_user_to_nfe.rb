class AddUserToNfe < ActiveRecord::Migration[7.1]
  def change
    add_reference :nfes, :user, null: false, foreign_key: true
  end
end
