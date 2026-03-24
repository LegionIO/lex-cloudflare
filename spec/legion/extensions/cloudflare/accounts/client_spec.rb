# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Accounts::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'sets the Authorization header' do
    expect(client.client.headers['Authorization']).to eq('Bearer test-token')
  end

  it 'includes Accounts runner' do
    expect(client).to respond_to(:list)
    expect(client).to respond_to(:get)
    expect(client).to respond_to(:create)
    expect(client).to respond_to(:delete)
    expect(client).to respond_to(:get_profile)
    expect(client).to respond_to(:update_profile)
  end

  it 'includes Members runner' do
    expect(client).to respond_to(:list_members)
    expect(client).to respond_to(:get_member)
    expect(client).to respond_to(:add_member)
    expect(client).to respond_to(:remove_member)
  end

  it 'includes Roles runner' do
    expect(client).to respond_to(:list_roles)
    expect(client).to respond_to(:get_role)
  end

  it 'includes Tokens runner' do
    expect(client).to respond_to(:list_tokens)
    expect(client).to respond_to(:get_token)
    expect(client).to respond_to(:create_token)
    expect(client).to respond_to(:update_token)
  end
end
