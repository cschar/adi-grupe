class MessagesController < ApplicationController
  before_action(:set_conversation)


  def create
    # debugger
    # receipt = current_user.reply_to_conversation(@conversation, params[:body])
    # receipt doesnt have a conversation fro some reason
    current_user.reply_to_conversation(@conversation, params[:body])

    redirect_to conversation_path(@conversation)

    # for creating a __new__ conversation
    # receipt = current_user.send_message(recipient, body,  subject)

  end

  private

    def set_conversation
      #params conversation_id available  because we are in a __scoped route__ !!!
      @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
    end
end