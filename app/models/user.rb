class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_voter
  has_many :pictures, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :favourites, dependent: :destroy
  belongs_to :city
  has_many :comments, dependent: :destroy
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum sex: [:male, :female]
  enum education: [:Primary, :Secondary, :College, :University]
  enum income: [:Small, :Middle, :High, :Varying]
  enum accommodation: [:own_apartment, :rent_apartment, :at_parents, :live_with_friend, :rent_house, :ouwn_house]
  enum religion: [:Christianity, :Islam, :Judaism, :Etheism, :Hiduism, :Budaism, :Other]


  scope :online, -> {where("last_seen_at > ? ", 5.minutes.ago)}


  
end
