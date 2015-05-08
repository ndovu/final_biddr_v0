class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true, email: true

  has_many :auctions, dependent: :nullify

  def full_name
    "#{first_name} #{last_name}".strip
  end

end