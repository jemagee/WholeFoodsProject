class Brand < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3}
  validates :prefix, presence: true, numericality: true
end
