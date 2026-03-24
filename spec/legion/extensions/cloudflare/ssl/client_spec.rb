# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Ssl::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'includes CertificatePacks runner' do
    expect(client).to respond_to(:list_packs)
    expect(client).to respond_to(:order_pack)
    expect(client).to respond_to(:quota)
  end

  it 'includes Universal runner' do
    expect(client).to respond_to(:get_universal_settings)
    expect(client).to respond_to(:update_universal_settings)
    expect(client).to respond_to(:list_verification)
  end
end
