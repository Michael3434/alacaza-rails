module MailersHelper
  extend self
  def extracted_body_for_email(message)
    extract = message.gsub(/(\r|\n)+/, " ")
    if extract.length <= 230
      extract
    else
      regex = extract.match(/(\A.{230}\S*)/)
      regex.captures.first + "..."
    end
  end

  def name_for_channel(channel)
    case channel.channel_type.to_sym
    when :main_group
      "sur la conversation de votre immeuble"
    when :group
      "sur la conversation #{channel.name}"
    when :private
      "en conversation privée"
    else
      ""
    end
  end
end
