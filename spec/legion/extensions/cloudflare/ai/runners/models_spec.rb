# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Ai::Runners::Models do
  let(:client)     { Legion::Extensions::Cloudflare::Ai::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#run' do
    it 'POSTs to execute an AI model' do
      body = { prompt: 'Hello, world!' }
      allow(connection).to receive(:post).with('/accounts/a1/ai/run/@cf/meta/llama-3-8b-instruct', body).and_return(ok_response)
      result = client.run(account_id: 'a1', model_name: '@cf/meta/llama-3-8b-instruct', body: body)
      expect(result[:status]).to eq(200)
    end
  end

  describe '#search_models' do
    it 'GETs model search results' do
      allow(connection).to receive(:get).with('/accounts/a1/ai/models/search', { search: 'llama' }).and_return(list_response)
      result = client.search_models(account_id: 'a1', search: 'llama')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#model_schema' do
    it 'GETs a model schema' do
      allow(connection).to receive(:get).with('/accounts/a1/ai/models/schema', { model: '@cf/meta/llama-3-8b-instruct' }).and_return(ok_response)
      result = client.model_schema(account_id: 'a1', model: '@cf/meta/llama-3-8b-instruct')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#supported_markdown_formats' do
    it 'GETs supported formats' do
      allow(connection).to receive(:get).with('/accounts/a1/ai/tomarkdown/supported').and_return(list_response)
      result = client.supported_markdown_formats(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end
end
