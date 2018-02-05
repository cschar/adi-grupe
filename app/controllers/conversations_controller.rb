class ConversationsController < ApplicationController
  before_action :authenticate_user! #, only: [:join]

  def index
    # .mailbox is actualyl ALL of the mailboxes (inbox, trash, conversations etc..)

    # dont show whats in trash
    @conversations = current_user.mailbox.conversations - current_user.mailbox.trash
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

  def set_archived
    #should just move it to index and check for params flags archive/unarchive
    if request.fullpath.ends_with?('trash')
      @conversations = current_user.mailbox.trash
    else
      @conversations = current_user.mailbox.conversations - current_user.mailbox.trash
    end

  end

  def unset_archived
    #should just move it to index and check for params flags archive/unarchive
    if request.fullpath.ends_with?('trash')
      @conversations = current_user.mailbox.trash
    elsif request.fullpath.ends_with?('untrashit') # were in trash lol
      @conversations = current_user.mailbox.trash
    else
      @conversations = current_user.mailbox.conversations - current_user.mailbox.trash
    end
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
    puts params
    puts "FOOOOOOOOO"
    "<div> <h1> hola </h1> </div>".html_safe
  end
  helper_method :foo
  #call from view

  def trash_conversation

    conversation_id = params[:id]
    conversation = current_user.mailbox.conversations.find(conversation_id)
    if conversation
      conversation.move_to_trash(current_user)
    end

  end
  helper_method :trash_conversation

  def untrash_conversation
    conversation_id = params[:id]
    conversation = current_user.mailbox.conversations.find(conversation_id)
    if conversation
      conversation.untrash(current_user)
    end
  end
  helper_method :untrash_conversation

end