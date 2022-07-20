class SubjectsController < ApplicationController
  #skip_before_action :authenticate_user!, only: %i[index]

  def index
    @subjects = Subject.includes(:points).all.where(user_id: current_user)
  end

  def show
    @subjects = Subject.includes(:points).all.where(user_id: current_user)
    if @subjects.first.user == current_user
      @subject = Subject.where(params[:id])
    else
      redirect_to user_subjects_path(current_user), notice: 'Ação proibida.'
    end
  end

  def new
    @subject = Subject.new
    @subject.user_id = current_user
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.user_id = params[:user_id]
    if @subject.save
      redirect_to user_subjects_path(current_user), notice: 'Campo adicionado!'
    else
      render :new
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    if @subject.user_id == current_user.id
      @subject
    else
      redirect_to user_subjects_path(current_user), notice: 'Ação proibida.'
    end
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.user_id == current_user.id
      @subject.update(subject_params)
      redirect_to user_subjects_path(current_user)
    else
      redirect_to user_subjects_path(current_user), notice: 'Ação proibida.'
    end
  end

  private
  def subject_params
    params.require(:subject).permit(:name, :teacher, :user_id, :photo)
  end

end
