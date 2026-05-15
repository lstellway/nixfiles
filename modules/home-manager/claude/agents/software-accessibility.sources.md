# Software Accessibility Agent — Sources

## Version / Date Pinning Table

| Standard | Version / Edition | Status | Published | Notes |
|---|---|---|---|---|
| WCAG 2.2 | W3C Recommendation | Current normative standard | 5 October 2023 | Supersedes WCAG 2.1; backwards-compatible except SC 4.1.1 Parsing (removed). Default regime for most products. |
| WCAG 2.1 | W3C Recommendation | Superseded by 2.2 | 5 June 2018 | Still normative reference for EN 301 549 V3.2.1 and many existing legal agreements. |
| WCAG 2.0 | W3C Recommendation | Superseded | 11 December 2008 | Formal baseline for Revised Section 508 Standards (2017). |
| WCAG 3.0 | W3C Working Draft | Draft — not for compliance | March 2026 (most recent WD) | Introduces scoring model and APCA contrast. Candidate Recommendation not expected before late 2027; final Recommendation ~2029. |
| WAI-ARIA 1.2 | W3C Recommendation | Current stable spec | 6 June 2023 | Defines roles, states, and properties. Use for implementation. |
| WAI-ARIA 1.3 | Editor's Draft | Draft | February 2026 (editor's draft) | Not yet Candidate Recommendation; do not use for compliance. |
| ARIA Authoring Practices Guide (APG) | Living document | Actively maintained | Continuously updated; W3C copyright 2026 | Provides design patterns for widgets. Not a normative standard — demonstrates ARIA capabilities, not mandatory patterns. |
| Accessible Name and Description Computation (accname-1.2) | W3C Recommendation | Current | 2023 | Normative algorithm for accessible name computation. |
| ARIA in HTML | W3C Editor's Draft | Active development | 2026 | Defines allowed ARIA roles per HTML element. |
| Section 508 (Revised) | US Access Board Rule | US Federal regulation | January 2017 | Formally incorporates WCAG 2.0 Level AA. Applies to federal agencies, contractors, federally funded orgs. |
| EN 301 549 V3.2.1 | Harmonized European Standard (ETSI) | Current published EN | March 2021 | Incorporates WCAG 2.1 in full. Relevant to EU public procurement and European Accessibility Act. |
| EN 301 549 V4.1.0 | Draft (for review) | Draft | November 2025 | Will incorporate WCAG 2.2; expected to be referenced in EU Official Journal as V4.1.1 in October 2026. |

---

## Sources Used

### W3C Normative Specifications

- **WCAG 2.2** — https://www.w3.org/TR/WCAG22/ — Primary normative source for all SC numbers, levels, and definitions.
- **WAI-ARIA 1.2** — https://www.w3.org/TR/wai-aria-1.2/ — Role definitions, states, properties.
- **accname-1.2** — https://www.w3.org/TR/accname-1.2/ — Accessible name computation algorithm (priority chain in the Accessible Name Computation section).
- **ARIA in HTML** — https://w3c.github.io/html-aria/ — Allowed ARIA roles per HTML element.
- **ARIA Authoring Practices Guide** — https://www.w3.org/WAI/ARIA/apg/ — Widget keyboard interaction patterns and design pattern examples.

### Framework Status References

