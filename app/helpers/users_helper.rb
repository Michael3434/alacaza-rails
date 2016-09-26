module UsersHelper
  def status_collection
    ["Copropriétaire", "Locataire"].map { |status| [status, status]}
  end

  def sex_collection
    ["Homme", "Femme"].map { |sex| [sex, sex]}
  end

  def users_from_same_building
    User.where(building_id: current_user.building_id).where.not(id: current_user.id).map { |user| [user.name, user.id] }
  end

  def users_that_can_be_add_in_channel
    users_already_in = @channel.users.pluck(:id)
    User.where(building_id: current_user.building_id).where.not(id: users_already_in).map { |user| [user.name, user.id] }
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
