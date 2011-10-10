module MessagesHelper
  def users_first_name(x)
    User.where("id = ?",x).first
  end
 
  def message_receiver(receive)
    User.where("id=?",receive)
  end
 def user_sender(sender_id)
   User.where("id=?",sender_id)
 end
end
