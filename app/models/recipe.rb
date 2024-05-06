class Recipe < ApplicationRecord
  has_many :directions
  has_many :ingredients
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :directions, reject_if: :all_blank,
                                allow_destroy: true

  has_attached_file :image, styles: { medium: "300x300#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :title, presence: true
  validates :description, presence: true
end
