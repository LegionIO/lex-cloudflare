# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Dns::Runners::Records do
  let(:client)     { Legion::Extensions::Cloudflare::Dns::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response) { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list' do
    it 'GETs dns_records for a zone' do
      allow(connection).to receive(:get).with('/zones/z1/dns_records', {}).and_return(list_response)
      result = client.list(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end

    it 'passes filter params' do
      allow(connection).to receive(:get).with('/zones/z1/dns_records', { type: 'A' }).and_return(list_response)
      result = client.list(zone_id: 'z1', type: 'A')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get' do
    it 'GETs a single record' do
      allow(connection).to receive(:get).with('/zones/z1/dns_records/r1').and_return(ok_response)
      result = client.get(zone_id: 'z1', dns_record_id: 'r1')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#create' do
    it 'POSTs a new record' do
      body = { type: 'A', name: 'test.example.com', content: '1.2.3.4', ttl: 3600 }
      allow(connection).to receive(:post).with('/zones/z1/dns_records', body).and_return(ok_response)
      result = client.create(zone_id: 'z1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#update' do
    it 'PATCHes an existing record' do
      body = { content: '5.6.7.8' }
      allow(connection).to receive(:patch).with('/zones/z1/dns_records/r1', body).and_return(ok_response)
      result = client.update(zone_id: 'z1', dns_record_id: 'r1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete' do
    it 'DELETEs a record' do
      allow(connection).to receive(:delete).with('/zones/z1/dns_records/r1').and_return(ok_response)
      result = client.delete(zone_id: 'z1', dns_record_id: 'r1')
      expect(result[:status]).to eq(200)
    end
  end
end
