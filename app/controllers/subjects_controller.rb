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
    @subject.name = @subject.name.slice(0, 30)
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
    @subject.name = @subject.name.slice(0, 30)
    if @subject.user_id == current_user.id
      @subject.update(subject_params)
      redirect_to user_subjects_path(current_user)
    else
      redirect_to user_subjects_path(current_user), notice: 'Ação proibida.'
    end
  end

  def get_subjects
    @subjects = Subject.includes(:points).all.where(user_id: params[:id]).with_attached_photo

    render json: (@subjects.map do |subject|
      if subject.photo.attached?
        subject.as_json.merge({ image: url_for(subject.photo )})
      else
         subject.as_json.merge({ image: "no" })
      end
    end
    )
  end

  private
  def subject_params
    params.require(:subject).permit(:name, :teacher, :user_id, :photo)
  end

end
