# Sources — recreation-cycling-maintenance

Provenance and references behind `recreation-cycling-maintenance.md`. Bicycle maintenance is a stable mechanical-craft domain with several well-established authoritative sources; the agent embeds knowledge directly rather than deferring to lookup.

---

## Existing agents and skills consulted

| Source | Reviewed | Adopted | Notes |
|---|---|---|---|
| `~/.claude/agents/software-*` (all 17) | Yes | Voice/style only | Software-domain agents; no content overlap. Used as a model for the consultation-mode structure, scope-boundary phrasing, and persona-as-stance convention. |
| `~/.claude/agents/technology-*` (all 18) | Yes | None | Technology-domain agents; no overlap. |
| VoltAgent/awesome-claude-code-subagents (GitHub) | Yes | None | Reviewed top-level categories; 10 categories, all software/business/data. Confirmed: no community reference for a bicycle/mechanical-craft domain agent at time of authoring. Closest adjacent agents ("embedded-systems", "IoT-engineer") cover programmable hardware, not physical repair. |
| Anthropic agent-domain skill (`~/.claude/skills/agent-domain/SKILL.md`) | Yes | Yes | Followed end-to-end; persona-as-stance frame, bidirectional deferrals, surface-then-defer, citation discipline, heuristics-not-checklists. |

---

## Bodies of knowledge surveyed

| Source | Type | Version / date | Jurisdiction or scope | Notes |
|---|---|---|---|---|
| Park Tool Repair Help (parktool.com/blog/repair-help) | Industry de-facto reference (manufacturer-published, mechanic-audience) | Continuously updated (web) | Global; English | Treated as the canonical practitioner reference for bicycle service procedures. 187+ articles organized by component group (drivetrain, brakes, wheels, hubs, headsets, BBs, suspension, tools). |
| Park Tool BBB-4 — Big Blue Book of Bicycle Repair, 4th Edition | Industry de-facto reference (book) | 4th ed. (2019), Calvin Jones / Dan Garceau, Park Tool Co., ISBN 978-0-9765530-6-9 | Global | Print reference; 480 pages, ~1000 photos. Covers 12-speed, 1x, tubeless, disc, electronic shifting, suspension service, updated torque specs. |
| Sheldon Brown's Bicycle Technical Information (sheldonbrown.com) | Practitioner encyclopedic reference | Maintained by Harris Cyclery / community after S. Brown's death (2008); still updated | Global; English | The definitive open reference for terminology, legacy standards, freewheel/freehub history, wheelbuilding, gearing, and cross-era compatibility. Trusted as glossary and historical/standards reference. |
| Shimano Service Documentation portal (si.shimano.com) | Manufacturer service documentation | Per-component, continuously updated | Global | Primary source for Shimano dealer manuals (DM-*), service manuals (SM-*), exploded views (EV-*), and torque specs. DM-GN0001 is the General Operations manual referenced for chain wear and tooling. |
| SRAM Service Manuals & Support (docs.sram.com, support.sram.com) | Manufacturer service documentation | Per-component, continuously updated | Global | Primary source for SRAM AXS, Eagle, Eagle Transmission (T-Type), DUB BB, hydraulic brake bleed (DOT, mineral) procedures. Source for UDH spec and T-Type direct-mount torque (35 Nm). |
| SRAM/RockShox service interval mat | Manufacturer service interval reference | Current (PDF) | Global | 50-hour lower-leg, 200-hour damper-rebuild cadence for current RockShox forks; differentiated by component. |
| Fox Bike Tech Help Center (tech.ridefox.com) | Manufacturer service documentation | Continuously updated | Global | Service procedures, intervals (125-hour or annual for current product), and tuning specs for Fox forks/shocks. |
| ETRTO (European Tyre and Rim Technical Organisation) standards | Standards body | 2020 revision (TSS hookless designation); ongoing | International (de-facto global) | The reference body for rim/tire diameter, bead-seat tolerance, and tubeless designations. Defines hookless rim/tire compatibility envelope. |
| ISO 5775 (tyre and rim designation) | Standards body | Current | International | Underlies ETRTO and Shimano/SRAM/manufacturer tire/rim sizing. |
| SHIS (Standardized Headset Identification System) | Industry consortium standard | Adopted ~2010 by Cane Creek, Chris King, FSA, others | Global | The notation used to describe headset bearing standards (EC/ZS/IS + diameters). Park Tool, Cane Creek, and others publish full SHIS reference tables. |
| BikeRadar buyer's guides (bikeradar.com/advice) | Industry trade press | Continuously updated | Global | Useful for current-state standards summaries (BB, axle, hookless, AXS) when official documentation is split across vendor sites. Trade press; cross-check against manufacturer source for definitive torque or compatibility. |
| Slowtwitch hookless rim coverage | Industry trade press | 2023–2024 articles, ongoing | Global | Detailed coverage of hookless rim/tire compatibility, ETRTO TSS standard, and pressure ceilings. Useful for the road-tubeless compatibility table. |
| Bosch eBike Systems service documentation (bosch-ebike.com/help) | Manufacturer e-bike documentation | Continuously updated | Global | Sensor-alignment specs, error codes, dealer-only service boundary. |
| Shimano STEPS dealer manuals | Manufacturer e-bike documentation | Per-system | Global | E-bike speed-sensor gap (3–17mm) and torque-sensor error codes (W013/W103/W106). |
| Wheels Manufacturing BB standards chart (wheelsmfg.com/pages/bb-standards) | Manufacturer reference / industry tool | Continuously updated | Global | Comprehensive cross-reference of BB shell standards and crank-spindle compatibility, including BB30/PF30/T47/BB86/92/BB386EVO/DUB. |
| Park Tool wheel tension measurement guide | Manufacturer reference | Continuously updated | Global | TM-1 tensiometer usage, recommended tension ranges (100–120 kgf typical), spoke-to-spoke variance target (~10%). |
| Loctite product datasheets (Henkel) | Manufacturer reference | Current | Global | Threadlocker grades: 222 (purple/low), 242/243 (blue/medium), 270/271 (red/high). Application temp, cure time, removal procedure. |

