class Subscription < ActiveRecord::Base
  belongs_to :customer
  has_many :preferences


  serialize :lunch
  serialize :dinner

  def display_name
    customer.email
  end
end
