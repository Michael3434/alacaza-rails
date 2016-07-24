module HomeHelper
  def buildings
    Building.all.pluck(:slug)
  end

  def url_for_city(city)
    if current_user
      facebook_url(city)
    else
      new_user_registration_path(city: city)
    end
  end
end
