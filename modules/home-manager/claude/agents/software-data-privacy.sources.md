---
name: Software Data Privacy — Sources
description: Research provenance for the software-data-privacy agent. Lists agents/skills consulted, frameworks surveyed, and articles that informed specific heuristics.
---

## Agents & Skills Consulted

### awesome-claude-code-subagents (VoltAgent)
- Repository: https://github.com/VoltAgent/awesome-claude-code-subagents
- Surveyed for privacy-related agent examples. No dedicated privacy agent was found in the 131+ agent collection. The closest adjacent agents were: Compliance Auditor (regulatory compliance), Security Auditor (vulnerability identification), and Penetration Tester (ethical hacking). Individual agent files returned 404 — structure was inferred from the repository README and category listings.
- Design influences drawn from peer agents in this project: `software-architecture.md` (tradeoff framing, defer-to-peer-agents pattern) and `software-api-design.md` (protocol detection step, specificity of checks, output format per task mode).

---

## Regulatory Frameworks Surveyed

### GDPR (General Data Protection Regulation)
- Art. 5 — Principles relating to processing (lawfulness, fairness, transparency; purpose limitation; data minimization; accuracy; storage limitation; integrity and confidentiality): https://gdpr-info.eu/art-5-gdpr/
- Art. 6 — Lawful basis for processing
- Art. 17 — Right to erasure ("right to be forgotten")
- Art. 20 — Right to data portability
- Art. 28 — Processor requirements / Data Processing Agreements
- Art. 35 — Data Protection Impact Assessment (DPIA) triggers
- Cumulative fines context (>€7.1 billion, 60%+ since Jan 2023; France CNIL fined Free Mobile €27M in early 2026 for retention failures): https://securitywall.co/blog/gdpr-compliance-checklist-2026-guide-templates-audit-steps
- Developer guide: https://mobidev.biz/blog/gdpr-compliant-software-development-guide
- GDPR software requirements: https://www.cookieyes.com/blog/gdpr-software-requirements/
- GDPR compliance checklist (BitSight): https://www.bitsight.com/learn/compliance/gdpr-compliance-checklist
- Data minimization and retention enforcement (2026): https://secureprivacy.ai/blog/data-minimization-retention-enforcement

### CCPA / CPRA (California Consumer Privacy Act / California Privacy Rights Act)
- Official CCPA page (CA DOJ): https://oag.ca.gov/privacy/ccpa
- CPRA compliance checklist (Transcend): https://transcend.io/blog/cpra-compliance
- CPRA compliance (Endpoint Protector): https://www.endpointprotector.com/blog/cpra-compliance-checklist/
- Secureframe CCPA/CPRA guide: https://secureframe.com/blog/ccpa-compliance
- Securiti CCPA checklist: https://securiti.ai/blog/ccpa-compliance-checklist/
- CPPA FAQ: https://cppa.ca.gov/faq.html
- Key heuristic sourced: CPRA is the first US privacy law to codify data minimization as a statutory requirement; SPI (sensitive personal information) requires a separate limit-use opt-out mechanism; consumer request deadlines (opt-out: 15 business days; know/delete/correct: 45 days, extendable to 90).

### HIPAA (Health Insurance Portability and Accountability Act)
- HHS HIPAA de-identification guidance (Safe Harbor / Expert Determination methods): https://www.hhs.gov/hipaa/for-professionals/special-topics/de-identification/index.html
- 18 HIPAA identifiers: https://censinet.com/perspectives/18-hipaa-identifiers-for-phi-de-identification
- HIPAA compliance checklist for software development (Raftlabs): https://www.raftlabs.com/blog/hipaa-compliant-software-development-checklist/
- HIPAA for developers — requirements and technical controls (AccountableHQ): https://www.accountablehq.com/post/hipaa-compliance-for-developers-requirements-technical-controls-and-step-by-step-checklist
- 2026 HIPAA developer checklist (DEV Community): https://dev.to/joegellatly/the-2026-hipaa-compliance-checklist-for-developers-and-it-teams-48nj
- HIPAA AI software development (NinetyTwo.co): https://www.ninetwothree.co/blog/hipaa-compliant-ai-software-development
- Key heuristic sourced: minimum necessary standard must be enforced at every endpoint and query, not just the UI layer; PHI must not appear in logs, telemetry, or error responses.

