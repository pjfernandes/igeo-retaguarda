class PointsController < ApplicationController

  def index

    @subject = Subject.find(params[:subject_id])

    if @subject.user_id == current_user.id

        if params[:query].present?
          @points = Point.global_search(params[:query]).where(user_id: current_user, subject_id: params[:subject_id])
        else
          @points = Point.where(user_id: current_user, subject_id: params[:subject_id])
        end

          @subject = @points.first.subject if @points.size > 0
          unless @points.empty?
            @markers = @points.map do |point|
                {
                  lat: point.latitude,
                  lng: point.longitude,
                  #info_window: render_to_string(partial: "info_window", locals: { point: point })
                  info_window: "<div class='border-bottom'>
                                    <p class='text-center text-dark'><strong><i class='fas fa-info-circle text-primary'></i> <a href='#{user_subject_point_path(current_user, point.subject, point)}'>#{point.name.capitalize}</a></strong></p>
                                </div>
                                <div class='text-left text-dark'>
                                  <p><i class='page-title fas fa-calendar text-primary'></i> <strong>Data:</strong> #{eval(point.date)[3].to_s + "/" + eval(point.date)[2].to_s + "/" + eval(point.date)[1].to_s }</p>
                                  <p><i class='page-title fas fa-globe-americas text-primary'></i> <strong>Lat:</strong> #{point.latitude.round(4)} <strong class='text-primary'>-</strong> <strong>Long:</strong> #{point.longitude.round(4)}</p>
                                </div>"
                    }
              end

          end
    else
      redirect_to root_path, notice: "Ação proibida."
    end

    respond_to do |format|
      format.html
      format.csv { send_data Point.to_csv(@points), filename: "points.csv" }
    end
  end

  def show
    @point = Point.find(params[:id])
    @subject = @point.subject
    if @point.user == current_user
      @markers = [
        {
          lat: @point.latitude,
          lng: @point.longitude,
          info_window: "<div><i class='page-title fa-solid fa-location-dot text-primary'></i> <strong>Lat:</strong> #{@point.latitude} <strong class='text-primary'>-</strong> <strong>Long:</strong> #{@point.longitude}
                        </div>"
        }
      ]
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
      redirect_to user_subject_points_path(@subject, anchor: "point-#{@point.id}"), notice: 'Ponto adicionado com sucesso!'
    else
      render :new
    end
  end

  def edit
    @point = Point.find(params[:id])
    @subject = @point.subject
  end

  def update
    @point = Point.find(params[:id])
    @subject = @point.subject
    if @point.user == current_user
      @point.update(point_params)
      redirect_to subject_point_path(@point), notice: 'Ponto editado com sucesso!'
    else
      redirect_to root_path, notice: 'Ação proibida'
    end
  end

  def destroy
    @point = Point.find(params[:id])
    if @point.user == current_user
      @point.destroy
      redirect_to user_subject_points_path(current_user, @point.subject)
    else
      redirect_to root_path, notice: 'Ação proibida'
    end
  end

  private
  def point_params
    params.require(:point).permit(:name, :latitude, :longitude, :date, :time, :description, :user_id, :subject_id, photos: [])
  end

end
