# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Zones::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'sets the Authorization header' do
    expect(client.client.headers['Authorization']).to eq('Bearer test-token')
  end

  it 'includes Zones runner' do
    expect(client).to respond_to(:list)
    expect(client).to respond_to(:get)
    expect(client).to respond_to(:create)
    expect(client).to respond_to(:delete)
    expect(client).to respond_to(:activation_check)
  end

  it 'includes Settings runner' do
    expect(client).to respond_to(:list_settings)
    expect(client).to respond_to(:get_setting)
  end
end