- **WCAG 2.2 "What's New"** — https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/ — Documents the 9 new SCs in 2.2 vs 2.1 and the removal of SC 4.1.1 Parsing.
- **WCAG 3.0 March 2026 Working Draft** — https://www.w3.org/WAI/news/2026-03-03/wcag3/ — Confirmed draft status, 174 requirements/outcomes, six-month revision cycle.
- **WCAG 3 Introduction** — https://www.w3.org/WAI/standards-guidelines/wcag/wcag3-intro/ — Timeline context (Candidate Recommendation not before late 2027; final ~2029).
- **WAI-ARIA 1.2 Recommendation Announcement** — https://www.w3.org/WAI/news/2023-06-06/aria-12-rec/ — Confirmed publication date 6 June 2023.
- **Section 508 / US Access Board** — https://www.access-board.gov/ict/ — Confirms WCAG 2.0 AA as formal baseline for the Revised 508 Standards.
- **EN 301 549 V3.2.1 PDF** — https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf — Current published standard.
- **EU Digital Strategy — EN 301 549 changes** — https://digital-strategy.ec.europa.eu/en/policies/latest-changes-accessibility-standard — V4.1.0 draft November 2025; V4.1.1 expected in Official Journal October 2026.
- **AbilityNet — WCAG 3.0 2026 overview** — https://abilitynet.org.uk/resources/digital-accessibility/what-expect-wcag-30-web-content-accessibility-guidelines — Timeline confirmation.
- **Vervali — WCAG 3.0 compliance 2026** — https://www.vervali.com/blog/wcag-3-0-accessibility-testing-compliance-2026-standards-timeline-tools-and-how-to-prepare-your-stack/ — Additional WCAG 3.0 timeline and APCA context.
- **APG Task Force minutes, February 2026** — https://www.w3.org/2026/02/04-aria-apg-minutes.html — Confirmed APG is actively maintained with two-week update cycles.

### VoltAgent Awesome Subagents

- Repository URL: https://github.com/VoltAgent/awesome-claude-code-subagents
- Reviewed file: `categories/04-quality-security/accessibility-tester.md` — an A11y compliance expert agent.

---

## What Was Reviewed from the Awesome Subagents Repository and Not Used

The repository contains one accessibility-relevant agent: `accessibility-tester.md`. It was reviewed in full. The following elements were **not adopted**, with rationale:

| Element from accessibility-tester.md | Decision | Rationale |
|---|---|---|
| References WCAG 2.1 as the compliance target | Not adopted | WCAG 2.2 is the current W3C Recommendation (October 2023); the agent targets the current standard. |
| "Zero critical violations" as a stated outcome goal | Not adopted | Outcome framing is aspirational rather than operational. The agent instead focuses on executable checks and finding classification. |
| References "WCAG 3.0" as a compliance target alongside 2.1 | Not adopted | WCAG 3.0 is a Working Draft not suitable for compliance; the agent notes its status explicitly and limits its mention to forward-looking design decisions. |
| Lists specific AT tools (NVDA, JAWS, VoiceOver, Narrator, TalkBack) by name | Partially adopted | Screen reader compatibility section names the key AT/browser combinations for testing context, but testing tool recommendations are kept brief to avoid directing the agent toward tool execution rather than code analysis. |
| Documentation output artifacts (accessibility statements, testing procedures) | Not adopted | Out of scope for a code/component analysis agent; documentation authoring belongs to a documentation or compliance agent. |
| Broad "four phases of testing" framework structure | Not adopted | Replaced by specific, per-topic heuristic checklists anchored to SC numbers — more executable from component code than a procedural framework. |
| No scope boundaries or deferrals | Not adopted | The agent adds explicit bidirectional scope boundaries (defer to UX, Compliance, Performance) per the design principles. |

---

## What Was Not Used from the Research and Why

| Topic | Decision | Rationale |
|---|---|---|
| APCA contrast algorithm (WCAG 3.0) | Mentioned only as a forward-looking note | APCA is part of the WCAG 3.0 Working Draft and cannot be used for current compliance. Including it as a check would create confusion with WCAG 2.x 1.4.3/1.4.11 requirements. |
| WAI-ARIA 1.3 editor's draft | Not incorporated | Editor's draft as of February 2026; no Candidate Recommendation. Any roles or properties added in 1.3 are not stable and should not be used for implementation. |
| EN 301 549 V4.1.0 draft (November 2025) | Mentioned in version table only | Draft status; not referenced in the Official Journal. The current enforceable EN is V3.2.1. |
| Section 508 beyond WCAG 2.0 reference | Minimal treatment | Section 508 formally requires WCAG 2.0 AA; agencies are encouraged to exceed this. The agent notes the formal baseline but directs deeper Section 508 legal posture questions to the Compliance agent. |
| Specific automated testing tool recommendations (axe, Lighthouse, etc.) | Not included | The agent's scope is code and markup analysis, not tool execution. Tool selection belongs to the Testing agent. Mentioning specific tools could anchor the agent to tool outputs rather than direct SC analysis. |
| Cognitive accessibility / WCAG 2.1 SC 1.3.4, 1.3.5, 1.3.6 in full depth | Partially included | SC 1.3.5 (Identify Input Purpose) is included in the forms section. Full cognitive accessibility guidance (COGA) extends to SC 3.2.x, 3.3.x, and supplemental guidance — enough is included to be actionable; deep COGA guidance would benefit from a dedicated section if the scope is expanded. |
| Mobile-specific native app accessibility (iOS UIAccessibility, Android AccessibilityService) | Not included | The agent targets web/component code (HTML, JSX, CSS). Native mobile platform APIs are outside scope; a mobile-specific agent would be a better home. |

