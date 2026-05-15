# Software User Experience Agent — Sources

References that informed the heuristics in `software-user-experience.md`.

---

## Version / Date Pinning Table

| Reference | Version / Edition | Last Updated / Verified |
|---|---|---|
| Nielsen's 10 Usability Heuristics | Original 1994; last substantively updated 2020 (language refinement only); heuristics unchanged since 1994 | Article updated January 30, 2024 (nngroup.com) |
| deceptive.design dark patterns taxonomy | 16-type taxonomy; no explicit version number on site | Fetched May 2026; no date stamp on /types page |
| Laws of UX (Jon Yablonski) | No versioned release; copyright 2026 on site | Fetched May 2026 |
| NNg — Error Message Guidelines | No formal version | Published May 14, 2023 (nngroup.com) |
| NNg — Web Form Design | No formal version | Published May 1, 2016 (nngroup.com) |
| NNg — UX Writing Study Guide | No formal version | Published May 8, 2024 (nngroup.com) |
| NNg — Skeleton Screens | No formal version | Published June 4, 2023 (nngroup.com) |
| NNg — Information Architecture & Sitemaps | No formal version | Published September 3, 2023 (nngroup.com) |
| NNg — Progressive Disclosure | No formal version | Published December 3, 2006 (nngroup.com) |
| Sweller's Cognitive Load Theory | Original 1988; formalized in three-type model (intrinsic/extraneous/germane) 1998 | Applied via NNg and Laws of UX articles |
| Gestalt Principles (Wertheimer et al.) | Classical formulation; not versioned | Applied via foundational references |

---

## Existing Agents & Skills Reviewed

The following agents from [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) were reviewed for UX-related examples:

- **ui-designer** ("Visual design and interaction specialist") — reviewed; focused on visual design production rather than usability evaluation. Not adopted: no heuristic evaluation structure, no dark pattern detection, output format not suited for PR review.
- **ui-ux-tester** ("Exhaustive documented-flow UI tester") — reviewed; focused on test execution and flow documentation, not advisory heuristic evaluation. Not adopted: testing framing is different from advisory/design-assistance framing needed here.
- **ux-researcher** ("User research expert") — reviewed; focused on research methods (interviews, surveys, usability studies). Not adopted: research planning is out of scope for a code-review-oriented agent; this agent focuses on evaluating existing UI artifacts.
- **design-bridge** ("Design-to-agent translator") — reviewed; focused on translating design files to agent instructions. Not adopted: this agent evaluates code and copy, not design-file translation.
- **frontend-developer** ("UI/UX specialist for React, Vue, and Angular") — reviewed; combined frontend implementation with UX concerns. Not adopted: implementation concerns are separate from usability advisory; conflating them dilutes both.
- **accessibility-tester** — reviewed; relevant overlap with UX but deliberately scoped to A11y (WCAG, ARIA, keyboard navigation). Used to identify the UX/Accessibility boundary: stay here = interaction intuitiveness for sighted users; defer there = WCAG conformance.

No existing agent from the repository matched the target pattern: structured Nielsen heuristic evaluation + dark pattern taxonomy + UX writing + bidirectional scope deferrals + task-mode-differentiated output format.

---

## Frameworks & Standards

