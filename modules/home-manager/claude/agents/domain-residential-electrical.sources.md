# Sources: domain-residential-electrical

## Step 1 — Existing Agents and Skills Consulted

### Community agents (VoltAgent/awesome-claude-code-subagents)
Searched the repository. No agents covering residential electrical work, home inspection, construction trades, or building codes were found. The repository is oriented toward software development, infrastructure, and business analytics. The search confirmed this is a novel domain for the agent roster.

### Local agents reviewed
No local agents cover residential electrical. The following were reviewed for format and voice reference:

- `~/.claude/agents/recreation-cycling-maintenance.md` — adopted as the primary format reference. This agent demonstrates the correct balance between comprehensive knowledge sections (with NEC-analog code-level specifics), heuristic decision rules, and bidirectional scope deferrals. Its persona frame ("You treat every bicycle problem as a symptom of an interface") informed the electrical agent's persona ("You treat every residential electrical question as a system-level problem"). Its output format structure (knowledge question / tradeoff / design / artifact review) was adopted without material changes.

No other local agents were close enough to the domain to warrant review.

---

## Step 2 — Bodies of Knowledge Surveyed

| Source | Type | Version / date | Jurisdiction or scope | Notes |
|---|---|---|---|---|
| NFPA 70 (NEC) | Model code | 2023 edition (current for most AHJs mid-2026); 2020 and 2026 also referenced | US national (model code; adoption varies by AHJ) | Primary regulatory source; three-year cycle; NFPA 70 is the authoritative NEC text |
| NFPA NEC Enforcement Maps | Regulatory map | 2025–2026 | US national | AHJ-level adoption status; confirms no NEC 2026 state adoptions as of April 2026 |
| IAEI NEC Adoption by State | Regulatory database | Updated July 18, 2025 | US national | Jade Learning / IAEI state-by-state edition tracking |
| NEC Article 220 (Load Calculations) | Code article | NEC 2023 | US national | Standard method (220.42), Optional method (220.82), EVSE (220.57) |
| NEC Article 230 (Services) | Code article | NEC 2023 | US national | Minimum service size (230.79) |
| NEC Article 250 (Grounding and Bonding) | Code article | NEC 2023 | US national | EGC (Table 250.122), GEC (Table 250.66), MBJ, bonding jumpers |
| NEC Article 334 (NM Cable) | Code article | NEC 2023 | US national | NM-B installation rules; stapling intervals; prohibited locations |
| NEC Article 210 (Branch Circuits) | Code article | NEC 2023 | US national | AFCI 210.12, GFCI 210.8, circuit sizing 210.19 |
| NEC Article 310 (Conductors) | Code article | NEC 2023 | US national | Table 310.16 ampacity; temperature correction; rooftop adder |
| NEC Article 625 (EV Charging) | Code article | NEC 2023 | US national | Dedicated circuit 625.40, GFCI 625.54, disconnect 625.43, continuous load, new 220.57 |
| NEC Article 690 (Solar PV) | Code article | NEC 2023 | US national | Conductor sizing 690.8, rapid shutdown 690.12, AFCI 690.11 |
| NEC Article 705 (Interconnected Power) | Code article | NEC 2023 | US national | Load-side connection 705.12 (120% busbar rule), supply-side 705.11 |
| NEC Article 702 (Optional Standby) | Code article | NEC 2023 | US national | Generator/transfer switch requirements; V2H island mode 625.49 |
| NEC Article 110.14(A) | Code section | NEC 2023 | US national | Terminal conductor quantity limit (double-tap prohibition basis) |
| NEC Article 314 (Boxes) | Code article | NEC 2023 | US national | Box fill calculations |
| CPSC Report on Aluminum Wiring | Federal agency report | 1974/revised | US national | 55× fire hazard statistic at outlet connections; COPALUM and AlumiConn approval |
| CPSC Aluminum Wiring Safety Information | Federal agency | Current | US national | Approved remediation methods; pigtailing guidance |
| IBEW/NECA electrical training ALLIANCE | Industry training program | Current (2025–2026) | US national | Apprenticeship structure, journeyman/master licensing path, wage scales |
| IAEI (International Association of Electrical Inspectors) | Professional association | Current | US/Canada | Inspector certification, code interpretation, AHJ authority |
| Jade Learning: NEC Code Adoptions by State | Industry reference | July 18, 2025 | US national | State-by-state edition table |
| SparkShift: NEC Code Guide 2026 | Industry reference | 2026 | US national | NEC 2026 publication date (October 10, 2025), no state adoptions as of April 2026 |
| ExpertCE: AFCI Requirements NEC 210.12 | Continuing education | NEC 2023 | US national | AFCI room-by-room requirements, 10A circuit inclusion |
| ExpertCE: GFCI vs AFCI NEC Requirements | Continuing education | NEC 2023 | US national | GFCI 210.8(A) location table, NEC 2023 kitchen expansion |
| ExpertCE: Dwelling Service Calculation (NEC 220.82) | Continuing education | NEC 2023 | US national | Optional method worked example |
| FastTrax: Grounding vs Bonding in NEC | Technical article | NEC 2026 crosswalk (also valid for 2023) | US national | EGC, GEC, MBJ definitions; Table 250.122 vs 250.66 |
| Nassau National Cable: NEC 220 Load Calculations | Technical article | NEC 2023 | US national | Standard vs. optional method; worked example; 230.79 minimum sizes |
| InterNACHI: Common Conductor Types | Inspector reference | Current | US national | K&T, aluminum, NM-B characteristics; insurance implications |
| Healthy Building Science: NM vs BX | Technical article | Current | US national | Conduit and cable comparison; EMF considerations |
| Tier1 Pro Inspections: Double-Tapped Breakers | Home inspection reference | Current | US national | Defect prevalence; NEC 110.14(A) basis; fix options |
| NACHI: Double-Tapped Neutral Wires | Inspector reference | Current | US national | Double-lugged neutral hazards; prohibited since NEC 2002 |
| NYSERDA: NEC Article 625 EVSE Overview | State agency training | NEC 2020 (with 2023 notes) | New York / US national | Comprehensive 625 summary; continuous load rule; GFCI |
| National EV Charger Authority: NEC 625 Overview | Technical reference | NEC 2023 | US national | 625.40 dedicated circuit changes 2020→2023; sizing examples |
| Eaton: NEC 2023 Home Electrification | Manufacturer technical | NEC 2023 | US national | 220.57 EVSE load calc; GFCI 250V expansion |
| ExpertCE: NEC Article 690 Solar Guide | Continuing education | NEC 2023 | US national | 690.8 156% rule; rapid shutdown; AFCI 690.11 |
| Mayfield Renewables: NEC 705.12 | Technical article | NEC 2020/2023 | US national | 120% busbar rule mechanics; backfeed breaker label |
| Mayfield Renewables: NEC 690.8(B) Wire Sizing | Technical article | NEC 2023 | US national | Two-path sizing calculation; temperature correction |
| Permitflow: Electrical Permits 101 | Industry reference | Current | US national | General permit process; state variation overview |
| Washington State L&I: Electrical Permit Basics | State agency | Current | Washington State | Homeowner exemption conditions |
| Angi: Aluminum vs Copper Wiring | Consumer reference | Current | US national | Cost data; expansion coefficient data |
| Black Rhino Electric: Aluminum Wiring Replacement Cost | Trade reference | 2026 | US national | Rewire cost ranges; AlumiConn cost comparison |
| TCA Electric: Pigtailing vs. Full Rewire | Trade reference | Current | US/Canada | 10:1 cost ratio data point; CPSC connector types |

