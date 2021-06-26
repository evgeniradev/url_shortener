# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def index
    respond_to do |format|
      format.html
      format.json do
        render(serializer_args)
      end
    end
  end

  def show
    url = Url.find_by(slug: params[:slug])

    return render('not_found', status: :bad_request) unless url

    url.concurrent_increment!
    redirect_to url.url
  end

  def create
    url = Url.create(create_args)

    if url.persisted?
      render json: url, serializer: UrlSerializer
    else
      render json: url.errors.full_messages.join(', '), status: :bad_request
    end
  end

  private

  def serializer_args
    @serializer_args ||=
      {
        json: Url.for_user(current_user),
        each_serializer: UrlSerializer,
        root: 'data',
        adapter: :json
      }
  end

  def create_args
    permitted_params
      .to_unsafe_h
      .merge(
        slug: SlugGeneratorService.call,
        user: current_user
      )
  end

  def permitted_params
    params.require(:url).permit(:url)
  end
end
