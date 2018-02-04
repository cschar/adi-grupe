class ConversationsController < ApplicationController

  def index
    # .mailbox is actualyl ALL of the mailboxes (inbox, trash, conversations etc..)
    @conversations = current_user.mailbox.conversations
    Mailboxer::Conversation
  end

  def inbox
    @conversations = current_user.mailbox.inbox
    render action: :index
  end

  def sent
    @conversations = current_user.mailbox.sentbox
    render action: :index
  end

  def trash
    @conversations = current_user.mailbox.trash
    render action: :index
  end

  def show
    # @conversation =
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.mark_as_read(current_user)
  end

  def new
    @recipients = User.all - [current_user]
    # @recipients = User.all.except(current_user)
  end

  def create
    #dont even need @instance variable, wont use it in view
    # recipient = User.find(params[:user_id ])
    recipients = User.where(id: params[:user_ids ])
    receipt = current_user.send_message(recipients, params[:body], params[:subject])

    redirect_to conversation_path(receipt.conversation)
  end


  def foo
    "<div> <h1> hola </h1> </div>".html_safe
  end
  helper_method :foo
  #call from view

end