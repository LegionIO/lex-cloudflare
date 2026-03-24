# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Accounts::Runners::Tokens do
  let(:client)        { Legion::Extensions::Cloudflare::Accounts::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_tokens' do
    it 'GETs all tokens' do
      allow(connection).to receive(:get).with('/accounts/a1/tokens', {}).and_return(list_response)
      result = client.list_tokens(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end

    it 'passes pagination params' do
      allow(connection).to receive(:get).with('/accounts/a1/tokens', { page: 1, per_page: 20 }).and_return(list_response)
      result = client.list_tokens(account_id: 'a1', page: 1, per_page: 20)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_token' do
    it 'GETs a single token' do
      allow(connection).to receive(:get).with('/accounts/a1/tokens/t1').and_return(ok_response)
      result = client.get_token(account_id: 'a1', token_id: 't1')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#create_token' do
    it 'POSTs a new token' do
      policies = [{ effect: 'allow', resources: { 'com.cloudflare.api.account.*' => '*' }, permission_groups: [] }]
      body = { name: 'my-token', policies: policies }
      allow(connection).to receive(:post).with('/accounts/a1/tokens', body).and_return(ok_response)
      result = client.create_token(account_id: 'a1', name: 'my-token', policies: policies)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#update_token' do
    it 'PUTs token changes' do
      body = { status: 'disabled' }
      allow(connection).to receive(:put).with('/accounts/a1/tokens/t1', body).and_return(ok_response)
      result = client.update_token(account_id: 'a1', token_id: 't1', body: body)
      expect(result[:status]).to eq(200)
    end
  end
end
