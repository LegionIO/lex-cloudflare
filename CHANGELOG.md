# Changelog

## [Unreleased]

## [0.1.2] - 2026-03-24

### Added
- WorkersRoutes sub-module: zone-scoped Workers route CRUD (list, get, create, update, delete)
- Pages sub-module: account-scoped Pages projects, deployments (retry/rollback), and custom domains
- 32 new specs covering all WorkersRoutes and Pages runners and clients (197 total)

## [0.1.1] - 2026-03-24

### Added
- Zones sub-module: zone CRUD, activation check, and zone settings (list/get)
- Accounts sub-module: account CRUD, profile, members, roles, and API token management
- 45 new specs covering all Zones and Accounts runners and clients (165 total)

## [0.1.0] - 2026-03-24

### Added
- Initial implementation with Dns, DnsFirewall, CustomNameservers, ZeroTrust, Ssl, Vectorize, AiGateway, and Ai sub-modules
- Dns: DNS records CRUD and DNSSEC management (zone-scoped)
- DnsFirewall: cluster CRUD, analytics reports, and reverse DNS (account-scoped)
- CustomNameservers: account-level custom nameserver management
- ZeroTrust: devices, registrations, DEX tests, and IP profiles
- Ssl: certificate packs, universal SSL settings, and verification
- Vectorize: vector index CRUD, vector operations, and metadata indexing
- AiGateway: gateway CRUD, log management, datasets, and evaluations
- Ai: model execution, finetune management, model search, and markdown conversion
