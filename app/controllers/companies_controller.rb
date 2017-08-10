class CompaniesController < ApplicationController

	def index
		@companies = Company.all
	end

	def new
		@company = Company.new
	end

	def create
		@company = Company.create(company_params)
		flash[:success] = "The company was added to the database"
		redirect_to companies_path
	end

	private 

		def company_params
			params.require(:company).permit(:name)
		end
end
