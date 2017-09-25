class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  has_many :notes

  def generate_token!
    self.token = Digest::SHA1.hexdigest("#{Time.now}-#{self.id}-#{SecureRandom.hex}")
    self.save!
    self.token
  end
end
