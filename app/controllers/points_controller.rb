class PointsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[get_all_points_by_user post_point]
  skip_before_action :verify_authenticity_token

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
    @point.name = @point.name.slice(0, 30)
    if @point.user == current_user
      @point.update(point_params)
      redirect_to point_path(@point), notice: 'Ponto editado com sucesso!'
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

  # def get_all_points_by_user
  #   @points = Point.where(user_id: params[:id]).with_attached_photos
  #   point_json = []
  #   point_time = 0
  #   @points.each do |point|
  #     point_json[point_time] = point.as_json.merge({ image: [] })
  #     if point.photos.size.positive?
  #       for i in (0...point.photos.size)
  #         point_json[point_time][:image] << url_for(point.photos[i])
  #         point_time += 1
  #       end
  #     else
  #        point_json[point_time] = point.as_json.merge({ image: "no" })
  #     end
  #   end
  #   render json: point_json
  # end

  def get_all_points_by_user
    @points = Point.where(user_id: params[:id]).with_attached_photos
    render json: @points
  end

  def get_all_points_by_user_and_subject
    @points = Point.where(subject_id: params[:subject_id], user_id: params[:user_id]).with_attached_photos
    render json: @points
  end

  def igeo_post
    params = { 'hello' => 'world'}
    x = Net::HTTP.post_form(URI.parse('https://httpbin.org/anything'), params)
    render json: x.body
  end

  def post_point
    @point = Point.new(point_params)
    if @point.save
      render json: {status: 'SUCCESS', message:'Saved point', data: @point}, status: :ok
    else
      render json: {status: 'ERROR', message:'point not saved', data: @point.erros}, status: :unprocessable_entity
    end
  end


  private
  def point_params
    params.require(:point).permit(:name, :latitude, :longitude, :date, :time, :description, :user_id, :subject_id, :favorite, photos: [])
  end

end
