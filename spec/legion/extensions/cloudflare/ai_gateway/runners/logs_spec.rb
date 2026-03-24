# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::AiGateway::Runners::Logs do
  let(:client)     { Legion::Extensions::Cloudflare::AiGateway::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_logs' do
    it 'GETs gateway logs' do
      allow(connection).to receive(:get).with('/accounts/a1/ai-gateway/gateways/gw1/logs', {}).and_return(list_response)
      result = client.list_logs(account_id: 'a1', gateway_id: 'gw1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_log' do
    it 'GETs a single log entry' do
      allow(connection).to receive(:get).with('/accounts/a1/ai-gateway/gateways/gw1/logs/l1').and_return(ok_response)
      result = client.get_log(account_id: 'a1', gateway_id: 'gw1', id: 'l1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#patch_log' do
    it 'PATCHes a log entry' do
      body = { feedback: 1, score: 5 }
      allow(connection).to receive(:patch).with('/accounts/a1/ai-gateway/gateways/gw1/logs/l1', body).and_return(ok_response)
      result = client.patch_log(account_id: 'a1', gateway_id: 'gw1', id: 'l1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_logs' do
    it 'DELETEs logs' do
      allow(connection).to receive(:delete).with('/accounts/a1/ai-gateway/gateways/gw1/logs').and_return(ok_response)
      result = client.delete_logs(account_id: 'a1', gateway_id: 'gw1')
      expect(result[:status]).to eq(200)
    end
  end
end
