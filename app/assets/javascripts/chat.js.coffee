client = new Faye.Client('/faye')

#client.subscribe '/chat', (payload)->
##  time = moment(payload.created_at).format('D/M/YYYY H:mm:ss')
##  time = payload.created_at
#  # You probably want to think seriously about XSS here:
##  alert("SS #{payload.message}")
#  $('#chat').append("<p>#{payload.profile_name} : #{payload.message}</p>")

#$(document).ready ->
#  input = $('#message')
#  button = $('#submit')
#  $('#alaki_form').submit (event) ->
#    button.attr('disabled', 'disabled')
#    button.val('Posting...')
#    publication = client.publish '/chat',
#      message: input.val()
#      room_id: '556a162c457869b47f190000'
#      profile_id: '556a19dc457869b5f9010000'
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

# in case anyone wants to play with the inspector.
window.client = client