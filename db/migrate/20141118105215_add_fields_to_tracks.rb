class AddFieldsToTracks < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.string :image
      t.string :description
    end
  end
end
