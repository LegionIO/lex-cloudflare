# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Accounts::Runners::Roles do
  let(:client)        { Legion::Extensions::Cloudflare::Accounts::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_roles' do
    it 'GETs all roles' do
      allow(connection).to receive(:get).with('/accounts/a1/roles', {}).and_return(list_response)
      result = client.list_roles(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end

    it 'passes pagination params' do
      allow(connection).to receive(:get).with('/accounts/a1/roles', { page: 2, per_page: 25 }).and_return(list_response)
      result = client.list_roles(account_id: 'a1', page: 2, per_page: 25)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_role' do
    it 'GETs a single role' do
      allow(connection).to receive(:get).with('/accounts/a1/roles/r1').and_return(ok_response)
      result = client.get_role(account_id: 'a1', role_id: 'r1')
      expect(result[:result]).to include('success' => true)
    end
  end
end
