class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from chatroom_name
  end

  def talk(data)
    message = Message.new
    message.published_at = Time.current
    message.sender = data.dig("data", "sender")
    message.content = data.dig("data", "content")
    message.save!

    # Messageモデルをレンダリングしてchatroom_channelへブロードキャストする
    ActionCable.server.broadcast chatroom_name, { message: render_message(message) }
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  # Messageモデルをレンダリングするプライベートメソッド
  def render_message(message)
    ApplicationController.render(partial: "messages/message", locals: { message: message })
  end

  def chatroom_name
    "chatroom_#{params[:chatroom_id]}"
  end
end
