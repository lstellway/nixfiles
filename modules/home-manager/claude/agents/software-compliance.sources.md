# Software Compliance Agent — Sources & Design Notes

## Framework Versions Applied

| Framework | Version Used | Notes |
|---|---|---|
| SOC 2 / Trust Services Criteria | AICPA TSC 2017, Revised Points of Focus 2022 | Core criteria unchanged from 2017; points of focus updated Fall 2022. Common Criteria numbered CC1–CC9. |
| ISO/IEC 27001 | ISO/IEC 27001:2022 | Replaces ISO 27001:2013. 93 controls in 4 themes (Organizational, People, Physical, Technological); down from 114 controls in 5 domains due to merges. 11 new controls added covering threat intelligence, cloud security, ICT continuity, and physical security monitoring. |
| PCI DSS | v4.0.1 | v4.0 published March 2022; v4.0.1 (limited revision, no new/deleted requirements) is current. v3.2.1 retired December 31, 2024. As of March 31, 2025, all requirements including previously future-dated ones are mandatory. |
| HIPAA Security Rule | 45 CFR Part 164, Subpart C (current); NPRM December 2024 | Current rule distinguishes "required" and "addressable" implementation specifications. December 2024 NPRM proposes eliminating that distinction (all specifications become mandatory) and adding new requirements for MFA, encryption, and network segmentation. Final rule expected ~2026. |
| FedRAMP | Rev. 5 baselines (based on NIST SP 800-53 Rev. 5) | Low, Moderate (~323 controls), High (~410 controls), LI-SaaS. |
| NIST CSF | v2.0, published February 26, 2024 | Six functions: Govern (new in v2.0), Identify, Protect, Detect, Respond, Recover. Expanded scope from critical infrastructure to all organizations. 22 categories, 106 subcategories. |
| GDPR | Regulation (EU) 2016/679, in force May 25, 2018 | Article 25 (data protection by design and by default) and Article 32 (security of processing) are the primary technical/organizational measure provisions. "State of the art" is a dynamic standard, not a fixed benchmark. |

## Reference Sources

### SOC 2
- AICPA. *2017 Trust Services Criteria for Security, Availability, Processing Integrity, Confidentiality, and Privacy (With Revised Points of Focus — 2022)*. https://www.aicpa-cima.com/resources/download/2017-trust-services-criteria-with-revised-points-of-focus-2022
- Truvocyber. *SOC 2 Trust Services Criteria: The Complete CC1-CC9 Reference Guide*. https://truvocyber.com/blog/soc-2-trust-services-criteria-guide
- SOC 2 Auditors. *SOC 2 Security Controls: CC6 & CC7 Deep-Dive*. https://soc2auditors.org/insights/soc-2-security-controls/

### ISO 27001
- ISO. *ISO/IEC 27001:2022 — Information security management systems*. https://www.iso.org/standard/27001
- Hightable. *ISO 27001 Annex A Controls: The Complete 2022 Reference List (93 Controls)*. https://hightable.io/iso-27001-annex-a-controls-reference-guide/
- ISMS.online. *ISO 27001:2022 Annex A Explained & Simplified*. https://www.isms.online/iso-27001/annex-a-2022/

### PCI DSS
- PCI Security Standards Council. *PCI DSS v4.0.1* (official document library). https://www.pcisecuritystandards.org/document_library/
- PCI SSC Blog. *Just Published: PCI DSS v4.0.1*. https://blog.pcisecuritystandards.org/just-published-pci-dss-v4-0-1
- PCI SSC Blog. *Now is the Time for Organizations to Adopt the Future-Dated Requirements of PCI DSS v4.x*. https://blog.pcisecuritystandards.org/now-is-the-time-for-organizations-to-adopt-the-future-dated-requirements-of-pci-dss-v4-x
- UpGuard. *How to Comply with PCI DSS 4.0.1 (2026 Guide)*. https://www.upguard.com/blog/pci-compliance

### HIPAA
- HHS Office for Civil Rights. *The Security Rule*. https://www.hhs.gov/hipaa/for-professionals/security/index.html
- Federal Register. *HIPAA Security Rule to Strengthen the Cybersecurity of Electronic Protected Health Information* (NPRM, January 6, 2025). https://www.federalregister.gov/documents/2025/01/06/2024-30983/hipaa-security-rule-to-strengthen-the-cybersecurity-of-electronic-protected-health-information
- HHS. *HIPAA Security Rule NPRM Fact Sheet*. https://www.hhs.gov/hipaa/for-professionals/security/hipaa-security-rule-nprm/factsheet/index.html
- RubinBrown. *HIPAA Security Rule Changes: 2025 & 2026 HIPAA Updates*. https://www.rubinbrown.com/insights-events/insight-articles/hipaa-security-rule-changes-2025-2026-hipaa-updates/

