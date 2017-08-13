class Company < ApplicationRecord
	validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3}
end
