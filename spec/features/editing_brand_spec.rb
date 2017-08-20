require 'rails_helper'

RSpec.feature "Editing a brand" do

	let!(:company) {FactoryGirl.create(:company)}
	let!(:brand) {FactoryGirl.create(:brand, company: company)}
	let!(:brand2) {FactoryGirl.create(:brand, company: company)}

	before do
		visit company_path(company)
		click_link brand.name
		click_link "Edit Brand"
	end

	scenario "works properly" do

		fill_in "brand[name]", with: "New Brand Name"
		fill_in "brand[prefix]", with: brand.prefix + 100
		click_button "Update Brand"

		expect(current_path).to eq company_path(company)
		within("div.alert-success") do
			expect(page).to have_content("The brand was updated")
		end
		expect(page).to have_content("New Brand Name")
	end

	scenario "fails with blank name" do

		fill_in "brand[name]", with: ""
		click_button "Update Brand"

		within("div.alert-warning") do
			expect(page).to have_content("The brand was not updated")
		end

		within("div.errors") do
			expect(page).to have_content("2 errors")
			expect(page).to have_content("Name can't be blank")
		end
	end

	scenario "fails with a short name" do

		fill_in "brand[name]", with: "aa"
		click_button "Update Brand"

		within("div.errors") do
			expect(page).to have_content("1 error")
			expect(page).to have_content("Name is too short")
		end
	end

	scenario "fails with a non-unique name" do

		fill_in "brand[name]", with: brand2.name.upcase
		click_button "Update Brand"

		within("div.errors") do
			expect(page).to have_content("Name has already been taken")
		end
	end

	scenario "fails with an empty prefix" do

		fill_in "brand[prefix]", with: ""
		click_button "Update Brand"

		within("div.errors") do
			expect(page).to have_content("3 errors")
			expect(page).to have_content("Prefix can't be blank")
		end
	end

	scenario "fails with a non-unique prefix" do

		fill_in "brand[prefix]", with: brand2.prefix
		click_button "Update Brand"

		within("div.errors") do
			expect(page).to have_content("Prefix has already been taken")
		end
	end

	scenario "fails with a non-number prefix" do

		fill_in "brand[prefix]", with: "abcdef"
		click_button "Update Brand"

		within("div.errors") do
			expect(page).to have_content("Prefix must be a number")
		end
	end

	scenario "fails with a non-integer numerical prefix" do

		fill_in "brand[prefix]", with: 123456.56
		click_button "Update Brand"

		within("div.errors") do
			expect(page).to have_content("1 error")
			expect(page).to have_content("must be an integer")
		end
	end

	scenario "fails with an integer that isn't six digits long" do

		fill_in "brand[prefix]", with: 99999
		click_button "Update Brand"

		within("div.errors") do
			expect(page).to have_content("Prefix must consist of six (only six) integers")
		end
	end
end
