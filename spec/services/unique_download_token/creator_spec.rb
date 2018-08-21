require 'rails_helper'

RSpec.describe UniqueDownloadToken::Creator do
  describe '.call' do
    let(:user)     { create(:user) }
    let(:trailers) { create_list(:trailer, 2) }
    subject        { ->(user_id, trailer_ids) { described_class.call(user_id, trailer_ids) } }

    context 'token for trailers by user' do
      context 'every token unique' do
        it do
          first_token  = subject.call(user.id, trailers.pluck(:id))[trailers.first.id.to_s]
          second_token = subject.call(user.id, trailers.pluck(:id))[trailers.last.id.to_s]

          expect(first_token).to_not eq(second_token)
        end
      end

      context 'ignores regeneration if already present' do
        it do
          initial_token = subject.call(user.id, trailers.pluck(:id))[trailers.first.id.to_s]

          expect(subject.call(user.id, trailers.pluck(:id))[trailers.first.id.to_s]).
            to eq(initial_token)
        end
      end
    end
  end
end
