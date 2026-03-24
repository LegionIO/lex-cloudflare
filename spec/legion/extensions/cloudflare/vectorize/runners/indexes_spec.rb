# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Vectorize::Runners::Indexes do
  let(:client)     { Legion::Extensions::Cloudflare::Vectorize::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_indexes' do
    it 'GETs all vector indexes' do
      allow(connection).to receive(:get).with('/accounts/a1/vectorize/v2/indexes').and_return(list_response)
      result = client.list_indexes(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_index' do
    it 'GETs a single index' do
      allow(connection).to receive(:get).with('/accounts/a1/vectorize/v2/indexes/my-index').and_return(ok_response)
      result = client.get_index(account_id: 'a1', index_name: 'my-index')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create_index' do
    it 'POSTs a new index' do
      body = { name: 'my-index', config: { dimensions: 1536, metric: 'cosine' } }
      allow(connection).to receive(:post).with('/accounts/a1/vectorize/v2/indexes', body).and_return(ok_response)
      result = client.create_index(account_id: 'a1', name: 'my-index', config: { dimensions: 1536, metric: 'cosine' })
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_index' do
    it 'DELETEs an index' do
      allow(connection).to receive(:delete).with('/accounts/a1/vectorize/v2/indexes/my-index').and_return(ok_response)
      result = client.delete_index(account_id: 'a1', index_name: 'my-index')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#index_info' do
    it 'GETs index info' do
      allow(connection).to receive(:get).with('/accounts/a1/vectorize/v2/indexes/my-index/info').and_return(ok_response)
      result = client.index_info(account_id: 'a1', index_name: 'my-index')
      expect(result[:status]).to eq(200)
    end
  end
end