### PIPEDA (Personal Information Protection and Electronic Documents Act)
- Office of the Privacy Commissioner of Canada — PIPEDA overview: https://www.priv.gc.ca/en/privacy-topics/privacy-laws-in-canada/the-personal-information-protection-and-electronic-documents-act-pipeda/
- PIPEDA 10 fair information principles: https://www.priv.gc.ca/en/privacy-topics/privacy-laws-in-canada/the-personal-information-protection-and-electronic-documents-act-pipeda/p_principle/
- PIPEDA compliance checklist (Usercentrics, 2026): https://usercentrics.com/resources/pipeda-checklist/
- PIPEDA compliance for SaaS (ComplyDog): https://complydog.com/blog/pipeda-compliance-guide-canadian-privacy-law-saas-companies
- Key heuristic sourced: PIPEDA uses a hybrid consent model (express for sensitive data, implied for lower-risk); 10 principles map closely to GDPR but with a more flexible "appropriate purposes" standard vs. strict lawful basis enumeration.

### Privacy by Design (Ann Cavoukian's 7 Foundational Principles)
- Original paper (IPC Ontario): https://www.ipc.on.ca/en/media/1826/download?attachment=
- SFU hosted copy: https://www.sfu.ca/~palys/Cavoukian-2011-PrivacyByDesign-7FoundationalPrinciples.pdf
- Waterloo CS copy: https://student.cs.uwaterloo.ca/~cs492/papers/7foundationalprinciples_longer.pdf
- Wikipedia overview: https://en.wikipedia.org/wiki/Privacy_by_design
- Carbide Secure — 7 principles summary: https://carbidesecure.com/resources/the-seven-principles-of-privacy-by-design/
- Operationalizing PbD guide: https://gpsbydesigncentre.com/wp-content/uploads/2021/08/Doc-5-Operationalizing-pbd-guide.pdf
- Key heuristics sourced: Principle 2 (Privacy as Default) → default-to-private check; Principle 3 (Embedded into Design) → data layer access control, pseudonymization at the analytics pipeline; Principle 5 (End-to-End Security) → deletion propagation through all stores including backups.

### NIST Privacy Framework v1.0
- NIST Privacy Framework landing page: https://www.nist.gov/privacy-framework
- Full framework PDF: https://www.nist.gov/system/files/documents/2020/01/16/NIST%20Privacy%20Framework_V1.0.pdf
- IAPP overview: https://iapp.org/news/a/standardization-landscape-for-privacy-part-1-the-nist-privacy-framework
- NISTIR 8062 — privacy engineering objectives (predictability, manageability, disassociability)
- Key heuristics sourced: disassociability objective → pseudonymization/tokenization patterns; manageability objective → data subject rights machinery; privacy risk framing as likelihood × problematic data actions.

### ISO/IEC 29101:2018 — Privacy Architecture Framework
- ISO standard listing: https://www.iso.org/standard/75293.html
- Key heuristics sourced: PII controller / PII processor role distinction (maps to GDPR controller/processor); privacy safeguarding requirements as architectural constraints rather than bolt-ons.

---

## Articles Informing Specific Heuristics

### PII in Logs & Telemetry
- "Keep PII Out of Your Telemetry" (OneUptime, 2025): https://oneuptime.com/blog/post/2025-11-13-keep-pii-out-of-observability-telemetry/view
- "Scrub PII from OpenTelemetry Logs, Traces, and Metrics" (OneUptime, 2026): https://oneuptime.com/blog/post/2026-02-06-scrub-pii-opentelemetry-logs-traces-metrics/view
- "Why PII in Production Logs is a Critical Threat" (Hoop.dev): https://hoop.dev/blog/why-pii-in-production-logs-is-a-critical-threat/
- "Masking PII in OpenTelemetry" (Medium/Chaos to Clarity): https://medium.com/@sonal.sadafal/masking-pii-in-opentelemetry-how-to-keep-observability-secure-and-compliant-07baeac1a286
- Guidewire Security — Logging Sensitive Information: https://docs.guidewire.com/security/secure-coding-guidance/logging-sensitive-information-PII/
- Heuristic derived: allow-list approach for log field names (centrally defined approved keys) is more robust than deny-list (easy to bypass with new field names).

