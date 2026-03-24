# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::CustomNameservers::Runners::Nameservers do
  let(:client)     { Legion::Extensions::Cloudflare::CustomNameservers::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list' do
    it 'GETs custom nameservers' do
      allow(connection).to receive(:get).with('/accounts/a1/custom_ns').and_return(list_response)
      result = client.list(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#add' do
    it 'POSTs a new nameserver' do
      allow(connection).to receive(:post).with('/accounts/a1/custom_ns', { ns_name: 'ns1.example.com' }).and_return(ok_response)
      result = client.add(account_id: 'a1', ns_name: 'ns1.example.com')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete' do
    it 'DELETEs a nameserver' do
      allow(connection).to receive(:delete).with('/accounts/a1/custom_ns/ns1.example.com').and_return(ok_response)
      result = client.delete(account_id: 'a1', custom_ns_id: 'ns1.example.com')
      expect(result[:status]).to eq(200)
    end
  end
end
