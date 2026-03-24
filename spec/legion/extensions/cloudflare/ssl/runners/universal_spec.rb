# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Ssl::Runners::Universal do
  let(:client)     { Legion::Extensions::Cloudflare::Ssl::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response) { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#get_universal_settings' do
    it 'GETs universal SSL settings' do
      allow(connection).to receive(:get).with('/zones/z1/ssl/universal/settings').and_return(ok_response)
      result = client.get_universal_settings(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#update_universal_settings' do
    it 'PATCHes universal SSL settings' do
      allow(connection).to receive(:patch).with('/zones/z1/ssl/universal/settings', { enabled: true }).and_return(ok_response)
      result = client.update_universal_settings(zone_id: 'z1', enabled: true)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_recommendation' do
    it 'GETs SSL recommendation' do
      allow(connection).to receive(:get).with('/zones/z1/ssl/recommendation').and_return(ok_response)
      result = client.get_recommendation(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#list_verification' do
    it 'GETs SSL verification records' do
      allow(connection).to receive(:get).with('/zones/z1/ssl/verification').and_return(ok_response)
      result = client.list_verification(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end
end
