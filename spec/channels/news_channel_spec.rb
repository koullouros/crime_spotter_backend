require 'rails_helper'

RSpec.describe NewsChannel, type: :channel do
  let(:action_cable) { ActionCable.server }

  let(:data) do
    {
      'location' => 'london',
      'source' => 'google'
    }
  end

  before do
    @connection = stub_connection current_user: 'TestUser'
    @channel = NewsChannel.new @connection, {}
    @action_cable = ActionCable.server
  end

  context 'when attempting to connect' do
    it 'successfully subscribes' do
      stub_connection current_user: 'TestUser'
      subscribe

      expect(subscription).to be_confirmed
    end

    it 'receives news articles on request_update' do
      expect(@action_cable).to receive(:broadcast).with('news:TestUser', any_args)

      @channel.request_update(:data)
    end
  end
end
