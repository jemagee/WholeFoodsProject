require 'rails_helper'

RSpec.feature "Adding a Brand" do 

	let!(:company) {FactoryGirl.create(:company)}
	let!(:company2) {FactoryGirl.create(:company)}
	let!(:company3) {FactoryGirl.create(:company)}

	before {visit new_brand_path}

	scenario "works properly" do

		fill_in "brand[name]", with: "New Brand Name"
		fill_in "brand[prefix]", with: 123456
		find("select#brand_company_id").select("#{company2.name}")
		click_button "Add Brand"

		within("div.alert-success") do
			expect(page).to have_content("The brand has been added")
		end
		expect(current_path).to eq company_path(company2)
		within("div#brands") do
			expect(page).to have_content("New Brand Name")
		end
	end

	scenario "fails without a name" do

		fill_in "brand[prefix]", with: 123456
		find("select#brand_company_id").select("#{company2.name}")
		click_button "Add Brand"

		within("div.alert-warning") do
			expect(page).to have_content("The brand was not added")
		end
		within("div.errors") do
			expect(page).to have_content("2 errors")
			expect(page).to have_content("Name can't be blank")
		end
		expect(page).to_not have_selector("div#brands")
	end

	scenario "fails with a too short (less than 3) name" do

		fill_in "brand[name]", with: "Ne"
		fill_in "brand[prefix]", with: 123456
		find("select#brand_company_id").select("#{company2.name}")
		click_button "Add Brand"

		within("div.errors") do
			expect(page).to have_content("1 error")
			expect(page).to have_content("Name is too short")
		end
	end

	scenario "fails without a prefix" do

		fill_in "brand[name]", with: "New Brand Name"
		find("select#brand_company_id").select("#{company2.name}")
		click_button "Add Brand"

		within("div.errors") do
			expect(page).to have_content("3 errors")
			expect(page).to have_content("Prefix can't be blank")
		end
	end

	scenario "fails with a non integer prefix" do

		fill_in "brand[name]", with: "New Brand Name"
		fill_in "brand[prefix]", with: 123456.56
		find("select#brand_company_id").select("#{company2.name}")
		click_button "Add Brand"

		within("div.errors") do
			expect(page).to have_content ("1 error")
			expect(page).to have_content ("must be an integer")
		end
	end

	scenario "fails with an integer too large" do

		fill_in "brand[name]", with: "New Brand Name"
		fill_in "brand[prefix]", with: 1000000
		find("select#brand_company_id").select("#{company2.name}")
		click_button "Add Brand"

		within("div.errors") do
			expect(page).to have_content ("1 error")
			expect(page).to have_content ("Prefix must consist of six (only six) integers")
		end
	end

	context "non-unique testing" do

		let!(:brand) {FactoryGirl.create(:brand, company: company2)}

		scenario "fails with a non-unique brand name" do

			fill_in "brand[name]", with: brand.name.upcase
			fill_in "brand[prefix]", with: 123456
			find("select#brand_company_id").select("#{company2.name}")
			click_button "Add Brand"


			within("div.errors") do
				expect(page).to have_content ("1 error")
				expect(page).to have_content ("Name has already been taken")
			end
		end

		scenario "fails with a non unique prefix" do
			fill_in "brand[name]", with: "New brand name"
			fill_in "brand[prefix]", with: brand.prefix
			find("select#brand_company_id").select("#{company2.name}")
			click_button "Add Brand"

			within("div.errors") do
				expect(page).to have_content("1 error")
				expect(page).to have_content("Prefix has already been taken")
			end
		end
	end
end