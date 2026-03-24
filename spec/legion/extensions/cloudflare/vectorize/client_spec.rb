# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Vectorize::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'includes Indexes runner' do
    expect(client).to respond_to(:list_indexes)
    expect(client).to respond_to(:create_index)
    expect(client).to respond_to(:delete_index)
  end

  it 'includes Vectors runner' do
    expect(client).to respond_to(:insert)
    expect(client).to respond_to(:query)
    expect(client).to respond_to(:upsert)
  end
end
