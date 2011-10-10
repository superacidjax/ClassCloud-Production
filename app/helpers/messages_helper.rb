module MessagesHelper
  def users_first_name(x)
    User.where("id = ?",x).first
  end
 
  def message_receiver(receive)
    User.where("id=?",receive)
  end
<<<<<<< HEAD
 def user_sender(sender_id)
   User.where("id=?",sender_id)
 end
=======
  
  def user_sender(sender_id)
    User.where("id=?",sender_id)
  end
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end
