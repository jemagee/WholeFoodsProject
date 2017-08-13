class CompaniesController < ApplicationController

	def index
		@companies = Company.all
	end

	def new
		@company = Company.new
	end

	def create
		@company = Company.new(company_params)
		if @company.save
			flash[:success] = "The company was added to the database"
			redirect_to companies_path
		else
			flash[:warning] = "The company was not added to the database"
			render 'new'
		end
	end

	private 

		def company_params
			params.require(:company).permit(:name)
		end
end
