class Company < ApplicationRecord
	has_many :brands, inverse_of: :company
	accepts_nested_attributes_for :brands
	
	validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3}
	validates_associated :brands

end
