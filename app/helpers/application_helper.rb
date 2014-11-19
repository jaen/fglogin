module ApplicationHelper
  def stars_for_rating(rating)
    wholes  = rating.to_i
    halfs   = (rating - wholes >= 0.5) ? 1 : 0
    empties = 5 - wholes - halfs

    render :partial => 'layouts/stars', :locals => { :wholes  => wholes,
                                                     :halfs   => halfs,
                                                     :empties => empties }
  end
end
