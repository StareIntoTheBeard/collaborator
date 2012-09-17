class User < ActiveRecord::Base

  has_and_belongs_to_many :roles
  has_many :assignments
  has_many :projects, :through => :assignments
  has_many :topics
  has_many :comments
  has_many :subscriptions
  belongs_to :organization
  default_scope :order => 'email ASC'
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :registration_org_id

  # This is a temporary accessor to validate Org ID against
  attr_accessor :registration_org_id

  # Custom stuff

  #validate it
  validates :registration_org_id, :numericality => true,  :on => :create

  validate :check_org_id, :on => :create

  # We want users only to have ability to register if they're provided with a 
  # psuedo-unique Organization ID that is set up by us on the back end; we only
  # want our own customers signing up.
  def check_org_id
    organization = Organization.find_by_org_id(registration_org_id)

    if organization
      # This is associating the two records with the actual Rails-generated 'ID'. 
      # There are similar fields 'org_id' and 'id' for Organization model.
      # 'org_id' is the number manually generated by us.
      self.organization_id = organization.id
    else
      errors.add(:registration_org_id, "is invalid. Please check the Organization ID and try again.")
    end
  end
 

  def role?(role)
  	return !!self.roles.find_by_name(role.to_s.camelize.downcase)
  end
end
