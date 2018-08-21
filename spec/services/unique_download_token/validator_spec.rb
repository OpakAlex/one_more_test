require 'rails_helper'

RSpec.describe UniqueDownloadToken::Validator do
  describe '.call' do
    let(:user)        { create(:user) }
    let(:trailers)    { create_list(:trailer, 2) }
    let!(:collection) { UniqueDownloadToken::Creator.call(user.id, trailers.pluck(:id)) }

    subject do
      ->(token) do
        described_class.
          new(user.id, trailers.first.id, token).
          valid?
      end
    end

    context 'token validation' do
      context 'token present and valid' do
        it { expect(subject.call(collection[trailers.first.id.to_s])).to eq(true) }
      end

      context 'rejects invalid token' do
        it { expect(subject.call('123123')).to eq(false) }
      end
    end
  end
end
