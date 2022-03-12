class PointsController < ApplicationController

  def index
    @points = Point.where(user_id: current_user, subject_id: params[:subject_id])
  end

  def show
    @point = Point.find(params[:id])
  end

  def new
    @point = Point.new
    @point.user = current_user
    @subject = Subject.find(params[:subject_id])
    @point.subject = @subject
  end

  def create
    @point = Point.new(point_params)
    @point.user = current_user
    @subject = Subject.find(params[:subject_id])
    @point.subject = @subject

    if @point.save
      redirect_to subject_points_path(@subject), notice: 'Ponto adicionado com sucesso!'
    else
      render :new
    end
  end

  private
  def point_params
    params.require(:point).permit(:name, :lat, :long, :date, :time, :description, :user_id, :subject_id)
  end

end
