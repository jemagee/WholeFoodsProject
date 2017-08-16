require "rails_helper"

RSpec.feature "Creating a new store" do

	let!(:region) {FactoryGirl.create(:region)}
	let!(:region2) {FactoryGirl.create(:region)}
	let!(:region3) {FactoryGirl.create(:region)}

	before {visit new_store_path}

	scenario "works properly" do

		fill_in "store[number]", with: 12345
		fill_in "store[name]", with: "new store name"
		find("select#store_region_id").select("#{region3.name}")
		click_button "Add Store"

		within("div.alert-success") do
			expect(page).to have_content "The store was added"
		end

		within("#store_name") do
			expect(page).to have_content "New Store Name"
		end
		within("#store_number") do
			expect(page).to have_content 12345
		end
		within("#store_status") do
			expect(page).to have_content "Open"
		end
		within("#store_region") do
			expect(page).to have_content region3.name
		end
	end
end