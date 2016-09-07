$(document).on "ready page:load", ->
  app.admin.messages.notifier.init() if $(".admin.messages.notifier").length > 0

app.admin ||= {}
app.admin.messages ||= {}
app.admin.messages.notifier =
  init: ->
    # $('.btn-add').on "click", ->
    #   infos = $('.to-clone').clone()
    #   infos.attr('class', 'cloned')
    #   $(infos).insertAfter('.initial-form')
    #   infos.append('<span class="btn-cancel btn space-left-2"><span class="fa fa-times"></span></span>')
    #   id = $('.cloned').length
    #   infos.find("[id*=admin_recipients_buildings], [id*=admin_pass], input[type=hidden]").prop "name", (index, oldValue) ->
    #     oldValue.replace(/\d+/,id)
    #   $('.to-clone select').select2("val", "");
    #   $('#admin_pass').val("")
    #   $('.btn-cancel').on "click", ->
    #     $(this).closest('.cloned').remove()


