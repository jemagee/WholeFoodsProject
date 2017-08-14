require "rails_helper"

RSpec.feature "Editing a company" do

	let!(:company) {FactoryGirl.create(:company)}
	let!(:company2) {FactoryGirl.create(:company)}

	before do
		visit companies_path
		click_link company.name
		click_link "Edit Company"
	end

	scenario "works properly" do

		fill_in "company[name]", with: "Edited Company Name"
		click_button "Update Company"

		within("div.alert-success") do
			expect(page).to have_content "The company was updated"
		end

		expect(page).to have_content "Edited Company Name"
		expect(current_path).to eq company_path(company)
	end

	scenario "fails if you submit a blank company name" do

		fill_in "company[name]", with: ""
		click_button "Update Company"

		within("div.alert-warning") do
			expect(page).to have_content "The company was not updated"
		end

		within("div.errors") do
			expect(page).to have_content "Name can't be blank"
		end
	end

	scenario "fails if you submit a too short name" do

		fill_in "company[name]", with: "3M"
		click_button "Update Company"

		within("div.errors") do
			expect(page).to have_content("1 error")
			expect(page).to have_content("Name is too short")
		end
	end

	scenario "fails if you submit a name already taken" do

		fill_in "company[name]", with: company2.name
		click_button "Update Company"

		within("div.errors") do
			expect(page).to have_content("Name has already been taken")
		end
	end
end