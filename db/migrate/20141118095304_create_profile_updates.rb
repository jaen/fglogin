class CreateProfileUpdates < ActiveRecord::Migration
  def change
    create_table :profile_updates do |t|
      t.integer    :state
      t.references :customer, :index => true
      t.text       :lunch,    :array => true
      t.text       :dinner,   :array => true
      t.text       :extra_notes
      t.time       :lunch_time
      t.time       :dinner_time
      t.references :address,  :index => true
      t.integer    :tracks,   :array => true

      t.timestamps
    end
  end
end
