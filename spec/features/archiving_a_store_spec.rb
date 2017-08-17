require "rails_helper"

RSpec.feature "deleting a store" do

	let!(:region) {FactoryGirl.create(:region)}

	let!(:store) {FactoryGirl.create(:store, region: region)}
	let!(:store2) {FactoryGirl.create(:store, region: region)}

	before {visit store_path(store2)}

	scenario "works properly" do

		click_link "Archive Store"

		within("div.alert-success") do
			expect(page).to have_content "The store was successfully archived"
		end

		expect(page).to have_link store.name
		expect(page).to_not have_content store2.name
		visit store_path(store2)

		within("#store_status") do
			expect(page).to have_content "Closed"
		end

	end
end