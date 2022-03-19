class PointsController < ApplicationController

  def index
    @points = Point.where(user_id: current_user, subject_id: params[:subject_id])
    @markers = @points.map do |point|
      {
        lat: point.latitude,
        lng: point.longitude,
        info_window: render_to_string(partial: "info_window", locals: { point: point })
      }
    end
  end

  def show
    @point = Point.find(params[:id])
    if @point.user == current_user
      @point
    else
     redirect_to root_path, notice: 'Ação proibida'
    end
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
    params.require(:point).permit(:name, :latitude, :longitude, :date, :time, :description, :user_id, :subject_id)
  end

end
