module ApplicationHelper
  def embedded_svg(filename, options={})
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

  def devise_mapping
    Devise.mappings[:user]
  end

  def namespace_name
    params[:controller].match(/(?<namespace>.*)\//).try(:[],"namespace")
  end

  def admin_namespace?
    namespace_name == "admin"
  end

  def resource_name
    devise_mapping.name
  end

  def resource_class
    devise_mapping.to
  end

  def js_error_message(model)
    message = "Veuillez corriger les erreurs suivantes :\n"
    model.errors.messages.each do |field, errors|
      errors.each do |error|
        message += "- #{error}\n"
      end
    end
    escape_javascript message
  end

  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
              concat content_tag(:button, '&times;'.html_safe, class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

end
