class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  validates :name, presence: true, uniqueness: true
 

  def self.generate_unsplash_photo
    "https://source.unsplash.com/collection/2284026/1600x1200?#{rand(10000000000)}"
  end
end
