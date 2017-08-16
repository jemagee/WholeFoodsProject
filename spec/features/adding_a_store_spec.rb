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

	scenario "does not succeed  with a blank name" do

		fill_in "store[number]", with: 12345
		find("select#store_region_id").select("#{region3.name}")
		click_button "Add Store"

		within("div.alert-warning") do
			expect(page).to have_content "The store was not entered"
		end

		within("div.errors") do
			expect(page).to have_content "2 errors prevented this store from being saved"
			expect(page).to have_content "Store name can't be blank"
		end
	end

	scenario "does not succeed with a taken name" do

		Store.create(name: "Existing Store Name", region: region2, number: 54321)
		fill_in "store[name]", with: "Existing STORE name"
		fill_in "store[number]", with: 12345
		find("select#store_region_id").select("#{region3.name}")
		click_button "Add Store"

		within("div.errors") do
			expect(page).to have_content "Store name has already been taken"
		end
	end

	scenario "does not succeed with a blank store number" do

		fill_in "store[name]", with: "New Store"
		find("select#store_region_id").select("#{region3.name}")
		click_button "Add Store"

		within("div.errors") do
			expect(page).to have_content "Store number can't be blank"
		end
	end

	scenario "does not succeed with a non number store number" do

		fill_in "store[name]", with: "New Store"
		fill_in "store[number]", with: "abcdef"
		find("select#store_region_id").select("#{region3.name}")
		click_button "Add Store"

		within("div.errors") do
			expect(page).to have_content "Store number must be a number"
		end
	end

	scenario "does not succeed without a region being selected" do

		fill_in "store[number]", with: 12345
		fill_in "store[name]", with: "new store name"
		click_button "Add Store"

		within("div.errors") do
			expect(page).to have_content "Region must exist"
		end
	end
end	