### Nielsen's 10 Usability Heuristics
- [NNg — 10 Usability Heuristics for User Interface Design](https://www.nngroup.com/articles/ten-usability-heuristics/) — primary source. All 10 heuristics cited by number and exact name as they appear on the page. Article updated January 30, 2024. The 10 heuristics themselves are unchanged since 1994; the 2020 update refined explanatory language only.

### Dark Patterns — deceptive.design Taxonomy
- [deceptive.design/types](https://www.deceptive.design/types) — 16 dark pattern types; all cited by exact catalog name. No version number or date stamp present on the page. Catalog was founded by Harry Brignull. All 16 types incorporated into the agent's dark patterns section.

### Laws of UX (Jon Yablonski)
- [lawsofux.com](https://www.lawsofux.com/) — 30 laws and principles; used selectively. Incorporated: Hick's Law (choice overload), Fitts's Law (target acquisition), Jakob's Law (convention adherence), Miller's Law (7±2 working memory), Doherty Threshold (400ms perceived performance), Tesler's Law (irreducible complexity), Goal-Gradient Effect (onboarding progress), Zeigarnik Effect (incomplete task recall), Serial Position Effect (first/last recall), Paradox of the Active User (skip-instructions behavior). Not incorporated individually: Aesthetic-Usability Effect (acknowledged implicitly in Visual Hierarchy section), Pareto Principle (too general for executable UX check), Parkinson's Law (not directly applicable to UI evaluation), Peak-End Rule (valuable for journey mapping, out of scope for PR/component review), Postel's Law (more relevant to API Design agent), Occam's Razor (subsumed by Aesthetic and Minimalist Design heuristic #8).

### Sweller's Cognitive Load Theory
- Referenced via NNg articles and Laws of UX cognitive load entries. Three types of load (intrinsic, extraneous, germane) attributed to Sweller (1988, 1998). Extraneous load reduction is the operative frame for UX evaluation — designs that add complexity without adding meaning impose extraneous load.

### Gestalt Principles
- Classical formulation (Wertheimer, Köhler, Koffka, 1910s–1920s). The five principles used in the agent (Proximity, Similarity, Continuity, Closure, Figure/Ground) are the most executable in the context of UI code and layout review. Not incorporated: Law of Common Region (covered under Proximity), Law of Uniform Connectedness (covered under Similarity), Law of Prägnanz (covered under Aesthetic and Minimalist Design heuristic #8).

### NNg — Error Message Guidelines
- [NNg — Error-Message Guidelines](https://www.nngroup.com/articles/error-message-guidelines/) — four categories: visibility, communication, efficiency, dire situations. Published May 14, 2023. All four categories incorporated into the Error Messages section of the agent.

### NNg — Web Form Design
- [NNg — Website Forms Usability: Top 10 Recommendations](https://www.nngroup.com/articles/web-form-design/) — 10 recommendations incorporated. Published May 1, 2016. Key findings used: single-column layout, no placeholder-as-label, mark optional not required, preserve input on error, avoid Reset buttons.

### NNg — UX Writing
- [NNg — UX Writing Study Guide](https://www.nngroup.com/articles/ux-writing-study-guide/) — published May 8, 2024. Key principles used: first-word scanning, inverted pyramid, plain language, brevity, scanning behavior, display numbers as numerals.

### NNg — Skeleton Screens
- [NNg — Skeleton Screens](https://www.nngroup.com/articles/skeleton-screens/) — published June 4, 2023. Usage criteria (2–10 second page loads), three types (static, animated, frame-display), frame-display anti-pattern, spinner vs. skeleton decision guidance all incorporated.

### NNg — Information Architecture
- [NNg — IA and Sitemaps](https://www.nngroup.com/articles/information-architecture-sitemaps/) — published September 3, 2023. Key principles used: findability, consistent nomenclature, taxonomy, research-informed structure. Card sorting and tree testing named as validation methods.

### NNg — Progressive Disclosure
- [NNg — Progressive Disclosure](https://www.nngroup.com/articles/progressive-disclosure/) — published December 3, 2006. Applied in: Aesthetic and Minimalist Design heuristic, onboarding flows, and Hick's Law/choice overload guidance.

---

## Not Used and Why

- **Don Norman — The Design of Everyday Things (Revised 2013)** — affordances, signifiers, feedback, constraints, mappings, mental models. Not incorporated as a separate section because the concepts are well-covered through Nielsen heuristics (#2 real-world match, #3 user control, #6 recognition vs. recall) and Gestalt principles. Adding Norman's vocabulary in parallel would create redundant terminology without executable differentiation.

- **WCAG 2.2 / 3.0** — color contrast, ARIA, keyboard navigation, focus management. Deliberately out of scope; deferred to the Accessibility agent. The scope boundary is defined in the agent: intuitive for sighted users stays here; disability access defers there.

- **Baymard Institute form usability research** — extensive empirical form usability data. Not incorporated directly due to access constraints; NNg form guidelines used instead and cover the same executable checks.

- **JTBD (Jobs to Be Done) framework** — useful for product strategy but not directly executable as a UI review heuristic. Out of scope for this advisory agent, which evaluates existing UI artifacts rather than product strategy.

- **Core Web Vitals (LCP, CLS, FID/INP)** — performance metrics. Deferred to Performance agent. Stay/defer boundary is stated explicitly in scope section: perceived performance UX impact (skeleton screens, optimistic updates) stays here; measurement and optimization defers there.

- **UX maturity models (NNg UX Maturity)** — organizational capability assessment. Out of scope; this agent evaluates product UX artifacts, not organizational process.

---

## Design Doc Notes

The following patterns emerged during authoring that may be useful for future agent files:

**Catalog-name anchoring is load-bearing for dark patterns.** Using the exact catalog names (Confirmshaming, Obstruction, Preselection, Trick Wording) allows findings to be unambiguous and cross-referenced to external documentation. Paraphrasing catalog names ("misleading defaults") loses the traceability. Any agent working from an enumerated taxonomy should embed the exact names.

**Surface-then-defer is a distinct pattern from simple deferral.** Some findings span two agents: a dark pattern may also be a compliance issue; a UX flow may also have security implications. The right behavior is not to defer immediately but to surface the UX finding, name it, and then explicitly route the regulatory or security dimension. This produces more useful output than either ignoring the adjacent domain or fully deferring the finding.

**Bidirectional scope statements prevent blind spots.** Stating only "defer Accessibility to the Accessibility agent" leaves ambiguity about what stays here. Stating both sides ("stay here: whether an interaction is intuitive for sighted users; defer there: whether it works for users with disabilities") removes the gap. Every scope boundary should be stated from both sides.

**Heuristic evaluation needs a pass-or-note structure.** A heuristic evaluation that silently skips inapplicable heuristics looks the same as one that missed them. The output format requires explicitly noting "No issues found" per heuristic to distinguish coverage from omission.

**Task modes require differentiated output formats.** PR review (short, anchored to the diff), heuristic evaluation (structured by heuristic, comprehensive), design assistance (options + tradeoffs), copy review (inventory + proposed revisions) each have different primary questions and useful output shapes. Collapsing them into one format produces outputs simultaneously too detailed for quick PR review and too shallow for design work.

**The decision-making frame is more useful than expertise framing.** "You evaluate interfaces from the perspective of a user who does not read documentation, does not remember your mental model, and will not ask for help — they will simply leave or make an error" encodes the evaluation criterion directly. It tells the model what question to hold throughout every finding, not just what domain it is expert in. This pattern (persona as evaluation criterion) should be applied in future agent authoring.
