require 'rails_helper'

RSpec.describe Api::V1::TrailersController, type: :controller do
  describe 'GET #index' do
    let(:user)        { create(:user) }
    let(:trailers)    { create_list(:trailer, 2) }
    let!(:collection) { UniqueDownloadToken::Creator.call(user.id, trailers.pluck(:id)) }
    subject           { get :index }

    context 'returns list of trailers for user' do
      context 'authorized user' do
        before do
          authorize_user(user)
        end

        it do
          expect(json_body.size).to eq(2)
        end

        it do
          is_expected.to be_success
        end
      end

      context 'rejects for unauthorized' do
        before do
          unauthorize_user
        end

        it do
          is_expected.to be_unauthorized
        end
      end
    end
  end

  describe 'GET #download' do
    let(:user)        { create(:user) }
    let(:trailers)    { create_list(:trailer, 2) }
    let!(:collection) { UniqueDownloadToken::Creator.call(user.id, trailers.pluck(:id)) }
    let(:params)      { {token: collection[trailers.first.id.to_s], id: trailers.first.id} }
    subject           { get :download, params: params }

    context 'authorized user' do
      before do
        authorize_user(user)
      end

      context 'return ok for download' do
        it do
          is_expected.to be_success
        end

        it do
          expect(json_body['status']).to eq('ok')
        end
      end

      context 'rejects invalid token' do
        let(:params) { {token: 'qwerty', id: trailers.first.id} }

        it do
          is_expected.to be_unauthorized
        end

        it do
          expect(json_body['status']).to eq('unauthorized')
        end
      end
    end

    context 'unauthorized' do
      context 'rejects for download with valid token' do
        it do
          is_expected.to be_unauthorized
        end
      end
    end
  end
end
