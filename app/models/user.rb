class User
  include Mongoid::Document

  #attr_accessor :email, :password, :password_confirmation, :remember_me, :fname, :lname, :username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable
  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""


  ## Profile Info
  field :fname,              type: String, default: ""
  field :lname,              type: String, default: ""
  field :username,              type: String
  field :bdate,              type: String



  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  field :locked_at,       type: Time

  class << self
    def serialize_from_session(key, salt)
      record = to_adapter.get(key[0]['$oid'])
      record if record && record.authenticatable_salt == salt
    end
  end

  #Validation
  validates :username, uniqueness: true
  validates_presence_of :username
  validates_presence_of :bdate

  validate :password_complexity
  validate :age_limit

  def password_complexity
    if  (password.match(/^.*[a-z]/).blank?)
      errors.add :password, "حداقل یک حرف کوچک  "
    end
    if  (password.match(/^.*[A-Z]/).blank?)
      errors.add :password, "حداقل یک حرف بزرگ"
    end
    if  (password.match(/^.*\d/).blank?)
      errors.add :password, "خداقل یک عدد!"
    end
  end

  def age_limit
    birth_date = (Parsi::Date.parse bdate).to_gregorian
    if  8.years.ago < birth_date
      errors.add :bdate, "شما کافی نیست!"
    end

  end



end
