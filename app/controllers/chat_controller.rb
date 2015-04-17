class ChatController < ApplicationController
  def index
    @chat_messages = ChatMessage.recent
  end

  def write
    Rails.logger.debug "Navid"

    render 'write.js.erb'
  end
end
