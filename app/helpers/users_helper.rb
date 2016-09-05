module UsersHelper
  def status_collection
    ["Co-propriétaire", "Locataire"].map { |status| [status, status]}
  end

  def sex_collection
    ["Homme", "Femme"].map { |sex| [sex, sex]}
  end

  def informations_form
    "<i class='fa fa-info-circle tooltip-large'
        data-toggle='tooltip'
        data-placement='top'
        data-html='true'
        title='Ces informations ne sont pas modifiables afin de certifier
        l’identité des membres inscrits au sein de votre immeuble. Si vous souhaitez
        toutefois les modifier, vous pouvez nous adresser un message privé.'></i>".html_safe
  end

  def user_photo_url(user)
    if user.photo.url
      user.photo.url(:thumb)
    else
      "icons/icon" + user.image_id.to_s + ".png"
    end
  end

  def link_to_new_message_admin
    if channel = current_user.private_channel_with(User.admin)
      link_to "Alacaza Team", appartments_path(@building.slug, channel.id)
    else
      "<a href='#' data-toggle='modal'
                  data-target='#new-message_modal'
                  class='message-sender'
                  data-user-id='#{User.admin}'
                  data-user-name='Alacaza Team'>

       </a>"
    end

  end

end
