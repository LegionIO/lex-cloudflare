# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::AiGateway::Client do
  subject(:client) { described_class.new(api_token: 'test-token') }

  it 'stores opts' do
    expect(client.opts).to include(api_token: 'test-token')
  end

  it 'returns a Faraday connection' do
    expect(client.client).to be_a(Faraday::Connection)
  end

  it 'includes Gateways runner' do
    expect(client).to respond_to(:list_gateways)
    expect(client).to respond_to(:create_gateway)
    expect(client).to respond_to(:delete_gateway)
  end

  it 'includes Logs runner' do
    expect(client).to respond_to(:list_logs)
    expect(client).to respond_to(:get_log)
    expect(client).to respond_to(:patch_log)
  end

  it 'includes Datasets runner' do
    expect(client).to respond_to(:list_datasets)
    expect(client).to respond_to(:create_dataset)
  end

  it 'includes Evaluations runner' do
    expect(client).to respond_to(:list_evaluations)
    expect(client).to respond_to(:create_evaluation)
  end
end
