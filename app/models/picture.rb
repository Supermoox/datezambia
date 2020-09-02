class Picture < ApplicationRecord
	acts_as_votable
	belongs_to :user
	has_many :comments, dependent: :destroy
  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '600x600#'
  }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
