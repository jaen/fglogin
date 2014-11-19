class Subscription < ActiveRecord::Base
  belongs_to :customer
  has_many :preferences


  serialize :lunch
  serialize :dinner

  def display_name
    customer.email
  end

  def lunch_days
    lunch || []
  end

  def lunch_days=(new_lunch_days)
    send(:lunch=, new_lunch_days)
  end

  def dinner_days
    dinner || []
  end

  def dinner_days=(new_dinner_days)
    send(:dinner=, new_dinner_days)
  end
end
