# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::WorkersRoutes::Runners::Routes do
  let(:client)        { Legion::Extensions::Cloudflare::WorkersRoutes::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_routes' do
    it 'GETs all worker routes for a zone' do
      allow(connection).to receive(:get).with('/zones/z1/workers/routes').and_return(list_response)
      result = client.list_routes(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_route' do
    it 'GETs a single worker route' do
      allow(connection).to receive(:get).with('/zones/z1/workers/routes/r1').and_return(ok_response)
      result = client.get_route(zone_id: 'z1', route_id: 'r1')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#create_route' do
    it 'POSTs a new route with a script' do
      allow(connection).to receive(:post)
        .with('/zones/z1/workers/routes', { pattern: 'example.com/*', script: 'my-worker' })
        .and_return(ok_response)
      result = client.create_route(zone_id: 'z1', pattern: 'example.com/*', script: 'my-worker')
      expect(result[:status]).to eq(200)
    end

    it 'POSTs a route without a script' do
      allow(connection).to receive(:post)
        .with('/zones/z1/workers/routes', { pattern: 'example.com/api/*' })
        .and_return(ok_response)
      result = client.create_route(zone_id: 'z1', pattern: 'example.com/api/*')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#update_route' do
    it 'PUTs route changes' do
      allow(connection).to receive(:put)
        .with('/zones/z1/workers/routes/r1', { pattern: 'example.com/new/*', script: 'other-worker' })
        .and_return(ok_response)
      result = client.update_route(zone_id: 'z1', route_id: 'r1', pattern: 'example.com/new/*', script: 'other-worker')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_route' do
    it 'DELETEs a route' do
      allow(connection).to receive(:delete).with('/zones/z1/workers/routes/r1').and_return(ok_response)
      result = client.delete_route(zone_id: 'z1', route_id: 'r1')
      expect(result[:status]).to eq(200)
    end
  end
end
