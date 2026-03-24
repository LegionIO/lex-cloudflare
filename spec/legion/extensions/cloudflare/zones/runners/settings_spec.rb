# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Zones::Runners::Settings do
  let(:client)        { Legion::Extensions::Cloudflare::Zones::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_settings' do
    it 'GETs all zone settings' do
      allow(connection).to receive(:get).with('/zones/z1/settings').and_return(list_response)
      result = client.list_settings(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_setting' do
    it 'GETs a specific zone setting' do
      allow(connection).to receive(:get).with('/zones/z1/settings/ssl').and_return(ok_response)
      result = client.get_setting(zone_id: 'z1', setting_id: 'ssl')
      expect(result[:result]).to include('success' => true)
    end
  end
end
