class Company < ApplicationRecord
	has_many :brands
	
	validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3}
end
