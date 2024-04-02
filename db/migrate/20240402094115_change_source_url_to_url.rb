class ChangeSourceUrlToUrl < ActiveRecord::Migration[7.1]
  def change
    rename_column :videos, :source_url, :url
  end
end
