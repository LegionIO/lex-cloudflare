# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::CustomNameservers::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'includes Nameservers runner' do
    expect(client).to respond_to(:list)
    expect(client).to respond_to(:add)
    expect(client).to respond_to(:delete)
  end
end
