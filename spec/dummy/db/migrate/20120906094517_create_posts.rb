class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :title
      t.text    :description
      t.string  :url
      t.string  :image_url
      t.boolean :is_published, :default => false
      t.string  :uuid, :null => false

      t.timestamps
    end
  end
end
