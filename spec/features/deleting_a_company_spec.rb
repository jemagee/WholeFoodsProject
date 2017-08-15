require "rails_helper"

RSpec.feature "Deleting a company" do

	let!(:company) {FactoryGirl.create(:company)}
	let!(:company2) {FactoryGirl.create(:company)}

	before {visit company_path(company)}

	scenario "Works correctly" do

		click_link "Delete Company"

		expect(page).to have_content("The company has been deleted")
		expect(page).to have_content(company2.name)
		expect(page).to_not have_content(company.name)
	end
end
