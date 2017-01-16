module ServicesHelper
  def services_categories_collection
    Service::CATEGORY
  end

  def price_formated(model)
    if model.price.present?
      model.price
    else
      "Sur demande"
    end
  end
end

