# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::DnsFirewall::Runners::Analytics do
  let(:client)     { Legion::Extensions::Cloudflare::DnsFirewall::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response) { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#report' do
    it 'GETs analytics report' do
      allow(connection).to receive(:get).with('/accounts/a1/dns_firewall/fw1/dns_analytics/report').and_return(ok_response)
      result = client.report(account_id: 'a1', dns_firewall_id: 'fw1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#report_by_time' do
    it 'GETs by-time analytics report' do
      allow(connection).to receive(:get).with(
        '/accounts/a1/dns_firewall/fw1/dns_analytics/report/bytime', {}
      ).and_return(ok_response)
      result = client.report_by_time(account_id: 'a1', dns_firewall_id: 'fw1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_reverse_dns' do
    it 'GETs reverse DNS config' do
      allow(connection).to receive(:get).with('/accounts/a1/dns_firewall/fw1/reverse_dns').and_return(ok_response)
      result = client.get_reverse_dns(account_id: 'a1', dns_firewall_id: 'fw1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#update_reverse_dns' do
    it 'PATCHes reverse DNS config' do
      body = { ptr: {} }
      allow(connection).to receive(:patch).with('/accounts/a1/dns_firewall/fw1/reverse_dns', body).and_return(ok_response)
      result = client.update_reverse_dns(account_id: 'a1', dns_firewall_id: 'fw1', body: body)
      expect(result[:status]).to eq(200)
    end
  end
end
