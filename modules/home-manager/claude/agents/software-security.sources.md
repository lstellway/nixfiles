# Sources: software-security.md

## Agents & Skills Consulted

**VoltAgent/awesome-claude-code-subagents** (https://github.com/VoltAgent/awesome-claude-code-subagents)
- Reviewed agent index for security-related subagents: `security-auditor`, `security-engineer`, `penetration-tester`, `ad-security-reviewer`, `powershell-security-hardening`, `compliance-auditor`
- Noted design pattern: security agents use read-only tool permissions (Read, Grep, Glob) following least-privilege principle; compartmentalization prevents cross-task contamination
- The existing agents skew toward infrastructure and AD; no application-layer software security agent was present — confirmed the gap this agent fills

**Existing peer agents in this project**
- `software-architecture.md` — consulted for output format conventions, defer/scope language, and evidence-anchoring style
- `software-api-design.md` — reviewed to align scope boundary language for what defers to API Design vs. stays in Security

---

## Frameworks Surveyed

### OWASP Top 10 (2025)
https://owasp.org/Top10/2025/
Categories A01–A10 informed the sub-topic selection and severity framing:
- A01 Broken Access Control → Authorization & Access Control section
- A02 Security Misconfiguration → Security Headers & Transport, Error Handling sections
- A03 Software Supply Chain Failures → Dependency & Supply Chain section
- A04 Cryptographic Failures → Cryptography section
- A05 Injection → Input Validation & Injection section
- A06 Insecure Design → Threat Modeling section
- A07 Authentication Failures → Authentication & Session Management section
- A08 Software or Data Integrity Failures → Dependency (SRI), Deserialization checks
- A09 Security Logging and Alerting Failures → Security Logging & Audit Trails section
- A10 Mishandling of Exceptional Conditions → Error Handling & Information Disclosure section
Note: SSRF (A10 in 2021) dropped from the 2025 list but remains in the agent as an active check given its continued prevalence.

### OWASP Application Security Verification Standard (ASVS) v5
https://owasp.org/www-project-application-security-verification-standard/
- Level structure (L1 opportunistic, L2 standard, L3 high-value) informed severity tagging convention in output format
- Specific requirement v5.0.0-1.2.5 (parameterized OS queries) cited as grounding for command injection check
- Authentication, session management, and access control verification categories mapped to corresponding agent sections

### SANS/MITRE CWE Top 25 Most Dangerous Software Errors (2023)
https://www.sans.org/top25-software-errors/
CWE IDs referenced directly in agent checks:
- CWE-79 (XSS) → Input Validation, XSS check
- CWE-89 (SQL Injection) → Input Validation, SQL injection check
- CWE-78 (OS Command Injection) → Input Validation, command injection check
- CWE-22 (Path Traversal) → Input Validation, path traversal check (cited by CWE ID)
- CWE-352 (CSRF) → CSRF & Request Integrity section
- CWE-434 (Unrestricted File Upload) → Input Validation, file upload check
- CWE-287 (Improper Authentication) → Authentication section
- CWE-502 (Deserialization of Untrusted Data) → Input Validation, deserialization check (cited by CWE ID)
- CWE-798 (Hard-coded Credentials) → Secrets & Credential Management section
- CWE-918 (SSRF) → Input Validation, SSRF check
- CWE-269 (Improper Privilege Management) → Authorization section
- CWE-862 / CWE-863 (Missing/Incorrect Authorization) → Authorization section

### STRIDE Threat Modeling
Source: OWASP Threat Modeling Cheat Sheet (https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html)
- Four foundational questions (What are we working on? / What can go wrong? / What are we going to do about it? / Did we do a good enough job?) used to frame the Threat Modeling section
- STRIDE category-to-security-property mapping (Spoofing→Authentication, Tampering→Integrity, etc.) directly incorporated into the per-category checks
- Trust boundary enumeration heuristic drawn from the data flow diagram validation guidance

### SAFECode Fundamental Practices for Secure Software Development (2018)
https://safecode.org/wp-content/uploads/2018/03/SAFECode_Fundamental_Practices_for_Secure_Software_Development_March_2018.pdf
- PDF was not parseable in fetched form; SAFECode principles were incorporated indirectly via OWASP cheat sheets that cross-reference SAFECode's threat modeling and design-phase security guidance

---

## OWASP Cheat Sheets Referenced

Each cheat sheet informed specific heuristic bullets in the agent:

| Cheat Sheet | URL | Sections Informed |
|---|---|---|
| Authentication Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html | Authentication & Session Management |
| Authorization Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html | Authorization & Access Control |
| Session Management Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html | Authentication & Session Management |
| Injection Prevention Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Injection_Prevention_Cheat_Sheet.html | Input Validation & Injection |
| Input Validation Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html | Input Validation & Injection |
| Cryptographic Storage Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Cryptographic_Storage_Cheat_Sheet.html | Cryptography |
| Transport Layer Security Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Security_Cheat_Sheet.html | Security Headers & Transport |
| HTTP Headers Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/HTTP_Headers_Cheat_Sheet.html | Security Headers & Transport |
| CSRF Prevention Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html | CSRF & Request Integrity |
| Secrets Management Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html | Secrets & Credential Management |
| Error Handling Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Error_Handling_Cheat_Sheet.html | Error Handling & Information Disclosure |
| Logging Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html | Security Logging & Audit Trails |
| Vulnerable Dependency Management Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Vulnerable_Dependency_Management_Cheat_Sheet.html | Dependency & Supply Chain Security |
| Third-Party JavaScript Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Third_Party_Javascript_Management_Cheat_Sheet.html | Dependency & Supply Chain Security (SRI) |
| Threat Modeling Cheat Sheet | https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html | Threat Modeling (STRIDE) |

---

## Design Principles Applied

The agent structure follows the design doc conventions established in this project:

- **Persona as decision-making frame**: "You reason about security as an attacker would" shapes model prioritization rather than claiming expertise
- **Non-blocking context**: "state your assumptions and proceed" instruction present in the Context section
- **Evidence anchoring**: "Every response must cite specific files, functions, call sites, or configuration keys" — carried forward verbatim from `software-architecture.md` convention
- **Specificity test applied**: each heuristic bullet is phrased as an observable check runnable against code, config, or diff (e.g., "Flag `SameSite=None`", "Flag string equality on secrets") rather than a concept label (e.g., "Check session security")
- **Explicit scope boundaries**: Data Privacy and Compliance are explicitly deferred with named peer agents and specific scope descriptions
- **Task-adaptive output**: four named modes (PR review, threat model review, design assistance, security audit), each with concrete inputs, outputs, and structure — mirroring the architecture agent's output format section
