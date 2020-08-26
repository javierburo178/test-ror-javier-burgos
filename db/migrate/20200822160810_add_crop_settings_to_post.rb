class AddCropSettingsToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :crop_settings, :JSON
  end
end
