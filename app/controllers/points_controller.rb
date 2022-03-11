class PointsController < ApplicationController

  def index
    @points = Point.all
  end

  def show
    @point = Point.find(params[:id])
  end

  def new
    @point = Point.new
  end

  def create
    @point = Point.new(point_params)
    @point.user = current_user
    @subject = Subject.find(params[:id])
    raise
    @point.subject = @subject

    if @point.save
      redirect_to subject_points_path(@subject), notice: 'Ponto adicionado com sucesso!'
    else
      render :new
    end
  end

  private
  def point_params
    params.require(:point).permit(:name, :user_id, :subject_id)
  end

end
