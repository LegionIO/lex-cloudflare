# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::WorkersRoutes::Client do
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

  it 'includes Routes runner' do
    expect(client).to respond_to(:list_routes)
    expect(client).to respond_to(:get_route)
    expect(client).to respond_to(:create_route)
    expect(client).to respond_to(:update_route)
    expect(client).to respond_to(:delete_route)
  end
end
