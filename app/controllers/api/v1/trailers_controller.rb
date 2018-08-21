class Api::V1::TrailersController < Api::V1::BaseController
  before_action :ensure_token_valid!, only: :download

  def index
    collection = Trailer.all
    UniqueDownloadToken::Creator.call(current_user.id, collection.pluck(:id))

    render json: collection, status: :ok
  end

  def download
    render json: {"status": 'ok'}, status: :ok
  end

  private

  def ensure_token_valid!
    token_entity = UniqueDownloadToken::Validator.
      new(current_user.id, params[:id], params[:token])

    render json: {"status": 'unauthorized'}, status: :unauthorized unless token_entity.valid?
  end
end
