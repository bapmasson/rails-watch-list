class RemoveImageUrlFromLists < ActiveRecord::Migration[7.1]
  def change
    remove_column :lists, :image_url, :string
  end
end
