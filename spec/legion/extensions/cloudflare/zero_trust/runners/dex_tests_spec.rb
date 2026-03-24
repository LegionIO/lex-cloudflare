# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::ZeroTrust::Runners::DexTests do
  let(:client)     { Legion::Extensions::Cloudflare::ZeroTrust::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_dex_tests' do
    it 'GETs DEX tests' do
      allow(connection).to receive(:get).with('/accounts/a1/dex/devices/dex_tests', {}).and_return(list_response)
      result = client.list_dex_tests(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_dex_test' do
    it 'GETs a single DEX test' do
      allow(connection).to receive(:get).with('/accounts/a1/dex/devices/dex_tests/t1').and_return(ok_response)
      result = client.get_dex_test(account_id: 'a1', dex_test_id: 't1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create_dex_test' do
    it 'POSTs a new DEX test' do
      body = { name: 'my-test', enabled: true, interval: '30m', data: { host: 'example.com', kind: 'http' } }
      allow(connection).to receive(:post).with('/accounts/a1/dex/devices/dex_tests', body).and_return(ok_response)
      result = client.create_dex_test(account_id: 'a1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_dex_test' do
    it 'DELETEs a DEX test' do
      allow(connection).to receive(:delete).with('/accounts/a1/dex/devices/dex_tests/t1').and_return(ok_response)
      result = client.delete_dex_test(account_id: 'a1', dex_test_id: 't1')
      expect(result[:status]).to eq(200)
    end
  end
end
