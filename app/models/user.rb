class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_and_belongs_to_many :meetings, dependent: :destroy
  
  validate :check_email

  def check_email
    if email.include? 'commutatus.com'
    else
      errors.add(:email, 'should be of a commutatus employee')
    end
    
  end
end
