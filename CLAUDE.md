# lex-cloudflare: Cloudflare Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Monolith Legion Extension connecting LegionIO to Cloudflare services. Implements 8 sub-modules covering DNS, network security, Zero Trust, SSL, Vectorize, and AI via the Cloudflare REST API v4.

**GitHub**: https://github.com/LegionIO/lex-cloudflare
**License**: MIT
**Version**: 0.1.0

## Architecture

```
Legion::Extensions::Cloudflare
├── Dns/                          # Zone-scoped DNS management
│   ├── Helpers::Client           # Bearer token auth, base URL
│   ├── Runners::Records          # DNS record CRUD (21 types: A, AAAA, CNAME, MX, etc.)
│   ├── Runners::Dnssec           # DNSSEC get/edit/delete
│   └── Client                   # initialize(api_token:)
├── DnsFirewall/                  # Account-scoped DNS Firewall cluster management
│   ├── Helpers::Client
│   ├── Runners::Clusters         # Cluster CRUD
│   ├── Runners::Analytics        # Report, by-time report, reverse DNS
│   └── Client
├── CustomNameservers/            # Account-scoped custom nameserver management
│   ├── Helpers::Client
│   ├── Runners::Nameservers      # List, add, delete
│   └── Client
├── ZeroTrust/                    # Account-scoped Zero Trust device management
│   ├── Helpers::Client
│   ├── Runners::Devices          # Physical device list/get/delete/revoke
│   ├── Runners::Registrations    # WARP registration management
│   ├── Runners::DexTests         # DEX test CRUD
│   ├── Runners::IpProfiles       # IP profile CRUD
│   └── Client
├── Ssl/                          # Zone-scoped SSL/TLS certificate management
│   ├── Helpers::Client
│   ├── Runners::CertificatePacks # Pack CRUD, order, quota
│   ├── Runners::Universal        # Universal SSL settings, recommendations, verification
│   └── Client
├── Vectorize/                    # Account-scoped Vectorize index management
│   ├── Helpers::Client
│   ├── Runners::Indexes          # Index CRUD, info, metadata indexing
│   ├── Runners::Vectors          # Insert, upsert, query, get_by_ids, delete_by_ids
│   └── Client
├── AiGateway/                    # Account-scoped AI Gateway management
│   ├── Helpers::Client
│   ├── Runners::Gateways         # Gateway CRUD
│   ├── Runners::Logs             # Log list/get/patch/delete, request/response retrieval
│   ├── Runners::Datasets         # Dataset CRUD
│   ├── Runners::Evaluations      # Evaluation CRUD
│   └── Client
└── Ai/                           # Account-scoped Workers AI
    ├── Helpers::Client
    ├── Runners::Models           # Model execution, search, schema, markdown conversion
    ├── Runners::Finetunes        # Finetune management, public listing
    └── Client
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/cloudflare.rb` | Entry point, loads all sub-modules |
| `lib/legion/extensions/cloudflare/dns/client.rb` | DNS client: `initialize(api_token:)` |
| `lib/legion/extensions/cloudflare/vectorize/client.rb` | Vectorize client: `initialize(api_token:)` |
| `lib/legion/extensions/cloudflare/ai/client.rb` | AI client: `initialize(api_token:)` |

## Auth Pattern

All sub-modules use Bearer token authentication:
```ruby
conn.headers['Authorization'] = "Bearer #{api_token}"
```
Base URL: `https://api.cloudflare.com/client/v4`

## Resource Scoping

| Scope | Sub-modules | Path pattern |
|-------|-------------|--------------|
| Zone | Dns, Ssl | `/zones/{zone_id}/...` |
| Account | DnsFirewall, CustomNameservers, ZeroTrust, Vectorize, AiGateway, Ai | `/accounts/{account_id}/...` |

## API Coverage

| Sub-module | Runners | Key Methods |
|-----------|---------|-------------|
| Dns | Records, Dnssec | `list`, `get`, `create`, `update`, `delete`, `get_dnssec`, `edit_dnssec` |
| DnsFirewall | Clusters, Analytics | `list`, `get`, `create`, `update`, `delete`, `report`, `report_by_time`, `get_reverse_dns` |
| CustomNameservers | Nameservers | `list`, `add`, `delete` |
| ZeroTrust | Devices, Registrations, DexTests, IpProfiles | `list_devices`, `revoke_device`, `list_registrations`, `list_dex_tests`, `list_ip_profiles` |
| Ssl | CertificatePacks, Universal | `list_packs`, `order_pack`, `quota`, `get_universal_settings`, `list_verification` |
| Vectorize | Indexes, Vectors | `list_indexes`, `create_index`, `query`, `insert`, `upsert`, `get_by_ids`, `list_metadata_indexes` |
| AiGateway | Gateways, Logs, Datasets, Evaluations | `list_gateways`, `create_gateway`, `list_logs`, `patch_log`, `list_datasets`, `list_evaluations` |
| Ai | Models, Finetunes | `run`, `search_models`, `model_schema`, `to_markdown`, `list_finetunes`, `create_finetune` |

## Dependencies

| Gem | Purpose |
|-----|---------|
| `faraday` (>= 2.0) | HTTP client for all Cloudflare REST API calls |

## Development

120 specs total (0 failures).

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
