class User < ActiveRecord::Base
  has_secure_password

  has_many :auctions, dependent: :nullify
  has_many :bids, dependent: :nullify

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, length: { in: 6..20 }

  def full_name
    "#{first_name} #{last_name}".strip
  end

end