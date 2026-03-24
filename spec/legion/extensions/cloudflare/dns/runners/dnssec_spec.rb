# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Dns::Runners::Dnssec do
  let(:client)     { Legion::Extensions::Cloudflare::Dns::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response) { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#get_dnssec' do
    it 'GETs dnssec status' do
      allow(connection).to receive(:get).with('/zones/z1/dnssec').and_return(ok_response)
      result = client.get_dnssec(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#edit_dnssec' do
    it 'PATCHes dnssec settings' do
      body = { status: 'active' }
      allow(connection).to receive(:patch).with('/zones/z1/dnssec', body).and_return(ok_response)
      result = client.edit_dnssec(zone_id: 'z1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_dnssec' do
    it 'DELETEs dnssec records' do
      allow(connection).to receive(:delete).with('/zones/z1/dnssec').and_return(ok_response)
      result = client.delete_dnssec(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end
end
