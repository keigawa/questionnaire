class PresidentsController < ApplicationAdminsController
  before_action :set_company
  #  before_action :set_president, only: [:new, :edit]

  def new; end

  def create
    if User.where(company_id: @company.id).where(president: true).empty?
      @user = User.new(params.permit(:email, :name, :image, :image_cache, :remove_image, :password).merge(president: true, company_id: @company.id))
      if @user.save
        redirect_to company_path(@company), notice: 'President has successfully been created.'
        return
      else
        render action: :new
      end
    else
      redirect_to company_path(@company), notice: 'President already exists.'
      nil
    end
  end

  def edit; end

  def update
    president = User.find_by(email: params[:email], name: params[:name], company_id: @company.id)
    if president
      User.where(company_id: @company.id).update_all(president: false)
      president.update_attribute(:president, true)
      redirect_to company_path(@company), notice: 'President has successfully been changed.'
      return
    else
      redirect_to edit_company_president_path(@company), notice: 'Such President does not exist.'
      return
  end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

    #  def set_president
    #    @president = User.find_by(president: true, company_id: @company.id)
    #  end
  end
