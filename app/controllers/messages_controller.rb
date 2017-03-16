class MessagesController < ApplicationController

  def index
    @messages = Message.all.order(id: :desc)
  end

  def create
    @message = Message.new message_params
    if @message.save
      ActionCable.server.broadcast 'chat', message: render_message(@message)
      flash[:success] = "Created message"
    else
      flash[:error] = "Error"
    end
    redirect_to messages_path
  end

  private
    def render_message(message)
      ApplicationController.render(partial: 'messages/message', locals: {message: message})
    end

    def message_params
      params.require(:message).permit(:body)
    end
end
