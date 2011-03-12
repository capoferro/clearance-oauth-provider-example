class ApplicationsController < ApplicationController
  before_filter :authenticate, only: [:index]
  
  def index
    @applications = current_user.applications
  end

  def show
    @application = Application.where(id: params[:id]).first
  end

  def new
    @application = Application.new
  end

  def edit
    @application = Application.where(id: params[:id]).first
  end

  def create
    @application = Application.new(params[:application])
    if @application.save
      flash[:notice] = 'Application registered.'
      redirect_to account_application_path(@application)
    else
      flash[:error] = 'Oops. Something went wrong.'
    end
  end

  def update
  end

  def destroy
  end

end
