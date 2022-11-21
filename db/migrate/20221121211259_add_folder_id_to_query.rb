class AddFolderIdToQuery < ActiveRecord::Migration[5.2]
  def change
    add_column :queries, :folder_id, :integer
  end
end
