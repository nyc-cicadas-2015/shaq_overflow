class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :body, null: false
      t.integer :respondable_id, null: false
      t.string :respondable_type, null: false
      t.references :user, null: false

      t.timestamps null: false
    end
  end
end
