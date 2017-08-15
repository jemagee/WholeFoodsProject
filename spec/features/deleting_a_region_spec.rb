require "rails_helper"

RSpec.feature "Deleting a region" do

	let!(:region) {FactoryGirl.create(:region)}
	let!(:region2) {FactoryGirl.create(:region)}

	before {visit region_path(region)}

	scenario "works" do

		click_link "Delete Region"

		within("div.alert-success") do
			expect(page).to have_content "The region was deleted"
		end

		expect(page).to have_link region2.name
		expect(page).to_not have_content region.name
	end
end
