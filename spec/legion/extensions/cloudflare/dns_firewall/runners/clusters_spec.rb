# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::DnsFirewall::Runners::Clusters do
  let(:client)     { Legion::Extensions::Cloudflare::DnsFirewall::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list' do
    it 'GETs dns_firewall clusters' do
      allow(connection).to receive(:get).with('/accounts/a1/dns_firewall', {}).and_return(list_response)
      result = client.list(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get' do
    it 'GETs a single cluster' do
      allow(connection).to receive(:get).with('/accounts/a1/dns_firewall/fw1').and_return(ok_response)
      result = client.get(account_id: 'a1', dns_firewall_id: 'fw1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create' do
    it 'POSTs a new cluster' do
      allow(connection).to receive(:post).with('/accounts/a1/dns_firewall', anything).and_return(ok_response)
      result = client.create(account_id: 'a1', name: 'my-cluster', upstream_ips: ['1.2.3.4'])
      expect(result[:status]).to eq(200)
    end
  end

  describe '#update' do
    it 'PATCHes a cluster' do
      body = { name: 'updated' }
      allow(connection).to receive(:patch).with('/accounts/a1/dns_firewall/fw1', body).and_return(ok_response)
      result = client.update(account_id: 'a1', dns_firewall_id: 'fw1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete' do
    it 'DELETEs a cluster' do
      allow(connection).to receive(:delete).with('/accounts/a1/dns_firewall/fw1').and_return(ok_response)
      result = client.delete(account_id: 'a1', dns_firewall_id: 'fw1')
      expect(result[:status]).to eq(200)
    end
  end
end
