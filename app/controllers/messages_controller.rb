class MessagesController < ApplicationController

  def index
    @messages = Message.all.order(id: :desc)
  end

  def create
    @message = Message.new message_params
    if @message.save
      flash[:success] = "Created message"
    else
      flash[:error] = "Error"
    end
    redirect_to messages_path
  end

  private
    def message_params
      params.require(:message).permit(:body)
    end
end
