app.gardien ||= {}
app.gardien.messages =
  init: ->
    @initMessageGenerator()
  initMessageGenerator: ->
    $('.plombier').on "click", ->
      obj = new MessageGenerator
      message = obj.generate(this.classList[1])
      $('#sms_content').val(message)
    $('.coupure-d-eau').on "click", ->
      obj = new MessageGenerator
      message = obj.generate(this.classList[1])
      $('#sms_content').val(message)
