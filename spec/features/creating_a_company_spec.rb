require 'rails_helper'

RSpec.feature "Creating A Company" do

	before {visit new_company_path}

	scenario "works with a company name" do

		fill_in "company[name]", with: "New Company Name"
		click_button "Add Company"

		within("div.alert-success") do
			expect(page).to have_content "The company was added to the database"
		end
		expect(page).to have_content "New Company Name"
	end

	scenario "fails with a blank company name" do

		click_button "Add Company"

		within("div.alert-warning") do
			expect(page).to have_content "The company was not added to the database"
		end
		within("div.errors") do
			expect(page).to have_content "Name can't be blank"
			expect(page).to have_content "2 errors prevented this company from being added to the database"
		end
	end

	scenario "fails with an existing (case-insenstive) company name" do

		Company.create(name: "Test Company Name")
		fill_in "company[name]", with: "TeSt CoMpAnY nAmE"
		click_button "Add Company"

		within("div.alert-warning") do
			expect(page).to have_content "The company was not added to the database"
		end
		within("div.errors") do
			expect(page).to have_content "1 error"
			expect(page).to have_content "Name has already been taken"
		end
	end

	scenario "fails with a too short (less than 3 characters) company name" do

		fill_in "company[name]", with: "3M"
		click_button "Add Company"

		within("div.alert-warning") do
			expect(page).to have_content "The company was not added to the database"
		end
		within("div.errors") do
			expect(page).to have_content "1 error"
			expect(page).to have_content "(minimum is 3 characters)"
		end
	end
end