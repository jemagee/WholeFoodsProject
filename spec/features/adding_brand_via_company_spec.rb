require 'rails_helper'

RSpec.feature "Adding a brand to a company from the company page" do

	let!(:company) {FactoryGirl.create(:company)}

	before { visit company_path(company)}

	scenario "works with proper information added" do

		fill_in "Name", with: "New Brand Name"
		fill_in "Prefix", with: 123456
		click_button "Add Brand"

		expect(current_path).to eq company_path(company)
		within("div.alert-success") do
			expect(page).to have_content("The brand was added to the company")
		end
		within("div#brands") do
			expect(page).to have_content("New Brand Name")
		end
	end

	scenario "fails with improper information for brand" do

		click_button "Add Brand"

		within("div.alert-warning") do
			expect(page).to have_content("The brand was not added to the company")
		end

		within("div.errors") do
			expect(page).to have_content "6 errors"
		end
	end
end