message = ('<%= j render(partial: "messages/message", locals: { message: @message } ).html_safe %>')
$(".messages-container").slideDown().append(message)
messageTop = $('.msg-container').last().offset().top
$('html, body').animate({scrollTop:messageTop}, 'slow');
$('#message_body').val("")