---

## Step 3 — Citations Referenced in Agent Body

All NEC article and section references (210.8, 210.12, 210.19, 220.42, 220.57, 220.82, 230.67, 230.79, 240.4, 250.4, 250.50, 250.53, 250.66, 250.102, 250.122, 250.142, 310.16, 314, 334, 406.4, 625, 690, 702, 705) are from NFPA 70 (NEC) 2023 edition.

Specific resolved citations:
- **NEC 110.14(A)** — terminal conductor limit: NFPA 70-2023, §110.14(A)
- **NEC 220.82** — Optional method: NFPA 70-2023, §220.82; worked example: https://expertce.com/learn-articles/dwelling-service-calculation-optional-method-nec-220-82/
- **NEC 230.79** — Minimum service rating: NFPA 70-2023, §230.79
- **NEC 250 grounding/bonding taxonomy** — https://fasttraxsystem.com/grounding-vs-bonding/; https://expertce.com/learn-articles/grounding-vs-bonding-nec-250/
- **NEC 705.12 120% busbar rule** — https://www.mayfield.energy/technical-articles/code-corner-2020-nec-705-12b31-and-2/
- **NEC 690.8 156% rule** — https://www.mayfield.energy/technical-articles/how-to-calculate-wire-size-amp-nec-690-8-b/
- **CPSC 55× aluminum wiring statistic** — CPSC Publication #516 (Aluminum Wiring in Homes); referenced at: https://www.angi.com/articles/aluminum-vs-copper-wiring.htm
- **AlumiConn cost ratio (10:1)** — https://tcaelectric.ca/aluminum-wiring-replacement-cost-pigtailing/
- **FPE Stab-Lok** — CPSC 1983 study; widely cited in home inspection literature
- **Zinsco** — Multiple home inspector sources; aluminum bus bar fusing-to-breaker failure mode documented in IAEI publications
- **NEC 2023 adoption map** — https://www.jadelearning.com/nec-code-adoptions-by-state/ (updated July 18, 2025)
- **NEC 2026 publication date and no-state-adoption status** — https://northwestelectricpros.com/nec-2026-code-adoption-by-state/ (April 2026)
- **IBEW/NECA apprenticeship structure** — https://electricaltrainingalliance.org/training/apprenticeshipTraining; https://intercoast.edu/articles/electrician-apprenticeship-ibew/

