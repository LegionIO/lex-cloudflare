# lex-cloudflare

Cloudflare integration for [LegionIO](https://github.com/LegionIO/LegionIO). Provides runners for DNS, DNS Firewall, Custom Nameservers, Zero Trust, SSL, Vectorize, AI Gateway, and Workers AI via the Cloudflare REST API.

## Installation

```bash
gem install lex-cloudflare
```

## Sub-modules

### Dns
DNS records and DNSSEC management for a zone.

```ruby
client = Legion::Extensions::Cloudflare::Dns::Client.new(api_token: 'your-token')
client.list(zone_id: 'abc123')
client.create(zone_id: 'abc123', body: { type: 'A', name: 'example.com', content: '1.2.3.4', ttl: 3600 })
client.get_dnssec(zone_id: 'abc123')
```

### DnsFirewall
DNS Firewall cluster management and analytics (account-scoped).

```ruby
client = Legion::Extensions::Cloudflare::DnsFirewall::Client.new(api_token: 'your-token')
client.list(account_id: 'acct123')
client.create(account_id: 'acct123', name: 'my-cluster', upstream_ips: ['1.2.3.4'])
client.report(account_id: 'acct123', dns_firewall_id: 'fw123')
```

### CustomNameservers
Account-level custom nameserver management.

```ruby
client = Legion::Extensions::Cloudflare::CustomNameservers::Client.new(api_token: 'your-token')
client.list(account_id: 'acct123')
client.add(account_id: 'acct123', ns_name: 'ns1.example.com')
```

### ZeroTrust
Devices, registrations, DEX tests, and IP profiles.

```ruby
client = Legion::Extensions::Cloudflare::ZeroTrust::Client.new(api_token: 'your-token')
client.list_devices(account_id: 'acct123')
client.list_registrations(account_id: 'acct123')
client.list_dex_tests(account_id: 'acct123')
```

### Ssl
Certificate packs, universal SSL settings, and verification.

```ruby
client = Legion::Extensions::Cloudflare::Ssl::Client.new(api_token: 'your-token')
client.list_packs(zone_id: 'zone123')
client.get_universal_settings(zone_id: 'zone123')
```

### Vectorize
Vector index management and vector operations.

```ruby
client = Legion::Extensions::Cloudflare::Vectorize::Client.new(api_token: 'your-token')
client.list_indexes(account_id: 'acct123')
client.create_index(account_id: 'acct123', name: 'my-index', config: { dimensions: 1536, metric: 'cosine' })
client.query(account_id: 'acct123', index_name: 'my-index', vector: [0.1, 0.2, ...], top_k: 5)
```

### AiGateway
AI Gateway management, log inspection, datasets, and evaluations.

```ruby
client = Legion::Extensions::Cloudflare::AiGateway::Client.new(api_token: 'your-token')
client.list_gateways(account_id: 'acct123')
client.list_logs(account_id: 'acct123', gateway_id: 'gw123')
```

### Ai
Workers AI model execution, finetune management, and model search.

```ruby
client = Legion::Extensions::Cloudflare::Ai::Client.new(api_token: 'your-token')
client.run(account_id: 'acct123', model_name: '@cf/meta/llama-3-8b-instruct', body: { prompt: 'Hello' })
client.list_finetunes(account_id: 'acct123')
client.search_models(account_id: 'acct123', search: 'llama')
```

## Requirements

- Ruby >= 3.4
- [LegionIO](https://github.com/LegionIO/LegionIO) framework
- Cloudflare API token with appropriate permissions

## License

MIT
