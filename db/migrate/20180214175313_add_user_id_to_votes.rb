class AddUserIdToVotes < ActiveRecord::Migration[5.1]
  def change
    add_reference :votes, :user, foreign_key: { on_delete: :cascade }
    add_index :votes, %i[appraised_id appraised_type]
    add_index :votes, %i[appraised_id appraised_type user_id], unique: true
  end
end
