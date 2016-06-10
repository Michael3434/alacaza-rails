module HomeHelper
  def buildings
    Building.all.pluck(:slug)
  end

  def buildings_collection
    Building.all.map do |building|
      [building.name, building.id]
    end
  end

  def url_for_city(city)
    if current_user
      facebook_url(city)
    else
      new_user_registration_path(city: city)
    end
  end
end
