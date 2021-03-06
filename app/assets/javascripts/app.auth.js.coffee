$(document).on "ready page:load", ->
  app.auth.init() if $("#signup_modal").length > 0


# Handler user sign in/up through modal view
app.auth =
  init: ->
    $("form.new_session").submit -> $(this).find("button[type='submit']").css("opacity", 0.4)
    $("form#new_user").submit -> $(this).find("button[type='submit']").css("opacity", 0.4)
    @signup.init()
    @signin.init()
    $('.want-to-signin').click @showsSignIn
    $('.want-to-signup').click @showsSignUp
  signin:
    init: ->
      $(".signin").click @openModal
      $("#signin_modal").on "shown.bs.modal", @formFocus
      $("form.new_session").on "ajax:error", @signinError
      $("form.new_session").on "ajax:success", @signinSuccess
    openModal: (e) ->
      e.preventDefault()
      $("#signin_modal").modal()
    formFocus: ->
      $("#signin_modal #user_email").focus()
    signinError: (e, xhr, status, error) ->
      div = $(this).closest("div").find(".error_explanation")
      alert = $("<div></div>", { class: "alert alert-danger" })
      alert.append("<p>#{xhr.responseJSON.error}</p>")
      div.html(alert)
    signinSuccess: (e, data, status, xhr) ->
      $(this).closest(".modal").modal("hide")
      $('.signout').removeClass('hidden')
      $('.signin').addClass('hidden')
      if data.gardien
        url = window.location.pathname + "gardien/immeubles/" + data.building_slug
      else
        url = window.location.pathname + "immeubles/" + data.building_slug
      window.location.replace(url)
  signup:
    init: ->
      $(".city-picture").click @addCityToSignupForm
      $("form#new_user").on "ajax:error", @signupError
      $("form#new_user").on "ajax:success", @signupSuccess
      $("#signup_modal").on "hidden.bs.modal", @resetModal
    addCityToSignupForm: ->
        city = $(this).data("city")
        $('#user_city').val(city)
    signupError: (e, xhr, status, error) ->
      $(this).render_form_errors('user', xhr.responseJSON.errors)
    signupSuccess: (e, data, status, xhr) ->
      $('.signout').removeClass('hidden')
      $('.signin').addClass('hidden')
      $('.step-1').hide()
      $('.step-2').show()
      url = window.location.pathname + "immeubles/" + data.building_slug
      setTimeout ( -> window.location.replace(url) ), 5000
    resetModal: ->
      $("form#new_user").clear_form_errors()
      $("form.new_session").clear_form_errors()
  showsSignUp: (e) ->
    e.preventDefault()
    $("#signin_modal").modal('hide')
    $("#signup_modal").modal()
  showsSignIn: (e) ->
    e.preventDefault()
    $("#signup_modal").modal('hide')
    $("#signin_modal").modal()
  buildingUrl: (name) ->
      switch name
        when /bateliers/
          "10-rue-des-bateliers"
        when /richepin/
          "12-rue-jean-richepin"
        when /elzevir/
          "3-rue-elzevir"
