# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::DnsFirewall::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'includes Clusters runner' do
    expect(client).to respond_to(:list)
    expect(client).to respond_to(:create)
  end

  it 'includes Analytics runner' do
    expect(client).to respond_to(:report)
    expect(client).to respond_to(:report_by_time)
    expect(client).to respond_to(:get_reverse_dns)
  end
end
