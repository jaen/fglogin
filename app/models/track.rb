# this should not be needed : |
require_relative '../uploaders/track_image_uploader'

class Track < ActiveRecord::Base
  has_many :preferences

  mount_uploader :image, ::TrackImageUploader

  def display_name
    name
  end
end
