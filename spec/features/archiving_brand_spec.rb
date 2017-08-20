require 'rails_helper'

RSpec.feature "Archiving a brand" do

	let!(:company) {FactoryGirl.create(:company)}
	let!(:brand) {FactoryGirl.create(:brand, company: company)}
	let!(:brand2) {FactoryGirl.create(:brand, company: company)}

	before {visit brand_path(brand2)}

	scenario "works properly" do

		click_link "Archive Brand"
		
		expect(current_path).to eq company_path(company)
		expect(page).to have_content brand.name
		expect(page).to_not have_content brand2.name
	end
end