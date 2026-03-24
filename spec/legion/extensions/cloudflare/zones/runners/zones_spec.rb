# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Zones::Runners::Zones do
  let(:client)        { Legion::Extensions::Cloudflare::Zones::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list' do
    it 'GETs all zones' do
      allow(connection).to receive(:get).with('/zones', {}).and_return(list_response)
      result = client.list
      expect(result[:status]).to eq(200)
    end

    it 'passes filter params' do
      allow(connection).to receive(:get).with('/zones', { name: 'example.com', status: 'active' }).and_return(list_response)
      result = client.list(name: 'example.com', status: 'active')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get' do
    it 'GETs a single zone' do
      allow(connection).to receive(:get).with('/zones/z1').and_return(ok_response)
      result = client.get(zone_id: 'z1')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#create' do
    it 'POSTs a new zone' do
      allow(connection).to receive(:post).with('/zones', { name: 'example.com', account: { id: 'a1' } }).and_return(ok_response)
      result = client.create(name: 'example.com', account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#update' do
    it 'PATCHes a zone' do
      body = { vanity_name_servers: ['ns1.example.com'] }
      allow(connection).to receive(:patch).with('/zones/z1', body).and_return(ok_response)
      result = client.update(zone_id: 'z1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete' do
    it 'DELETEs a zone' do
      allow(connection).to receive(:delete).with('/zones/z1').and_return(ok_response)
      result = client.delete(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#activation_check' do
    it 'PUTs an activation check' do
      allow(connection).to receive(:put).with('/zones/z1/activation_check').and_return(ok_response)
      result = client.activation_check(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end
end
