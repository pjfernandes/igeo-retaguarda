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
      @post = Subject.new(subject_params)
      @subject.user = current_user
      if @subject.save
        redirect_to subject_path(@subject), notice: 'Subject was successfully created!'
      else
        render :new
      end
    end
  end

  def edit
    if current_user.admin?
      @subject = Subject.find(params[:id])
    else
      redirect_to subject_path(@subject)
    end
  end

  def update
    if current_user.admin?
      @subject = Subject.find(params[:id])
      @subject.user = current_user
      @subject.update(subject_params)
      redirect_to subject_path(@subject)
    end
  end

end
