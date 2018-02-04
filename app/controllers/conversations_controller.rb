class ConversationsController < ApplicationController

  def index
    # .mailbox is actualyl ALL of the mailboxes (inbox, trash, conversations etc..)
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    @recipients = User.all - [current_user]
    # @recipients = User.all.except(current_user)
  end

  def create
    #dont even need @instance variable, wont use it in view
    recipient = User.find(params[:user_id ])
    receipt = current_user.send_message(recipient, params[:body], params[:subject])

    redirect_to conversation_path(receipt.conversation)
  end


  def foo
    "<div> <h1> hola </h1> </div>".html_safe
  end
  helper_method :foo
  #call from view

end