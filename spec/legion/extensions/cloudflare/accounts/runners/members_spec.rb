# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Accounts::Runners::Members do
  let(:client)        { Legion::Extensions::Cloudflare::Accounts::Client.new(api_token: 'tok') }
  let(:connection)    { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_members' do
    it 'GETs all members' do
      allow(connection).to receive(:get).with('/accounts/a1/members', {}).and_return(list_response)
      result = client.list_members(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end

    it 'passes status filter' do
      allow(connection).to receive(:get).with('/accounts/a1/members', { status: 'accepted' }).and_return(list_response)
      result = client.list_members(account_id: 'a1', status: 'accepted')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_member' do
    it 'GETs a single member' do
      allow(connection).to receive(:get).with('/accounts/a1/members/m1').and_return(ok_response)
      result = client.get_member(account_id: 'a1', member_id: 'm1')
      expect(result[:result]).to include('success' => true)
    end
  end

  describe '#add_member' do
    it 'POSTs a new member invitation' do
      body = { email: 'user@example.com', roles: [{ id: 'role-1' }] }
      allow(connection).to receive(:post).with('/accounts/a1/members', body).and_return(ok_response)
      result = client.add_member(account_id: 'a1', email: 'user@example.com', roles: [{ id: 'role-1' }])
      expect(result[:status]).to eq(200)
    end
  end

  describe '#update_member' do
    it 'PUTs member role changes' do
      body = { roles: [{ id: 'role-2' }] }
      allow(connection).to receive(:put).with('/accounts/a1/members/m1', body).and_return(ok_response)
      result = client.update_member(account_id: 'a1', member_id: 'm1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#remove_member' do
    it 'DELETEs a member' do
      allow(connection).to receive(:delete).with('/accounts/a1/members/m1').and_return(ok_response)
      result = client.remove_member(account_id: 'a1', member_id: 'm1')
      expect(result[:status]).to eq(200)
    end
  end
end
