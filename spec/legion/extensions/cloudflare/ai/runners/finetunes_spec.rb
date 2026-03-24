# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare::Ai::Runners::Finetunes do
  let(:client)     { Legion::Extensions::Cloudflare::Ai::Client.new(api_token: 'tok') }
  let(:connection) { instance_double(Faraday::Connection) }
  let(:ok_response)   { instance_double(Faraday::Response, body: { 'success' => true }, status: 200) }
  let(:list_response) { instance_double(Faraday::Response, body: { 'result' => [] }, status: 200) }

  before { allow(client).to receive(:client).and_return(connection) }

  describe '#list_finetunes' do
    it 'GETs all finetunes' do
      allow(connection).to receive(:get).with('/accounts/a1/ai/finetunes').and_return(list_response)
      result = client.list_finetunes(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#create_finetune' do
    it 'POSTs a new finetune job' do
      allow(connection).to receive(:post).with(
        '/accounts/a1/ai/finetunes',
        { model: '@cf/meta/llama-3-8b-instruct', name: 'my-finetune' }
      ).and_return(ok_response)
      result = client.create_finetune(account_id: 'a1', model: '@cf/meta/llama-3-8b-instruct', name: 'my-finetune')
      expect(result[:status]).to eq(200)
    end
  end

  describe '#list_public_finetunes' do
    it 'GETs public finetunes' do
      allow(connection).to receive(:get).with('/accounts/a1/ai/finetunes/public', {}).and_return(list_response)
      result = client.list_public_finetunes(account_id: 'a1')
      expect(result[:status]).to eq(200)
    end
  end
end
