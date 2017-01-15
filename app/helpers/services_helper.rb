module ServicesHelper
  def services_categories_collection
    Service::CATEGORY
  end

  def service_price(service)
    if service.price.present?
      service.price
    else
      "Sur demande"
    end
  end
end

