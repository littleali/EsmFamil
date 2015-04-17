class ChatMessage
  HISTORY = 20

  attr_accessor :message, :created_at

  def initialize(options = {})
    options.each_pair do |n, v|
      public_send("#{n}=", v)
    end
    self.created_at ||= Time.now
  end

  def push
    self.class.push self
    self
  end

  def self.push(chat_message)
    @chat_messages ||= []
    @chat_messages << chat_message
    @chat_messages.shift if @chat_messages.size > HISTORY
  end

  def self.create(options)
    new(options).tap { |cm| push cm }
  end

  def self.recent
    @chat_messages ||= []
  end
end