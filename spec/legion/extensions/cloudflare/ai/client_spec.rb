# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Ai::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'includes Models runner' do
    expect(client).to respond_to(:run)
    expect(client).to respond_to(:search_models)
    expect(client).to respond_to(:model_schema)
  end

  it 'includes Finetunes runner' do
    expect(client).to respond_to(:list_finetunes)
    expect(client).to respond_to(:create_finetune)
    expect(client).to respond_to(:list_public_finetunes)
  end
end
