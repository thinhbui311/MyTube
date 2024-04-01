class CreateVideo < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.belongs_to :user
      t.string :title
      t.text :description
      t.text :embed_html
      t.datetime :published_at
      t.string :channel_title
      t.string :thumbnail_url
      t.string :source_url
      t.integer :view_count
      t.integer :like_count
      t.integer :dislike_count
      t.integer :favorite_count
      t.integer :comment_count

      t.timestamps
    end
  end
end
