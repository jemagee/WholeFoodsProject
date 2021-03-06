class Region < ApplicationRecord
	has_many :stores

	validates :name, presence: true, length: {minimum: 4}, uniqueness: {case_sensitive: false}
end
