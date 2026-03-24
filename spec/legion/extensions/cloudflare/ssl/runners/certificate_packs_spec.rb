# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Ssl::Runners::CertificatePacks do
  let(:client)     { Legion::Extensions::Cloudflare::Ssl::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_packs' do
    it 'GETs certificate packs' do
      allow(connection).to receive(:get).with('/zones/z1/ssl/certificate_packs').and_return(list_response)
      result = client.list_packs(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_pack' do
    it 'GETs a single pack' do
      allow(connection).to receive(:get).with('/zones/z1/ssl/certificate_packs/p1').and_return(ok_response)
      result = client.get_pack(zone_id: 'z1', certificate_pack_id: 'p1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#order_pack' do
    it 'POSTs to order a certificate pack' do
      body = { certificate_authority: 'lets_encrypt', hosts: ['example.com'], type: 'advanced', validation_method: 'txt', validity_days: 90 }
      allow(connection).to receive(:post).with('/zones/z1/ssl/certificate_packs/order', body).and_return(ok_response)
      result = client.order_pack(zone_id: 'z1', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_pack' do
    it 'DELETEs a certificate pack' do
      allow(connection).to receive(:delete).with('/zones/z1/ssl/certificate_packs/p1').and_return(ok_response)
      result = client.delete_pack(zone_id: 'z1', certificate_pack_id: 'p1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#quota' do
    it 'GETs certificate pack quota' do
      allow(connection).to receive(:get).with('/zones/z1/ssl/certificate_packs/quota').and_return(ok_response)
      result = client.quota(zone_id: 'z1')
      expect(result[:status]).to eq(200)
    end
  end
end
