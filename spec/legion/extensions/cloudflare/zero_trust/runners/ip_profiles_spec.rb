# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::ZeroTrust::Runners::IpProfiles do
  let(:client)     { Legion::Extensions::Cloudflare::ZeroTrust::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_ip_profiles' do
    it 'GETs IP profiles' do
      allow(connection).to receive(:get).with('/accounts/a1/devices/ip-profiles', {}).and_return(list_response)
      result = client.list_ip_profiles(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_ip_profile' do
    it 'GETs a single IP profile' do
      allow(connection).to receive(:get).with('/accounts/a1/devices/ip-profiles/p1').and_return(ok_response)
      result = client.get_ip_profile(account_id: 'a1', profile_id: 'p1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create_ip_profile' do
    it 'POSTs a new IP profile' do
      body = { name: 'my-profile', match: 'any(identity.groups.name[*] in {"employees"})' }
      allow(connection).to receive(:post).with('/accounts/a1/devices/ip-profiles', body).and_return(ok_response)
      result = client.create_ip_profile(account_id: 'a1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_ip_profile' do
    it 'DELETEs an IP profile' do
      allow(connection).to receive(:delete).with('/accounts/a1/devices/ip-profiles/p1').and_return(ok_response)
      result = client.delete_ip_profile(account_id: 'a1', profile_id: 'p1')
      expect(result[:status]).to eq(200)
    end
  end
end
