# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::AiGateway::Runners::Gateways do
  let(:client)     { Legion::Extensions::Cloudflare::AiGateway::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_gateways' do
    it 'GETs all gateways' do
      allow(connection).to receive(:get).with('/accounts/a1/ai-gateway/gateways', {}).and_return(list_response)
      result = client.list_gateways(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_gateway' do
    it 'GETs a single gateway' do
      allow(connection).to receive(:get).with('/accounts/a1/ai-gateway/gateways/gw1').and_return(ok_response)
      result = client.get_gateway(account_id: 'a1', id: 'gw1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create_gateway' do
    it 'POSTs a new gateway' do
      body = { id: 'my-gateway', collect_logs: true }
      allow(connection).to receive(:post).with('/accounts/a1/ai-gateway/gateways', body).and_return(ok_response)
      result = client.create_gateway(account_id: 'a1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_gateway' do
    it 'DELETEs a gateway' do
      allow(connection).to receive(:delete).with('/accounts/a1/ai-gateway/gateways/gw1').and_return(ok_response)
      result = client.delete_gateway(account_id: 'a1', id: 'gw1')
      expect(result[:status]).to eq(200)
    end
  end
end