**Absence of formal standards for**: home-mechanic certification (ASE-equivalent doesn't exist for bicycles outside of UBI/Barnett's/Park Tool School certification programs, which are training not regulation). Bike-fit anthropometrics is partially codified (Bicycling magazine charts, Steve Hogg method, Retul, Body Geometry) but has no single canonical authority — the agent stays out of anthropometric prescription for this reason.

---

## Citations referenced in the agent body

| Inline reference | Source | URL or location |
|---|---|---|
| Park Tool repair guide (general) | Park Tool Repair Help | https://www.parktool.com/en-us/blog/repair-help |
| Park Tool BBB-4 | Big Blue Book of Bicycle Repair 4th ed. | https://www.parktool.com/en-int/product/big-blue-book-of-bicycle-repair-4th-edition-bbb-4 |
| Shimano dealer manual DM-GN0001 | Shimano Dealer's Manual — General Operations | https://si.shimano.com/en/pdfs/dm/GN0001/DM-GN0001-26-ENG.pdf |
| Park Tool chain wear procedure | When to Replace a Worn Chain | https://www.parktool.com/en-us/blog/repair-help/when-to-replace-a-chain-on-a-bicycle |
| Park Tool Bottom Bracket Standards | Bottom Bracket Standards and Terminology | https://www.parktool.com/en-us/blog/repair-help/bottom-bracket-standards-and-terminology |
| Park Tool SHIS headset reference | Standardized Headset Identification System | https://www.parktool.com/en-us/blog/repair-help/standardized-headset-identification-system |
| Park Tool tubeless tire compatibility | Tubeless Tire Compatibility | https://www.parktool.com/en-int/blog/repair-help/tubeless-tire-compatibility |
| Park Tool wheel tension measurement | Spoke Tension Measurement and Adjustment | https://www.parktool.com/en-us/blog/repair-help/wheel-tension-measurement |
| Park Tool shift cable housing | Cutting and Sizing Cable Housing | https://www.parktool.com/en-us/blog/repair-help/cutting-and-sizing-cable-housing |
| Sheldon Brown wheelbuilding | Wheelbuilding | https://sheldonbrown.com/wheelbuild.html |
| Sheldon Brown cables | Cables | https://www.sheldonbrown.com/cables.html |
| Sheldon Brown servicing headsets | Servicing Bicycle Headsets | https://www.sheldonbrown.com/headsets.html |
| Shimano service documentation portal | Shimano Service Information | https://si.shimano.com |
| SRAM Eagle Transmission user manual | UM — Transmission | https://docs.sram.com/en-US/publications/5jblJ4SRpeHwjcuWG1vPy4/UM%20-%20Transmission |
| SRAM mineral-oil MTB brake manual | UM — Mineral Oil MTB Disc Brake Installation, Hose Shortening, and Bleed | https://docs.sram.com/en-US/publications/1zPBXB1BWfF7E1mLreIuVi/UM%20-%20Mineral%20Oil%20MTB%20Disc%20Brake%20Installation,%20Hose%20Shortening,%20and%20Bleed%20Manual |
| SRAM DOT MTB brake manual | BM — DOT Fluid MTB Disc Brake Hose Shortening and Bleed | https://docs.sram.com/en-US/publications/2Ytcvt5o3cIrCxyHM0Ggah/BM%20-%20DOT%20Fluid%20MTB%20Disc%20Brake%20Hose%20Shortening%20and%20Bleed%20Manual |
| SRAM Transmission torque (35 Nm) | SRAM support — thru-axle/derailleur torque | https://support.sram.com/hc/en-us/articles/13819403761051 |
| SRAM UDH overview and spec | UDH | https://www.sram.com/en/sram/mountain/products/udh |
| SRAM Eagle T-Type installation | How do I install SRAM Eagle AXS Transmission | https://support.sram.com/hc/en-us/articles/13819063203611 |
| RockShox service intervals | RockShox/SRAM Service Interval Counter Mat (PDF) | https://www.sram.com/globalassets/document-hierarchy/service-manuals/sramrockshox-service-interval-counter-mat.pdf |
| Fox service procedures | FOX Bike Tech Help — Service Procedures | https://tech.ridefox.com/bike/list/service-procedures |
| BikeRadar BB standards guide | The complete guide to bottom bracket standards | https://www.bikeradar.com/advice/buyers-guides/the-complete-guide-to-bottom-bracket-standards |
| BikeRadar headset guide | The ultimate guide to bike headset types | https://www.bikeradar.com/advice/buyers-guides/the-ultimate-guide-to-headsets |
| BikeRadar hookless rims | What are hookless rims? | https://www.bikeradar.com/features/hookless-rims-road-tubeless |
| BikeRadar UDH explainer | SRAM UDH explained | https://www.bikeradar.com/advice/workshop/sram-udh |
| Wheels Mfg BB standards chart | Bottom Bracket Standards Chart | https://wheelsmfg.com/pages/bb-standards |
| Schwalbe hookless reference | Hookless Rims FAQ | https://www.schwalbetires.com/technology-faq/hookless-rims/ |
| Zipp hookless tire compatibility | Hookless tire compatibility guide | https://www.sram.com/en/zipp/campaigns/hookless-tire-compatibility |
| Bosch eBike service help | Service — Bosch eBike Systems | https://help.bosch-ebike.com/us/help-center/ebw-care/asset-ast-00049 |
| Off-road.cc freehub guide | Which freehub body do I need? | https://off.road.cc/content/feature/which-freehub-body-do-i-need-sram-shimano-9-10-11-12-speed-hg-xd-micro-spline |
| BikeGremlin SHIS | Bicycle headset bearings standards (SHIS) | https://bike.bikegremlin.com/3476/bicycle-headset-bearings-standards/ |
| BetterShifting Shimano docs guide | Learn how to use the Shimano documentation | https://bettershifting.com/learn-how-to-use-the-shimano-documentation/ |

