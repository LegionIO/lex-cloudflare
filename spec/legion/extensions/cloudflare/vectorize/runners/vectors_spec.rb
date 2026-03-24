# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Vectorize::Runners::Vectors do
  let(:client)     { Legion::Extensions::Cloudflare::Vectorize::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response) { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#insert' do
    it 'POSTs vectors to insert' do
      body = { vectors: [{ id: '1', values: [0.1, 0.2] }] }
      allow(connection).to receive(:post).with('/accounts/a1/vectorize/v2/indexes/my-index/insert', body).and_return(ok_response)
      result = client.insert(account_id: 'a1', index_name: 'my-index', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#query' do
    it 'POSTs a vector query' do
      allow(connection).to receive(:post).with(
        '/accounts/a1/vectorize/v2/indexes/my-index/query',
        { vector: [0.1, 0.2], topK: 5 }
      ).and_return(ok_response)
      result = client.query(account_id: 'a1', index_name: 'my-index', vector: [0.1, 0.2], top_k: 5)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#get_by_ids' do
    it 'POSTs to fetch vectors by IDs' do
      allow(connection).to receive(:post).with(
        '/accounts/a1/vectorize/v2/indexes/my-index/get_by_ids',
        { ids: %w[1 2] }
      ).and_return(ok_response)
      result = client.get_by_ids(account_id: 'a1', index_name: 'my-index', ids: %w[1 2])
      expect(result[:status]).to eq(200)
    end
  end

  describe '#delete_by_ids' do
    it 'POSTs to delete vectors by IDs' do
      allow(connection).to receive(:post).with(
        '/accounts/a1/vectorize/v2/indexes/my-index/delete_by_ids',
        { ids: %w[1 2] }
      ).and_return(ok_response)
      result = client.delete_by_ids(account_id: 'a1', index_name: 'my-index', ids: %w[1 2])
      expect(result[:status]).to eq(200)
    end
  end
end
