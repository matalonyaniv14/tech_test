class AddImageUrlVideoUrlToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :image_url, :string
    add_column :courses, :video_url, :string
  end
end