---

## Jurisdictional and temporal caveats

- **Temporal**: drivetrain standards are evolving rapidly. SRAM T-Type Transmission was introduced 2023 and is reshaping derailleur mounting on UDH-compatible frames. Shimano 12-speed road (R8100/R7100/R9200) and the freehub-body landscape (Microspline, XDR, N3W) is current as of authoring (2026); future 13-speed or wireless-only road may require revision. Re-survey freehub-body landscape every 12–18 months.
- **Temporal**: ETRTO/ISO hookless rim standards were significantly tightened in the 2020 revision (TSS designation, ±0.05mm bead-seat tolerance). Pre-2020 hookless rims may not conform; agent guidance assumes 2020+ standards. Cross-check any specific rim against manufacturer spec before applying hookless rules.
- **Temporal**: torque specs are subject to manufacturer revision (the SRAM Transmission 25 Nm → 35 Nm change is the explicit example). Always confirm against the *current* manufacturer publication for safety-critical fasteners; agent values are reasonable defaults but not authoritative against an updated spec sheet.
- **Jurisdictional (none)**: bicycle maintenance is essentially global — same parts, same standards. The major exception is **e-bike classification regulation** (US Class 1/2/3, EU EPAC/L1e-A/B, UK EAPC, AU/NZ pedelec), which affects what motor power and assist speed is *legal*, not how to maintain it. The agent stays out of legal-class advice and refers to local statute when asked.
- **Jurisdictional (parts availability)**: freehub bodies, e-bike replacement parts, and proprietary bleed tools may be regionally rationed (SRAM and Shimano both have regional dealer networks). The agent answers "what to do" without making distribution assumptions; the user resolves "where to source it."