---

## Design Doc Notes

### Core design decisions

**Regulatory regime detection as Step 1.** The most common error in accessibility advice is applying the wrong standard. WCAG 2.0, 2.1, and 2.2 differ materially (9 new SCs in 2.1, 9 more in 2.2, one removed). Section 508 and EN 301 549 reference different WCAG versions. The agent must establish which standard applies before assessing anything.

**Specificity: SC numbers over principles.** The POUR principles (Perceivable, Operable, Understandable, Robust) are useful for categorization but too coarse for executable checks. The agent embeds SC numbers at the point of each check so findings are immediately traceable to a conformance requirement.

**Persona as decision frame, not expertise claim.** The opening frame ("cannot use a mouse, cannot see the screen, cannot process complex visual layouts") grounds the agent's evaluation stance in the user's reality. This produces more targeted findings than "I am an accessibility expert" framing, which tends toward comprehensive checklists rather than judgment calls.

**Bidirectional scope deferrals.** Each deferral is stated as "stay here for X; defer there for Y" — not just "defer to Compliance." This prevents the agent from either over-deferring (refusing to assess technical gaps because "that's a legal question") or under-deferring (offering legal risk assessments that belong to Compliance).

**Surface-then-defer for legal dimension.** A WCAG 2.1.1 Keyboard failure on a public purchase flow is both a technical finding and a potential ADA exposure. The agent flags the SC failure and the regime implication, then directs to Compliance — it does not absorb legal risk assessment or refuse to flag the technical failure.

**WCAG 3.0 treatment.** WCAG 3.0 appears in the standard table and gets a one-sentence caution on APCA. Over-featuring it creates false urgency (the Recommendation is ~2029); under-featuring it leaves the agent unaware of a significant incoming change.

**APG as patterns, not requirements.** The APG is cited as the source for keyboard interaction patterns (modal focus trap, menu arrow key navigation, etc.) but is explicitly noted as non-normative. The relevant WCAG SCs (2.1.1, 2.4.3) are the actual requirements; the APG provides the operationalization.

**Accessible name computation as a first-class section.** Name computation failures (icon-only buttons with no `aria-label`, inputs with no label association) account for a large share of WCAG 4.1.2 failures in the wild. Making accname-1.2's priority chain explicit gives the agent a diagnostic tool rather than an open-ended "check for accessible names."

**No automated tool recommendations.** The agent is designed to reason from code and markup. Recommending axe or Lighthouse would anchor its output to what automated tools can catch (~30–35% of WCAG failures) and create the impression that a passing tool result means conformance.

### What would trigger expanding this agent

- A dedicated mobile native accessibility section (iOS UIAccessibility, Android AccessibilityService) if the product scope includes native apps.
- A full COGA (Cognitive Accessibility) section covering SC 3.1.x, 3.2.x, 3.3.x and the supplemental WCAG 2.x Cognitive Accessibility Guidance when WCAG 3.0 nears Candidate Recommendation.
- APCA contrast guidance once WCAG 3.0 reaches Candidate Recommendation and organizations need to plan transitions.
- EN 301 549 V4.1.1 specifics once it is referenced in the Official Journal (expected October 2026).
