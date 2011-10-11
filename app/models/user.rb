class User < ActiveRecord::Base
  easy_roles :roles
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :token_authenticatable, :confirmable, :lockable, :timeoutable,:omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :user_type, :username, :login, :time_zone
  attr_accessor :is_not_teacher, :user_type, :login, :user_pick_username_and_password
  validates :first_name, :presence => true
  validates :user_type, :presence => true, :if => Proc.new{|user| user.is_not_teacher.eql?(true)}
  validates :username, :presence => true, :if => Proc.new{|user| user.user_pick_username_and_password.eql?(true)}
  validates :username, :uniqueness => true, :if => Proc.new{|user| user.user_pick_username_and_password.eql?(true)}
 
 
  with_options :dependent => :destroy do |user|
    user.has_many :assignments
    user.has_many :comments
    user.has_many :events
    user.has_many :to_dos
    user.has_many :class_rooms
    user.has_many :assignment_students
    user.has_many :class_room_students
    user.has_many :class_room_observers
    user.has_many :notes
    user.has_many :writeboards
    user.has_many :upload_files
  end

  after_create :define_user_role, :if => Proc.new{|user| user.is_not_teacher.eql?(false) || user.is_not_teacher.blank?}

  acts_as_messageable  :table_name => "messages", # default 'messages'
  :required   => [:topic, :body]    ,              # default [:topic, :body]
  :class_name => "ActsAsMessageable::Message"       # default "ActsAsMessageable::Message"  
  acts_as_voter

  USER_TYPE = [
    ["Student", "student"],
    ["Observer", "observer"]
  ]

  def full_name
    "#{first_name} #{last_name}"
  end

  def define_user_role
    self.add_role "teacher"
    self.save
  end

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end
    record
  end

  def self.find_record(login)
    where(["username = :value OR email = :value", { :value => login }]).first
  end

  def self.generate_random_string(size = 8)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end
end
