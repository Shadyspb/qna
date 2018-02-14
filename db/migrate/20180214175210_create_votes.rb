class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :vote, default: 0, null: false
      t.string :appraised_type
      t.bigint :appraised_id

      t.timestamps
    end
  end
end
