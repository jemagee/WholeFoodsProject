require 'rails_helper'

RSpec.feature "Adding an Item" do

	let!(:company) {FactoryGirl.create(:company)}
	let!(:brand) {FactoryGirl.create(:brand, company: company)}
	let!(:brand2) {FactoryGirl.create(:brand, company: company)}

	before do

		visit company_path(company)
		visit brand_path(brand2)
		click_link "Add Item to Brand"

	end

	scenario "works properly" do

		fill_in "item[name]", with: "New Item Name"
		fill_in "item[number]", with: 12345
		click_button "Add Item"

		expect(current_path).to eq brand_path(brand2)
		within("div.alert-success") do
			expect(page).to have_content "The item was added to the brand"
		end
		within("div#items") do
			expect(page).to have_content("New Item Name")
		end
	end
end