module HomeHelper
  def buildings
    ["jean-richepin", "bateliers", "elzevir"]
  end

  def buildings_name(name)
    case name
    when "elzevir"
      "Rue Elzevir"
    when "jean-richepin"
      "Rue Jean-Richepin"
    when "bateliers"
      "Rue des Bateliers"
    end

  end

  def buildings_collection
    [ ["12 rue Jean Richepin", Building.find_by_slug("12-rue-jean-richepin").id],
      ["3 rue Elzevir", Building.find_by_slug("3-rue-elzevir").id],
      ["10 rue des Bateliers", Building.find_by_slug("10-rue-des-bateliers").id]
    ]
  end

  def url_for_city(city)
    if current_user
      facebook_url(city)
    else
      new_user_registration_path(city: city)
    end
  end
end
