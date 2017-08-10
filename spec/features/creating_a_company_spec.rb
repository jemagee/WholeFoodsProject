require 'rails_helper'

RSpec.feature "Creating A Company" do

	scenario "works with a company name" do

		visit new_company_path
		fill_in "company[name]", with: "New Company Name"
		click_button "Add Company"

		expect(page).to have_content "The company was added to the database"
		expect(page).to have_content "New Company Name"
	end
end