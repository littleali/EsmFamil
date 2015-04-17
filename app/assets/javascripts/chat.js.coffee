## Place all the behaviors and hooks related to the matching controller here.
## All this logic will automatically be available in application.js.
## You can use CoffeeScript in this file: http://coffeescript.org/
#
client = new Faye.Client('/faye')
window.client = client
#
#client.subscribe '/chat/2', (payload)->
#  time = 'Alaki'#moment(payload.created_at).format('D/M/YYYY H:mm:ss')
#  # You probably want to think seriously about XSS here:
#  $('#chat').append("<li>#{time} : #{payload.message}</li>")
#
#$(document).ready ->
#  input = $('#message')
#  button = $('#submit')
#  $('form').submit (event) ->
#    button.attr('disabled', 'disabled')
#    button.val('Posting...')
#    publication = client.publish '/chat/2',
#      message: input.val()
#      created_at: new Date()
#    publication.callback ->
#      input.val('')
#      button.removeAttr('disabled')
#      button.val("Post")
#    publication.errback ->
#      button.removeAttr('disabled')
#      button.val("Try Again")
#    event.preventDefault()
#    false
#$(document).ready( function() {
#  q_input = $('#message');
#  q_button = $('#submit');
#  $('form').submit ( function(event) {
#    button.attr('disabled', 'disabled')
#    button.val('Posting...')
#    publication = client.publish '/chat/2',
#      message: input.val()
#      created_at: new Date()
#    publication.callback ->
#      input.val('')
#      button.removeAttr('disabled')
#      button.val("Post")
#    publication.errback ->
#      button.removeAttr('disabled')
#      button.val("Try Again")
#    event.preventDefault()
#    false
#});
#};
#);
#
#
## in case anyone wants to play with the inspector.
#window.client = client