---

## Step 4 — Jurisdictional and Temporal Caveats

**NEC edition pinning**: the agent's knowledge base is calibrated to NEC 2023 as the current majority-state edition as of mid-2026. Specific sections that changed materially between NEC 2020 and NEC 2023 (all kitchen receptacles GFCI, GFCI for ranges/dryers 210.8(D), EVSE 625.40 dedicated circuit revision, 220.57 EVSE load calc method) are noted in the agent body. A re-survey against NEC 2026 provisions should occur within 12–18 months as state adoptions begin.

**State adoption lag**: as of mid-2026, NJ enforces NEC 2017; PA and WI enforce NEC 2017 as well per some sources (PA moved to 2020 per others — verify at time of use); FL, MD, VA, AL, AK, CT, DE, MT, NV, NH, NM, TN, UT, VT, WV enforce NEC 2020. The agent instructs users to verify with their AHJ; this caveat should be reinforced in any jurisdiction-sensitive conversation.

**Homeowner permit exemptions**: the agent correctly characterizes that most states allow homeowner permits for primary residences but that specific restrictions vary. Texas, Massachusetts, New York City, and California were cited with specific nuances. This area changes frequently as states revise licensing statutes; the agent should instruct users to verify current local requirements rather than relying on the agent's description for a specific state.

**Aluminum wiring remediation**: CPSC's current approved methods are COPALUM crimp connectors and AlumiConn connectors. The agent correctly notes that a full rewire is the most comprehensive remedy and pigtailing is a legitimate lower-cost alternative — this represents the current CPSC position as of 2025–2026.

---

## Step 5 — Design Notes

### Pattern: Vocabulary section as agent backbone
In a highly codified technical domain (electrical vs. cycling vs. auction design), naming every term precisely in the Knowledge section is load-bearing work, not boilerplate. The distinction between EGC, GEC, and MBJ is the difference between a safe and an unsafe subpanel installation. Unlike softer domains where vocabulary lists feel pedantic, in NEC-governed work, misused vocabulary propagates dangerous advice. Future domain agents in similar codified fields (plumbing, structural, HVAC) should invest the same depth in vocabulary definition.

### Pattern: "Ask jurisdiction before NEC section" as the first heuristic
This agent surfaced a meta-heuristic not present in prior agents: before citing code, confirm which code edition is in force. For software agents this is analogous to "confirm the framework version before citing API." In any domain with a published model code adopted asynchronously by jurisdictions (building codes, fire codes, energy codes), jurisdiction-first should be the default opening move.

### Pattern: Hazard-severity differentiation
The agent distinguishes between panel brands/conditions that are "grandfathered but not safe" (FPE, Zinsco) vs. "old but probably serviceable" (K&T if undisturbed, no insulation contact). This two-tier hazard model — present risk vs. latent risk — is useful in any domain where legacy installations exist. In vehicle provenance terms, this is analogous to "salvage-rebuilt" vs. "prior damage disclosed." Future domain agents dealing with legacy infrastructure (plumbing, structural) should adopt explicit hazard-tier vocabulary.

### Pattern: Permit consequence framing before DIY-vs-licensed
The agent consistently frames permit questions through consequences (insurance denial, sale complications) before getting into legality. This proved more useful than a binary "legal/illegal" framing because the consequences — not the rule — are what drive homeowner behavior. Future domain agents where regulatory compliance has asymmetric consequences (tax, insurance, liability) should lead with the consequence calculus.

### Scope boundary: "electrical scope of a PV/EV/generator project" vs. "PV/EV/generator design"
This boundary proved nuanced and worth noting. A residential electrical expert should handle the panel-side scope of solar (backfeed breaker, 120% rule, permit documentation), EV (circuit sizing, load calc, GFCI), and generators (transfer switch selection, ATS wiring, Article 702 compliance) — but not the DC system design, inverter selection, battery sizing, or utility interconnection agreement. This "electrical scope only" boundary is common wherever a specialty trade intersects with residential wiring and should be modeled explicitly in future agents covering plumbing or HVAC intersections with the electrical system.
