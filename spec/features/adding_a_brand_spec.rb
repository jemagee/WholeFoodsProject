require 'rails_helper'

RSpec.feature "Adding a Brand" do 

	let!(:company) {FactoryGirl.create(:company)}
	let!(:company2) {FactoryGirl.create(:company)}
	let!(:company3) {FactoryGirl.create(:company)}

	before {visit new_brand_path}

	scenario "works properly" do

		fill_in "brand[name]", with: "New Brand Name"
		fill_in "brand[prefix]", with: 123456
		find("select#brand_company_id").select("#{company2.name}")
		click_button "Add Brand"

		within("div.alert-success") do
			expect(page).to have_content("The brand has been added")
		end
		expect(current_path).to eq company_path(company2)
		within("div#brands") do
			expect(page).to have_content("New Brand Name")
		end
	end
end