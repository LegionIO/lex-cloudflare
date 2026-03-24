# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::ZeroTrust::Runners::Registrations do
  let(:client)     { Legion::Extensions::Cloudflare::ZeroTrust::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_registrations' do
    it 'GETs registrations' do
      allow(connection).to receive(:get).with('/accounts/a1/devices/registrations', {}).and_return(list_response)
      result = client.list_registrations(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_registration' do
    it 'GETs a single registration' do
      allow(connection).to receive(:get).with('/accounts/a1/devices/registrations/r1').and_return(ok_response)
      result = client.get_registration(account_id: 'a1', registration_id: 'r1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_registration' do
    it 'DELETEs a registration' do
      allow(connection).to receive(:delete).with('/accounts/a1/devices/registrations/r1').and_return(ok_response)
      result = client.delete_registration(account_id: 'a1', registration_id: 'r1')
      expect(result[:status]).to eq(200)
    end
  end
end