### Consent Dark Patterns
- CookieYes — dark patterns in cookie consent: https://www.cookieyes.com/blog/dark-patterns-in-cookie-consent/
- DataGrail — cookie consent style guide: https://www.datagrail.io/blog/data-privacy/cookie-consent-style-guide-best-practices-how-to-design-banners-without-dark-patterns/
- Arxiv — evolving dark patterns in consent banners (2026): https://arxiv.org/html/2603.21515v1
- Secureprivacy — avoiding dark patterns: https://secureprivacy.ai/blog/avoiding-dark-patterns-cookie-consent
- Lokker — deceptive consent tactics: https://lokker.com/dark-patterns-in-consent-management-deceptive-tactics-and-their-costly-consequences/
- FTC/CPRA dark patterns regulation (U Chicago Business Law Review): https://businesslawreview.uchicago.edu/print-archive/ftc-and-cpras-regulation-dark-patterns-cookie-consent-notices
- Heuristics derived: symmetry check (reject = same prominence as accept); click parity (opt-out ≤ same steps as opt-in); pre-ticked box = automatic finding.

### Data Retention & Deletion Patterns
- GDPR for Data Engineers (blog.pmunhoz.com): https://blog.pmunhoz.com/data-engineering/gdpr_data_engineers_guide
- "How to implement soft vs hard TTL for GDPR deletion" (DesignGurus): https://www.designgurus.io/answers/detail/how-would-you-implement-soft-vs-hard-ttl-for-gdpr-deletion
- "Building GDPR-Compliant User Deletion: A Full-Stack Approach" (Homi): https://www.homi.so/blog/engineering/user-deletion-gdpr-implementation
- Databricks — "Right to be Forgotten" with Delta Live Tables: https://www.databricks.com/blog/handling-right-be-forgotten-gdpr-and-ccpa-using-delta-live-tables-dlt
- Heuristics derived: soft-delete-only is insufficient (data remains queryable by internal tools); deletion must cascade through bronze/silver/gold pipeline layers; backup restoration must re-apply pending deletions.

### Third-Party Sharing & DPAs
- ComplyDog — DPA meaning and guide: https://complydog.com/blog/dpa-meaning-data-processing-agreement-guide-gdpr-compliance
- Secureprivacy — SaaS DPA guide: https://secureprivacy.ai/blog/data-processing-agreements-dpas-for-saas
- CookieYes — 10 must-have DPA clauses: https://www.cookieyes.com/blog/data-processing-agreement/
- Privacy World — US privacy law contracting requirements: https://www.privacyworld.blog/2023/03/the-bare-minimum-and-more-complying-with-the-contracting-requirements-under-u-s-privacy-laws/
- Heuristic derived: SDK initialization check (session replay and analytics SDKs default to capturing form inputs — must verify PII scrubbing configuration, not just assume the vendor handles it).

### Breach Notification
- GDPR breach notification (Reform): https://www.reform.app/blog/gdpr-breach-notification-requirements
- HIPAA breach notification requirements (HIPAA Journal, 2026): https://www.hipaajournal.com/hipaa-breach-notification-requirements/
- CCPA breach requirements guide (CompliQuest, 2026): https://www.compliquest.com/en/blog/ccpa-data-breach-requirements-guide-2026
- State-by-state breach notification guide (LegalPolicyGen, 2026): https://legalpolicygen.com/blog/data-breach-notification-laws-us-guide
- Kroll — integrating breach notification with incident response: https://www.kroll.com/en/publications/cyber/integrate-breach-notification-incident-response-plan

### DPIA / PIA Process
- GDPR.eu — DPIA template: https://gdpr.eu/data-protection-impact-assessment-template/
- EDPB 9 DPIA criteria reference
- OPC Canada — PIA process guide: https://www.priv.gc.ca/en/privacy-topics/privacy-impact-assessments/gd_exp_202003/
- CNIL — PIA tool: https://www.cnil.fr/en/privacy-impact-assessment-pia
- IAPP — private sector PIA template: https://iapp.org/resources/article/private-sector-privacy-impact-assessment-template/

### AI & GDPR (2026 context)
- "GDPR for AI Developers 2026 Compliance Guide" (Medium): https://medium.com/@odere.pub/gdpr-for-ai-developers-compliance-guide-0125bf12a1d2
- LI3ARA/GDPR on GitHub — practical guidance for ML engineers: https://github.com/LI3ARA/GDPR
