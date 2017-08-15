require 'rails_helper'

RSpec.feature "Adding a region" do 

	before {visit new_region_path}

	scenario "Passes properly" do

		fill_in "region[name]", with: "New Region Name"
		click_button "Add Region"

		within("div.alert-success") do
			expect(page).to have_content "The region was added"
		end

		expect(page).to have_link "New Region Name"
	end

	scenario "fails with a blank name" do

		click_button "Add Region"

		within("div.alert-warning") do
			expect(page).to have_content "The region was not added"
		end

		within("div.errors") do
			expect(page).to have_content "Name can't be blank"
		end
	end

	scenario "fails with a too short (3 digit) name" do

		fill_in "region[name]", with: "a" * 3
		click_button "Add Region"

		within("div.errors") do
			expect(page).to have_content "1 error prevented this region from being saved"
			expect(page).to have_content "Name is too short"
		end
	end

	scenario "fails with a duplicated name" do

		Region.create(name: "Test Region")
		fill_in "region[name]", with: "Test REGION"
		click_button "Add Region"

		within("div.errors") do
			expect(page).to have_content "Name has already been taken"
		end
	end
end