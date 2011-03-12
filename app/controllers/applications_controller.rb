class ApplicationsController < ApplicationController
  before_filter :authenticate
  
  def index
    @applications = current_user.applications
  end

  def show
    @application = Application.where(id: params[:id], user_id: current_user.id).first
    redirect_to account_applications_path if @application.nil?
  end

  def new
    @application = Application.new
  end

  def edit
    @application = Application.where(id: params[:id]).first
  end

  def create
    @application = Application.new(params[:application].merge(user: current_user))
    if @application.save
      flash[:notice] = 'Application registered.'
      redirect_to account_application_path(@application)
    else
      flash[:error] = 'Oops. Something went wrong.'
    end
  end

  def update
    @application = Application.where(id: params[:id], user_id: current_user.id).first
    if @application and @application.update_attributes params[:application]
      flash[:notice] = 'Saved!'
    elsif @application.nil?
      redirect_to account_applications_path
    else
      flash[:error] = 'Save failed. Try again!'
    end
  end

  def destroy
    @application = Application.where(id: params[:id], user_id: current_user.id).first
    if @application.nil?
      flash[:notice] = 'Can\'t find that application'
    else
      @application.destroy
      flash[:notice] = 'Application deleted.'
    end
  end

end
