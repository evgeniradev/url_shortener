# frozen_string_literal: true

require 'rails_helper'

describe ApplicationCable::Connection, type: :channel do
  let(:user) { create(:user) }

  it 'connects when user is logged in' do
    allow_any_instance_of(described_class).to(
      receive_message_chain(:cookies, :encrypted).and_return(session(user.id))
    )
    connect '/cable'
    expect(connection.send(:user_id)).to eq(user.id)
  end

  it 'fails to connect when user is not logged in' do
    allow_any_instance_of(described_class).to(
      receive_message_chain(:cookies, :encrypted).and_return(user.id - 2)
    )
    expect do
      connect '/cable'
      connection.send(:user_id)
    end.to raise_error(ActionCable::Connection::Authorization::UnauthorizedError)
  end

  def session(user_id)
    {
      '_url_shortener_session' => {
        'warden.user.user.key' => [[user_id]]
      }
    }
  end
end
