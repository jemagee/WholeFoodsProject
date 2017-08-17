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

	scenario "fails with a blank name" do

		fill_in "store[name]", with: ""
		click_button "Update Store"

		within("div.alert-warning") do
			expect(page).to have_content "The store was not updated"
		end

		within("div.errors") do
			expect(page).to have_content "Store name can't be blank"
		end
	end

	scenario "fails with a blank store number" do
		fill_in "store[number]", with: ""
		click_button "Update Store"

		within("div.errors") do
			expect(page).to have_content "Store number can't be blank"
		end
	end

	scenario "fails with a non-number store number" do
		fill_in "store[number]", with: "d;lfjasdf;lkjasdf;lkadjf"
		click_button "Update Store"

		within("div.errors") do
			expect(page).to have_content "Store number must be a number"
		end
	end

	scenario "fails with a non integer number" do
		fill_in "store[number]", with: 123.456
		click_button "Update Store"

		within("div.errors") do
			expect(page).to have_content "Store number must be an integer"
		end
	end
end