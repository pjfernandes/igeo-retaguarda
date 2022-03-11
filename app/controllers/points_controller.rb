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
    if @point.save
      redirect_to point_path(@point), notice: 'point was successfully created!'
    else
      render :new
    end
  end

end
