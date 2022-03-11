class SubjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @subjects = Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
  end

  def new
    if current_user.admin?
      @subject = Subject.new
    else
      redirect_to root_path
    end
  end

  def create
    if current_user.admin?
      @subject = Subject.new(subject_params)
      if @subject.save
        redirect_to subjects_path, notice: 'Subject was successfully created!'
      else
        render :new
      end
    end
  end

  def edit
    if current_user.admin?
      @subject = Subject.find(params[:id])
    else
      redirect_to subjects_path
    end
  end

  def update
    if current_user.admin?
      @subject = Subject.find(params[:id])
      @subject.update(subject_params)
      redirect_to subjects_path
    end
  end

  private
  def subject_params
    params.require(:subject).permit(:name, :teacher)
  end

end
