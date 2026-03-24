# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::AiGateway::Runners::Evaluations do
  let(:client)     { Legion::Extensions::Cloudflare::AiGateway::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_evaluations' do
    it 'GETs evaluations' do
      allow(connection).to receive(:get).with('/accounts/a1/ai-gateway/gateways/gw1/evaluations', {}).and_return(list_response)
      result = client.list_evaluations(account_id: 'a1', gateway_id: 'gw1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create_evaluation' do
    it 'POSTs a new evaluation' do
      body = { name: 'my-eval', dataset_ids: ['ds1'], evaluation_type_ids: ['et1'] }
      allow(connection).to receive(:post).with('/accounts/a1/ai-gateway/gateways/gw1/evaluations', body).and_return(ok_response)
      result = client.create_evaluation(account_id: 'a1', gateway_id: 'gw1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_evaluation' do
    it 'DELETEs an evaluation' do
      allow(connection).to receive(:delete).with('/accounts/a1/ai-gateway/gateways/gw1/evaluations/e1').and_return(ok_response)
      result = client.delete_evaluation(account_id: 'a1', gateway_id: 'gw1', id: 'e1')
      expect(result[:status]).to eq(200)
    end
  end
end
