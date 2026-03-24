# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::AiGateway::Runners::Datasets do
  let(:client)     { Legion::Extensions::Cloudflare::AiGateway::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_datasets' do
    it 'GETs datasets' do
      allow(connection).to receive(:get).with('/accounts/a1/ai-gateway/gateways/gw1/datasets', {}).and_return(list_response)
      result = client.list_datasets(account_id: 'a1', gateway_id: 'gw1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create_dataset' do
    it 'POSTs a new dataset' do
      body = { name: 'my-dataset', enable: true, filters: [] }
      allow(connection).to receive(:post).with('/accounts/a1/ai-gateway/gateways/gw1/datasets', body).and_return(ok_response)
      result = client.create_dataset(account_id: 'a1', gateway_id: 'gw1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_dataset' do
    it 'DELETEs a dataset' do
      allow(connection).to receive(:delete).with('/accounts/a1/ai-gateway/gateways/gw1/datasets/ds1').and_return(ok_response)
      result = client.delete_dataset(account_id: 'a1', gateway_id: 'gw1', id: 'ds1')
      expect(result[:status]).to eq(200)
    end
  end
end
