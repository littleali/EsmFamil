client = new Faye.Client('/faye')

client.subscribe '/chat', (payload)->
#  time = moment(payload.created_at).format('D/M/YYYY H:mm:ss')
#  time = payload.created_at
  time = 'ss'
  # You probably want to think seriously about XSS here:
#  alert("SS #{payload.message}")
  $('#chat').append("<li>#{time} : #{payload.message}</li>")

$(document).ready ->
  input = $('#message')
  button = $('#submit')
  $('#alaki_form').submit (event) ->
    button.attr('disabled', 'disabled')
    button.val('Posting...')
    publication = client.publish '/chat',
      message: input.val()
      created_at: new Date()
    publication.callback ->
      input.val('')
      button.removeAttr('disabled')
      button.val("Post")
    publication.errback ->
      button.removeAttr('disabled')
      button.val("Try Again")
    event.preventDefault()
    false

# in case anyone wants to play with the inspector.
window.client = client