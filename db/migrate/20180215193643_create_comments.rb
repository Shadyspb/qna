class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.string :commented_type
      t.bigint :commented_id
      t.references :user, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
    add_index :comments, %i[commented_id commented_type]
    add_index :comments, %i[commented_id commented_type user_id]
  end
end
