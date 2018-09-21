class PresidentsController < ApplicationAdminsController
  before_action :set_company

  def new; end

  def create
    if User.where(company_id: @company.id).where(president: true).empty?
      User.create(params.permit(:email, :name, :password).merge(president: true, company_id: @company.id))
    end
    redirect_to company_path(@company), notice: 'President has successfully been created(Image has not yet).'
  end

  def edit
    @president = User.find_by(president: true, company_id: @company.id)
  end

  def update
    User.where(company_id: @company.id).update_all(president: false)
    president = User.find_by(email: params[:email], name: params[:name])
    president.update(president: true)
    redirect_to company_path(@company), notice: 'President has successfully been changed.'
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end
  end
