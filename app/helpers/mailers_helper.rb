module MailersHelper
  extend self
  def extracted_body_for_email(message)
    extract = message.gsub(/(\r|\n)+/, " ")
    if extract.length <= 200
      extract
    else
      regex = extract.match(/(\A.{230}\S*)/)
      regex.captures.first + "..."
    end
  end
end
