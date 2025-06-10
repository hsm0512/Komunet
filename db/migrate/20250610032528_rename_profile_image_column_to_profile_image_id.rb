class RenameProfileImageColumnToProfileImageId < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :profile_image, :profile_image_id
  end
end
