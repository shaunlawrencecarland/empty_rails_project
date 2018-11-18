class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :path
      t.string :slug
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
