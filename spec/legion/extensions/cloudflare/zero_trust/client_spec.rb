# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::ZeroTrust::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'includes Devices runner' do
    expect(client).to respond_to(:list_devices)
    expect(client).to respond_to(:get_device)
    expect(client).to respond_to(:revoke_device)
  end

  it 'includes Registrations runner' do
    expect(client).to respond_to(:list_registrations)
    expect(client).to respond_to(:get_registration)
    expect(client).to respond_to(:revoke_registrations)
  end

  it 'includes DexTests runner' do
    expect(client).to respond_to(:list_dex_tests)
    expect(client).to respond_to(:create_dex_test)
    expect(client).to respond_to(:delete_dex_test)
  end

  it 'includes IpProfiles runner' do
    expect(client).to respond_to(:list_ip_profiles)
    expect(client).to respond_to(:create_ip_profile)
    expect(client).to respond_to(:delete_ip_profile)
  end
end
