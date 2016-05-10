module MailersHelper
  extend self
  def extracted_body_for_email(message)
    message.gsub!(/\r\n?/, "")
    return message if message.length <= 130
    regex = message.match(/(?<extract>\A(.){130}\S*)/)
    regex["extract"] + "..."
  end
end