### FedRAMP
- FedRAMP. *Important Considerations — Authorization*. https://www.fedramp.gov/docs/rev5/playbook/csp/authorization/considerations/
- Vanta. *FedRAMP Requirements: What They Are For Each Baseline + Checklist*. https://www.vanta.com/collection/fedramp/fedramp-requirements
- FedRAMP. *FedRAMP Moderate Security Controls* (Excel). https://www.fedramp.gov/resources/documents/FedRAMP_Moderate_Security_Controls.xlsx

### NIST CSF
- NIST. *The NIST Cybersecurity Framework (CSF) 2.0* (NIST CSWP 29, February 26, 2024). https://nvlpubs.nist.gov/nistpubs/CSWP/NIST.CSWP.29.pdf
- CSF Tools. *Cybersecurity Framework v2.0*. https://csf.tools/reference/nist-cybersecurity-framework/v2-0/
- Isora GRC. *NIST CSF 2.0: Complete Guide [2026]*. https://www.saltycloud.com/blog/nist-csf-2-0-complete-guide-2026/

### GDPR
- GDPR-info.eu. *Art. 32 GDPR — Security of processing*. https://gdpr-info.eu/art-32-gdpr/
- GDPR-text.com. *Article 32 — Security of processing*. https://gdpr-text.com/read/article-32/
- EDPB. *One-Stop Shop Case Digest: Security & Data Breach* (January 2024). https://www.edpb.europa.eu/system/files/2024-01/one_stop_shop_case_digest_security_data_breach_en.pdf
- ISMS.online. *How to Demonstrate Compliance With GDPR Article 32*. https://www.isms.online/general-data-protection-regulation-gdpr/gdpr-article-32-compliance/

### Existing Compliance Agents Surveyed
- VoltAgent/awesome-claude-code-subagents repository: `compliance-auditor.md` file returned 404 at time of authoring (the repo lists agents but the individual file was not accessible). The agent was authored from primary framework sources rather than adapting an existing example.

---

## Design Doc Notes

Patterns that emerged during authoring that would benefit future agents or the agent design process:

1. **Versioned standards deserve a version table at the top of sources.md.** Compliance frameworks change materially between versions (PCI DSS v3.2.1 → v4.0.1 changed 64 requirements; ISO 27001:2013 → 2022 restructured all 114 controls into 93). Future agents touching versioned standards should include a similar version pinning table in sources.md, and the agent file itself should cite version numbers inline (not just framework names).

2. **Pending/proposed regulatory changes benefit from explicit callouts.** The HIPAA NPRM (December 2024) materially changes the required/addressable distinction. Rather than silently omitting it or treating it as current law, the agent notes its proposed status and expected timeline. This pattern — "current rule X; proposed change Y, expected effective Z — design toward Y" — is useful for any agent touching regulations that have active rulemaking in progress.

3. **The gap table output format is more useful than prose for control gap assessment.** The Data Privacy and Security agents use prose findings. For compliance, which often needs to produce deliverables for auditors, a structured table (Control | Framework Ref | Current State | Gap | Priority) directly maps to what compliance teams actually produce. Task-specific output formats that match the deliverable format practitioners use are more useful than generic prose.

4. **Scope deferrals need two-directional clarity.** The Security agent's scope section says "defer to Compliance for regulatory framework mapping." This agent's scope section explicitly mirrors that by saying "defer to Security for technical implementation depth." Both directions of the handoff should be stated in both agents to avoid a user caught between agents not knowing where to go. Future agents should check that their named peer agents also have the reciprocal deferral.

5. **"State of the art" as a dynamic compliance benchmark is underappreciated.** GDPR Art. 25 and Art. 32 both reference "state of the art" as the benchmark for appropriate measures — a benchmark that shifts continuously with technology. An agent that only maps static controls misses this. Future compliance-adjacent agents should be aware that GDPR technical adequacy is not a one-time certification; it requires continuous re-evaluation against current practice.
