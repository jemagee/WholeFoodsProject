require 'rails_helper'

RSpec.describe Brand, type: :model do
  it {should belong_to(:company)}
end
