# frozen_string_literal: true

RSpec.describe Legion::Extensions::Cloudflare do
  it 'has a version number' do
    expect(Legion::Extensions::Cloudflare::VERSION).not_to be_nil
  end

  it 'defines the Dns sub-module' do
    expect(described_class.const_defined?(:Dns)).to be true
  end

  it 'defines the DnsFirewall sub-module' do
    expect(described_class.const_defined?(:DnsFirewall)).to be true
  end

  it 'defines the CustomNameservers sub-module' do
    expect(described_class.const_defined?(:CustomNameservers)).to be true
  end

  it 'defines the ZeroTrust sub-module' do
    expect(described_class.const_defined?(:ZeroTrust)).to be true
  end

  it 'defines the Ssl sub-module' do
    expect(described_class.const_defined?(:Ssl)).to be true
  end

  it 'defines the Vectorize sub-module' do
    expect(described_class.const_defined?(:Vectorize)).to be true
  end

  it 'defines the AiGateway sub-module' do
    expect(described_class.const_defined?(:AiGateway)).to be true
  end

  it 'defines the Ai sub-module' do
    expect(described_class.const_defined?(:Ai)).to be true
  end

  it 'defines the Zones sub-module' do
    expect(described_class.const_defined?(:Zones)).to be true
  end

  it 'defines the Accounts sub-module' do
    expect(described_class.const_defined?(:Accounts)).to be true
  end
end
