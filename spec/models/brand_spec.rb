require 'rails_helper'

RSpec.describe Brand, type: :model do
  it {should belong_to(:company)}
  it {should validate_presence_of(:name)}
  it {should validate_length_of(:name).is_at_least(3)}
  it {should validate_uniqueness_of(:name).case_insensitive}
  it {should validate_presence_of(:prefix)}
  it {should validate_numericality_of(:prefix).only_integer}
  it {should validate_inclusion_of(:prefix).in_range(100000..999999)}
  it {should validate_uniqueness_of(:prefix)}
  it {should have_many(:items)}
end
