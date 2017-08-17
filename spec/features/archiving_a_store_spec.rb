require "rails_helper"

RSpec.feature "deleting a store" do

	let!(:region) {FactoryGirl.create(:region)}

	let!(:store) {FactoryGirl.create(:store, region: region)}
	let!(:store2) {FactoryGirl.create(:store, region: region)}

	before {visit store_path(store2)}

	scenario "works properly", js: true do


		click_link "Archive Store"

		within("#store_status") do
			expect(page).to have_content "The store has been closed"
		end

		visit stores_path 

		expect(page).to have_link store.name
		expect(page).to_not have_content store2.name


	end
end