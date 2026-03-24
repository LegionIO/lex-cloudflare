# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Accounts::Runners::Accounts do
  let(:client)        { Legion::Extensions::Cloudflare::Accounts::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list' do
    it 'GETs all accounts' do
      allow(connection).to receive(:get).with('/accounts', {}).and_return(list_response)
      result = client.list
      expect(result[:status]).to eq(200)
    end

    it 'passes filter params' do
      allow(connection).to receive(:get).with('/accounts', { name: 'my-org' }).and_return(list_response)
      result = client.list(name: 'my-org')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get' do
    it 'GETs a single account' do
      allow(connection).to receive(:get).with('/accounts/a1').and_return(ok_response)
      result = client.get(account_id: 'a1')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#create' do
    it 'POSTs a new account' do
      allow(connection).to receive(:post).with('/accounts', { name: 'new-org' }).and_return(ok_response)
      result = client.create(name: 'new-org')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#update' do
    it 'PUTs account changes' do
      body = { name: 'updated-org' }
      allow(connection).to receive(:put).with('/accounts/a1', body).and_return(ok_response)
      result = client.update(account_id: 'a1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete' do
    it 'DELETEs an account' do
      allow(connection).to receive(:delete).with('/accounts/a1').and_return(ok_response)
      result = client.delete(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_profile' do
    it 'GETs the account profile' do
      allow(connection).to receive(:get).with('/accounts/a1/profile').and_return(ok_response)
      result = client.get_profile(account_id: 'a1')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#update_profile' do
    it 'PUTs account profile changes' do
      body = { enforce_twofactor: true }
      allow(connection).to receive(:put).with('/accounts/a1/profile', body).and_return(ok_response)
      result = client.update_profile(account_id: 'a1', body: body)
      expect(result[:status]).to eq(200)
    end
  end
end
