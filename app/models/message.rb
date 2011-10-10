require 'ancestry'

module ActsAsMessageable
  class Message < ::ActiveRecord::Base
    has_ancestry
    has_many :message_files
    belongs_to :received_messageable, :polymorphic => true
    belongs_to :sent_messageable, :polymorphic => true

    attr_accessible :topic,
      :body,
      :received_messageable_type,
      :received_messageable_id,
      :sent_messageable_type,
      :sent_messageable_id,
      :opened,
      :recipient_delete,
      :sender_delete,
      :recipient_permanent_delete,
      :sender_permanent_delete,
      :created_at,
      :updated_at,
      :file_file_name,
      :file_content_type,
      :file_file_size,
      :file_updated_at

    attr_accessor :removed
    cattr_accessor :required

    # Sample documentation for scope
    default_scope order(:created_at)
    scope :are_from, lambda { |*args| where("sent_messageable_id = :sender", :sender => args.first) }
    scope :are_to, lambda { |*args| where("received_messageable_id = :receiver", :receiver => args.first) }
    scope :with_id, lambda { |*args| where("id = :id", :id => args.first) }

    scope :connected_with, lambda { |*args| where("(sent_messageable_type = :sent_type and
sent_messageable_id = :sent_id and
sender_delete = :s_delete and sender_permanent_delete = :s_perm_delete) or
(received_messageable_type = :received_type and
received_messageable_id = :received_id and
recipient_delete = :r_delete and recipient_permanent_delete = :r_perm_delete)",
        :sent_type => args.first.class.name,
        :sent_id => args.first.id,
        :received_type => args.first.class.name,
        :received_id => args.first.id,
        :r_delete => args.last,
        :s_delete => args.last,
        :r_perm_delete => false,
        :s_perm_delete => false)
    }
    scope :readed, lambda { where("opened = :opened", :opened => true) }
    scope :unread, lambda { where("opened = :opened", :opened => false) }
    scope :deleted, lambda { where("recipient_delete = :r_delete AND sender_delete = :s_delete",
        :r_delete => true, :s_delete => true)}

    def open?
      self.opened?
    end

    def open
      update_attributes!(:opened => true)
    end

    def mark_as_read
      open
    end

    def close
      update_attributes!(:opened => false)
    end

    def mark_as_unread
      close
    end

    def from
      sent_messageable
    end

    def to
      received_messageable
    end

    def conversation
      root.subtree
    end

    def delete
      self.removed = true
    end
    
    has_attached_file :file,
      :content_type => ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' , 'text/plain'  ,'application/zip' , 'application/x-rar' ,'application/msword' , 'application/vnd.ms-excel' ],
      :url => ':basename.:extension',
      :path => ':rails_root/tmp/data/:basename.:extension '
    validates_attachment_content_type :file, :content_type =>
      ['image/png' ,'image/jpeg', 'image/gif', 'application/pdf' , 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ,'text/plain' ,'application/zip' , 'application/x-rar',  'application/msword' , 'application/vnd.ms-excel' ]
    validates_attachment_size :file, :less_than => 10.megabytes
<<<<<<< HEAD

=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  end
end