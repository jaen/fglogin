class Address < ActiveRecord::Base
  belongs_to :customer
  before_save :populate_email

  def display_name
    "#{customer}: #{city}"
  end

  def populate_email
    if email.blank?
      self.email = customer.email
    end
  end
end
