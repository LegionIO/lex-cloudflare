# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::ZeroTrust::Runners::Devices do
  let(:client)     { Legion::Extensions::Cloudflare::ZeroTrust::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_devices' do
    it 'GETs physical devices' do
      allow(connection).to receive(:get).with('/accounts/a1/devices/physical-devices', {}).and_return(list_response)
      result = client.list_devices(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_device' do
    it 'GETs a single device' do
      allow(connection).to receive(:get).with('/accounts/a1/devices/physical-devices/d1').and_return(ok_response)
      result = client.get_device(account_id: 'a1', device_id: 'd1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_device' do
    it 'DELETEs a device' do
      allow(connection).to receive(:delete).with('/accounts/a1/devices/physical-devices/d1').and_return(ok_response)
      result = client.delete_device(account_id: 'a1', device_id: 'd1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#revoke_device' do
    it 'POSTs to revoke registrations' do
      allow(connection).to receive(:post).with('/accounts/a1/devices/physical-devices/d1/revoke').and_return(ok_response)
      result = client.revoke_device(account_id: 'a1', device_id: 'd1')
      expect(result[:status]).to eq(200)
    end
  end
end
