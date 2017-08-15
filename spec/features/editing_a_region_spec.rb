require 'rails_helper'

RSpec.feature "Editing a region" do

	let!(:region) {FactoryGirl.create(:region)}
	let!(:region2) {FactoryGirl.create(:region)}

	before do
		visit regions_path
		click_link region.name
		click_link "Edit Region"
	end

	scenario "works when filled out properly" do

		fill_in "region[name]", with: "Edited Region Name"
		click_button "Update Region"

		within("div.alert-success") do
			expect(page).to have_content "The region was updated"
		end

		expect(page).to have_content "Edited Region Name"
	end

	scenario "fails when a blank name is submitted" do

		fill_in "region[name]", with: ""
		click_button "Update Region"

		within("div.alert-warning") do
			expect(page).to have_content "The region was not updated"
		end

		within("div.errors") do
			expect(page).to have_content "2 errors"
			expect(page).to have_content "Name can't be blank"
			expect(page).to have_content "Name is too short"
		end
	end

	scenario "fails when an existing name is submitted" do

		fill_in "region[name]", with: region2.name.upcase
		click_button "Update Region"

		within("div.errors") do
			expect(page).to have_content "1 error"
			expect(page).to have_content "Name has already been taken"
		end
	end

	scenario "fails when the name is too short (less than 4 characters)" do

		fill_in "region[name]", with: "AAA"
		click_button "Update Region"

		within("div.errors") do
			expect(page).to have_content "Name is too short"
		end
	end
end