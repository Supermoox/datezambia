class ConversationsController < ApplicationController
  def create
    @conversation = Conversation.get(current_user.id, params[:user_id])

    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end


  def index
    @users_conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))
                             
    unless @users_conversations.blank?
      @users_conversations.each do |conversation|
        unless session[:conversations].nil?
          session[:conversations].delete(conversation.id)
        end
      end
    end
    session[:conversations] ||= []
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.order("created_at DESC")
    @conversations = @conversations.includes(:recipient, :messages).find(session[:conversations])
    @recipients = @users_conversations.all.map { |recipient| recipient.recipient_id }
    @senders = @users_conversations.all.map { |sender| sender.sender_id }
    @total_ids = (@recipients + @senders).uniq
    @users_filterd = User.where(id: @total_ids)
    @users_filterd = @users_filterd.where.not(id: current_user)
    @users_conversations = @users_conversations.uniq
    @temp = 0;
  end


  def close
    @conversation = Conversation.find(params[:id])
    session[:conversations].delete(@conversation.id)
    @messages = Message.where(conversation_id: @conversation.id)
    @user = current_user

    unless @messages.blank?
      @messages.each do |message|
        unless message.user_id == current_user.id
          message.update(read: true)
        end
      end
    end

    respond_to do |format|
      # {render inline: "location.reload();" } temporary for refleshing , should work on a better way
      format.js #{render inline: "location.reload();" }
    end
  end

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end

  private

  def conversation_params
    params.require(:conversation).permit(:sender_id, :recipient_id, :new_message)
  end

end