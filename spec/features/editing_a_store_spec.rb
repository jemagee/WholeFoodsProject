require 'rails_helper'

RSpec.feature "Editing a Store" do

	let!(:region) {FactoryGirl.create(:region)}
	let!(:region2) {FactoryGirl.create(:region)}
	let!(:region3) {FactoryGirl.create(:region)}

	let!(:store) {FactoryGirl.create(:store, region: region)}
	let!(:store2) {FactoryGirl.create(:store, region: region2)}

	before do
		visit stores_path
		click_link store.name
		click_link "Edit Store"
	end

	scenario "works properly" do

		fill_in "store[name]", with: "New Store Name"
		fill_in "store[number]", with: 0
		find("select#store_region_id").select("#{region3.name}")
		click_button "Update Store"

		within("div.alert-success") do 
			expect(page).to have_content "The store was updated"
		end

		expect(page).to have_content "New Store Name"
	end
end