---

## Design Notes

Patterns that emerged during authoring that may benefit other domain agents or future revisions:

1. **Interface-not-part persona frame.** The persona stance "every failure is a symptom of an interface, not an intrinsic property of a part" generalizes well to other mechanical-craft domains (woodworking joinery, automotive driveline, plumbing fittings, electrical connections). For a domain where novices commonly misattribute symptoms to parts, this frame is more useful than "you are an expert in X." Recommend for `recreation-` and `craft-` prefix agents that involve diagnosis.

2. **Diagnosis as a distinct output mode.** This domain needed a Diagnosis/Troubleshooting output mode that the skill spec does not name directly — it's distinct from a Tradeoff/Decision (where the user has named options) and from a Procedure (where the user has named the work). The structure I used (most-likely cause → cheapest reversible test → next-most-likely → cost-of-being-wrong → stop-points) is reusable for *any* failure-diagnosis domain: medicine, plumbing, automotive, IT troubleshooting, debugging. Worth proposing as a fifth named mode in the skill spec for diagnostic-heavy domains.

3. **Triage as a distinct output mode for safety-critical concerns.** Frame-crack inspection produces a different answer shape than diagnosis — the question is "is this safe?" not "what is it?" The Triage mode (rideable now / what it might be / who can fix / acceptable interim use) generalizes to any domain with structural-safety stakes (boating, climbing gear, structural building, electrical safety).

4. **Standards-soup compatibility tables are load-bearing.** Domains with many incompatible standards (freehub bodies × cassettes; BB shells × crank spindles; brake fluid × caliper) need explicit tables, not narrative. The agent leans on enumeration for these because narrative obscures the binary "compatible / not compatible" answer the user actually needs. Recommend for any domain with high-stakes physical-fit incompatibilities (audio cable types, plumbing fittings, electrical connectors).

5. **Surface-then-defer to hypothetical peer agents.** Since several reasonable peer agents don't exist yet (`health-injury-prevention`, `recreation-cycling-fit`, `recreation-cycling-training`), the agent names them as deferral targets *as if they exist* — this both reserves the boundary cleanly for when those agents are created, and tells the current user "this knee question is in scope to *flag*, but for actual diagnosis go see a fit / health professional." Same pattern would work in any prefix family where the domain naturally splits but only some agents have been authored yet.

6. **"Ask before guessing" is enforceable in the prompt.** The output-format section closes with an explicit list of variables the agent must ask about rather than guess (freehub body, frame material, brake brand, fluid type, model year). For domains where guessing produces compounded damage (giving the wrong fluid, recommending an incompatible part), this explicit must-ask list is more reliable than relying on the persona's general caution.

7. **Manufacturer documentation as primary source, trade press as secondary, community as tertiary.** The sources table follows this hierarchy. Trade press (BikeRadar, Pinkbike, Slowtwitch) is included only for current-state landscape summaries; manufacturer documentation (Shimano SI, SRAM docs, Fox Tech, Park Tool) is the citation for any specific spec. This hierarchy generalizes to other domains with strong manufacturer documentation (camera repair, appliance repair, automotive). Worth codifying in `agent-domain` skill.
