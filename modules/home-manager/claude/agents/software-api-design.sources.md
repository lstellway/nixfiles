# Software API Design Agent — Sources

References that informed the heuristics in `software-api-design.md`.

## Existing Agents & Skills

- [VoltAgent/awesome-claude-code-subagents — api-designer.md](https://github.com/VoltAgent/awesome-claude-code-subagents/blob/main/categories/01-core-development/api-designer.md) — creator/designer workflow, checklist coverage, delegation pattern to peer agents

## Frameworks & Standards

- [Zalando RESTful API and Event Guidelines](https://opensource.zalando.com/restful-api-guidelines/) — naming conventions, pagination (cursor vs. offset), security schemes, OAuth scopes, error format, versioning policy
- [Google Cloud API Design Guide](https://docs.cloud.google.com/apis/design) — resource-oriented design, custom method colon syntax, idempotency keys
- [Google AIP-122: Resource names](https://google.aip.dev/122) — resource naming and URL structure
- [Microsoft Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) — date-based versioning, `operation-location` for long-running ops, `DELETE` idempotency, secrets in `GET`
- [JSON:API v1.1 Specification](https://jsonapi.org/format/) — sparse fieldsets, error source pointers, cursor pagination (`next` link), relationship modeling
- [GraphQL Best Practices](https://graphql.org/learn/best-practices/) — nullable fields, schema evolution, no versioning
- [The Guild — GraphQL Schema Design Best Practices](https://the-guild.dev/graphql/hive/blog/schema-design-best-practices-part-1) — typed mutation results, union error types, Relay `Node` interface
- [Buf Style Guide (Protobuf/gRPC)](https://buf.build/docs/best-practices/style-guide/) — field numbering, enum zero values, package versioning, dedicated request/response messages

## Tools & Checklists

- [Spectral — Open Source API Linter](https://stoplight.io/open-source/spectral) — `operationId`, description completeness, security scheme presence, response code coverage; benchmark for automated rule checks
- [OpenAPI Best Practices — learn.openapis.org](https://learn.openapis.org/best-practices.html) — design-first vs. code-first, `$ref` reuse, examples
- [Specmatic — API Design Anti-patterns](https://specmatic.io/appearance/how-to-identify-avoid-api-design-anti-patterns/) — empty object schemas, spec/implementation drift
- [Kong — Best Practices for API Design](https://konghq.com/blog/engineering/best-practices-for-api-design-guidelines) — consumer-first framing, rate limiting headers
