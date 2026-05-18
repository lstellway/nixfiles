# Sources — `nature-garden-general`

Companion to `nature-garden-general.md`. Records the body-of-knowledge survey, existing-agent review, citations referenced in the agent body, and temporal/jurisdictional caveats.

## Existing agents and skills consulted

- **Searched** https://github.com/VoltAgent/awesome-claude-code-subagents for gardening / horticulture / nature / plant agents — no relevant subagents found at survey time. Repository is heavily software-engineering oriented.
- **Reviewed local `~/.claude/agents/`** — 34 existing agents, all in `software-`, `technology-`, or workflow categories. No prior `nature-`, `garden-`, or `plant-` prefixed agents. No precedent voice/scope to inherit from in this domain cluster.
- **Reviewed sibling discipline-style agents** (e.g., `software-security.md`, `software-architecture.md`) for output-format conventions used in this repo (tagged-severity reviews, "Knowledge question / Tradeoff / Design / Artifact review" output modes). Adopted the tagged-finding format for artifact review but kept the consultation modes as primary, per the `agent-domain` skill spec.
- **Reviewed `technology-nix.md`** as an example of an authoritative-sources table pattern. Adapted lightly for the gardening domain (Knowledge section organized by sub-topic rather than a docs-lookup table, because gardening knowledge is conceptual and locale-bound, not API-bound).
- **No community gardening agents adopted.** The domain is dominated by content farms; authoritative material lives at extensions, RHS, and a small canon of books (Dirr, Tallamy, Capon, *American Horticultural Society A–Z*).

## Bodies of knowledge surveyed

Gardening lacks a single canonical framework. The agent aggregates across regulatory-adjacent best practice (extension recommendations), professional convention (ISA arboriculture, ARS for roses), scholarly horticulture, and ecological-restoration ecology.

| Source | Type | Version / date | Jurisdiction or scope | Notes |
|---|---|---|---|---|
| [USDA Plant Hardiness Zone Map](https://planthardiness.ars.usda.gov/) | Government reference | 2023 release, based on 1991–2020 data | United States (incl. PR, HI) | The North American baseline for cold hardiness. 2023 release added zones 12–13, warmed ~½ of US by half a zone vs. 2012. Update cycle is roughly decadal. |
| [USDA ARS news release on 2023 update](https://www.ars.usda.gov/news-events/news/research-news/2023/usda-unveils-updated-plant-hardiness-zone-map/) | Government source description | November 2023 | US | Source for the 13,412-stations vs. 7,983-stations methodology improvement. |
| [Royal Horticultural Society (RHS) — Advice](https://www.rhs.org.uk/advice) | Professional society | Continuously updated | UK / temperate climates | Primary UK reference; pruning, soil, plant selection, problem diagnosis. The [RHS Pruning Groups 1–13](https://www.rhs.org.uk/pruning/rhs-pruning-groups) system is the cleanest published taxonomy for shrub pruning timing. |
| [UC Statewide IPM Program — Home & Garden](https://ipm.ucanr.edu/PMG/menu.homegarden.html) | University extension | Continuously updated | California; principles broadly applicable | Gold-standard IPM resource. Pest Notes are peer-reviewed by UC ANR. The IPM hierarchy (identify → threshold → cultural → mechanical → biological → chemical) used in the agent comes from UC IPM. |
| [Cornell Cooperative Extension — SoilNOW / Garden Resources](https://blogs.cornell.edu/soilnow/amendment/compost-as-amendment-and-mulch/) | University extension | Continuously updated | Northeast US; principles applicable | Soil amendment, compost-vs-mulch, applied rates. |
| [University of Maryland Extension — Organic Matter and Soil Amendments](https://extension.umd.edu/resource/organic-matter-and-soil-amendments) | University extension | Current | Mid-Atlantic US | Cited for soil pH and amendment guidance. |
| [Penn State Extension — Cool vs. Warm Season Vegetables](https://extension.psu.edu/cool-season-vs-warm-season-vegetables) | University extension | Current | Northeast US | Cited for the cool/warm vegetable distinction and timing relative to frost. |
| [UMN Extension — Pruning Trees and Shrubs](https://extension.umn.edu/planting-and-growing-guides/pruning-trees-and-shrubs) | University extension | Current | Upper Midwest; cold-climate applicable | Cited for old-wood vs. new-wood pruning timing. |
| [Iowa State Yard & Garden — Proper Time to Prune](https://yardandgarden.extension.iastate.edu/how-to/proper-time-prune-trees-and-shrubs) | University extension | Current | Midwest US | Cited for pruning timing reinforcement. |
| [UF/IFAS EDIS — ENH1156 Right Plant, Right Place](https://edis.ifas.ufl.edu/publication/EP416) | University extension | Current | Florida / southern US; concept universal | The most rigorous public-domain articulation of the right-plant-right-place principle. |
| [Colorado State University Extension — Xeriscape and Soil](https://www.extension.colostate.edu/docs/pubs/garden/07235.pdf) | University extension | Current | Arid west US | Cited for xeriscape principles, deep-infrequent watering. |
| [USU Extension — Backyard Drip Irrigation](https://extension.usu.edu/yardandgarden/research/the-do-it-yourself-guide-to-backyard-drip-irrigation) | University extension | Current | Intermountain west US | Cited for drip irrigation guidance and 30–70% water savings figure. |
| [Virginia Tech VCE SPES-384 — Soil Test Report Simplified](https://www.pubs.ext.vt.edu/content/pubs_ext_vt_edu/en/SPES/spes-384/spes-384.html) | University extension | Current | Mid-Atlantic US; principles universal | Cited for soil-test interpretation. |
| [UMN Soil Testing Laboratory — Lawn & Garden Recommendations](https://soiltest.cfans.umn.edu/recommendations-lawn-garden) | University extension lab | Current | Upper Midwest | Cited for soil testing program reference. |
| Michael A. Dirr, *Manual of Woody Landscape Plants* (6th ed.) | Reference monograph | 2009; 6th ed. 2009; ongoing reprints | North America | The canonical reference for trees, shrubs, vines: identification, hardiness, culture, propagation, cultivars, landscape use. Stipes Publishing. Often called "the horticulture bible." |
| Douglas W. Tallamy, *Bringing Nature Home* (2007/updated 2009) and *Nature's Best Hope* (2020) | Trade-scholarly book | 2007, 2009, 2020 | North America | Foundational case for native-plant ecological gardening. Tallamy is professor of entomology and wildlife ecology, University of Delaware. The "70% native" planning target, keystone genera concept, and host-plant focus derive here. |
| [Homegrown National Park](https://homegrownnationalpark.org/) | Nonprofit / advocacy | Founded 2020 | North America | Tallamy's applied initiative; useful framing for "less lawn, more native" conversations. |
| [National Wildlife Federation — Native Plant Finder](https://www.nwf.org/nativeplantfinder/) | Nonprofit database | Continuously updated | United States (by zip code) | Database of keystone host-plant rankings by US zip code, building on Tallamy's research. |
| [EPA Level III/IV Ecoregions](https://www.epa.gov/eco-research/ecoregions) | Government reference | Continuously updated | US (Level III/IV); North America (Level I/II) | The right unit for "where is this plant native?" — finer than USDA zones, coarser than biotic communities. |
| International Society of Arboriculture (ISA) Best Management Practices — Tree Planting; Pruning | Professional standards | Periodic revisions | International (ISA membership) | Standards for planting depth, root flare, the three-cut method, branch collar, no-topping. |
| Alex L. Shigo, *Modern Arboriculture* / CODIT concept | Academic / professional reference | 1991 and prior papers | International | The branch-collar / compartmentalization-of-decay basis for pruning-cut placement. |
| State invasive species councils (e.g., Mass. Invasive Plant Advisory Group, California Invasive Plant Council) | Regulatory-adjacent | Continuously updated | State-by-state | Invasive plant lists vary substantially by state — surfaced in the agent as "consult your state council." |
| State Cooperative Extension network (e.g., Cornell, Penn State, UC ANR, UF/IFAS, UMN, OSU, CSU, NCSU, Texas A&M, UGA) | University extension | Continuously updated | Per-state | The agent treats *any* state's extension as authoritative for that state's region. When the user names a region, the agent should default to that state's extension for specifics. |
| [American Horticultural Society — Heat Zone Map](https://ahsgardening.org/) | Nonprofit professional society | 1997; periodic updates | US | The heat-zone counterpart to USDA cold-hardiness. Important in zone 7+. |
| Sunset Western Garden Book / Sunset climate zones | Trade reference | Periodic editions | Western US | Finer-grained climate zones accounting for elevation, marine influence, summer/winter dryness. |
| The Old Farmer's Almanac frost-date database | Trade reference | Continuously updated | US / Canada | A common public source for last-frost / first-frost averages by zip code; cross-check against NOAA. |

## Citations referenced in the agent body

Each pointer in the agent file resolves to one or more of the rows above:

- "Cornell Cooperative Extension" / "OSU Extension" / "UMD Extension" — university extension rows above, soil and amendment guidance.
- "Penn State Extension" / "UMN Extension" / "NCSU Extension" — vegetable timing and pruning timing references.
- "UF/IFAS EP416" — Right Plant, Right Place principle.
- "planthardiness.ars.usda.gov" — USDA 2023 hardiness map.
- "RHS Pruning Groups" — rhs.org.uk pruning-group taxonomy.
- "UC IPM" / "ipm.ucanr.edu" — IPM hierarchy and pest-management framing.
- "Virginia Tech VCE SPES-384" / "UMN Soil Testing Lab" — soil-test guidance.
- "Colorado State Extension" / "USU Extension" — xeriscape, deep-infrequent watering.
- "Dirr" — *Manual of Woody Landscape Plants*; planting practice, no amended backfill, cultivar information.
- "Tallamy" — *Bringing Nature Home*; native-plant ecological gardening, 70% target, keystone genera.
- "ISA" — Best Management Practices; planting depth, three-cut method, branch collar, no-topping.
- "Shigo" — CODIT and branch-collar placement of pruning cuts.

## Jurisdictional and temporal caveats

- **USDA hardiness zones**: pinned to the 2023 update. Roughly half the US shifted half-a-zone warmer vs. the 2012 map; if the user references their zone from older sources, ask whether they've checked the 2023 map. Next update is expected in the early 2030s.
- **Frost dates**: shifting with climate change (NOAA climate normals are updated every decade; the current normals are 1991–2020). Older almanac frost-date tables can be 1–2 weeks pessimistic in much of North America.
- **Pesticide regulations**: not covered in depth — neonicotinoid restrictions vary by state (Maine, Maryland, etc. have restrictions on consumer sale; the EU has broader restrictions). The agent surfaces "neonics persist in plant tissue" but does not provide legal compliance advice.
- **Invasive species lists**: state-by-state. Plants legal in one state may be banned for sale in a neighboring state (e.g., burning bush, Japanese barberry — restricted or banned in some northeastern states, still sold elsewhere). The agent should ask for state when invasive risk is in play.
- **Native plant identity**: ecoregion-bounded. "Native to North America" is too coarse for planting decisions; the agent should push to EPA Level III/IV ecoregion or state native-plant-society lists.
- **Extension recommendations**: pegged to the extension's home region. CSU recommendations for watering frequency are wrong for the Pacific Northwest; Penn State pest pressure is different from Florida's. The agent should default to the user's region's extension when locale is named.

## Scope boundaries with sibling agents

This agent is part of a three-agent garden cluster authored together. Boundaries are stated bidirectionally; see the agent body for the user-facing version.

### vs. `nature-garden-roses`

- **Stays here**: general site selection (sun hours, drainage), soil prep and amendment, general IPM context, mulching, watering principles, the general planting depth question for grafted plants in cold climates.
- **Defers to roses agent**: rose cultivar/class selection (hybrid tea, floribunda, shrub, English, climber, rambler, OGR — many with different pruning needs), pruning by class (hard-prune hybrid teas in spring; light-prune once-blooming OGRs after flowering), rose-specific diseases (black spot, rose rosette virus — virtually unique to roses, downy mildew, cane canker), rose-specific pests (rose midge, rose slug, cane borers), winter protection methods (Minnesota Tip, mounding, rose cones), American Rose Society exhibition standards.
- **Surface-then-defer pattern**: when a user asks a general question that touches rose specifics ("how do I improve clay soil before planting roses?"), this agent handles the soil portion and points to the rose agent for rose-specific cultivar selection and aftercare.

### vs. `nature-garden-viticulture`

- **Stays here**: general site assessment for a planned vineyard (sun, soil, drainage, frost pocket avoidance), general IPM context, soil testing and amendment before planting, pruning of ornamental grape arbors where fruit is incidental.
- **Defers to viticulture agent**: training systems (VSP, Geneva Double Curtain, Scott Henry, head-trained, cordon vs. cane pruning), canopy management for fruit quality, brix monitoring, harvest timing, wine vs. table grape varietal selection, terroir, vineyard-specific pests (phylloxera, grape berry moth, esca, Pierce's disease), rootstock selection.
- **Surface-then-defer pattern**: a question like "should I plant grapes on this slope?" gets a general site-suitability answer here, then a hand-off to viticulture for varietal selection and training system.

### No overlap with other batch siblings

`recreation-cycling-maintenance`, `nature-pet-dog`, `social-relationships-romantic`, `psychology-developmental` — no scope overlap with general home gardening. Ignored.

## Design Notes

Patterns that emerged during authoring this agent — potentially useful for other domain agents:

1. **"Site problem first, plant problem second"** as a persona stance. For diagnostic domains where most user-reported failures are environmental rather than the named cause, encoding the diagnostic order in the persona itself prevents the agent from leaping to exotic causes. Analogous framings: "configuration problem first, code problem second" for ops; "process problem first, person problem second" for management.

2. **Locale-as-context, not blocker.** Gardening is intensely jurisdictional (zone, region, ecoregion, frost dates, extension recommendations vary by state). The skill spec's guidance to "name the variables and ask only when the answer actually depends on them" worked well here — the Context section enumerates what's needed and the Heuristics include "if the answer requires zone and they haven't said, ask once and proceed." This avoids the "first say your zone, then your soil, then your sun hours, then I'll begin" anti-pattern.

3. **Surface-then-defer for sibling boundaries.** With three closely-related garden agents, naive deferral ("ask the rose agent") leaves the user adrift. The pattern adopted: handle the general portion of the question here (soil prep, site selection, IPM context), then explicitly hand off the specialist portion. Stated bidirectionally — the sibling agents do the same in reverse — this prevents loops.

4. **"Three principles that resolve 80%"** sub-section pattern. For pruning, the agent gives three rules that handle the bulk of cases, then deeper detail for the remainder. This compresses without flattening; the user can act on the simple version and the agent can go deeper on demand. Useful pattern for any domain with a long tail of edge cases under a small core of decision rules.

5. **No "ungrounded experts recommend"** discipline. Every assertion in the body either cites a source (RHS, UC IPM, named extension, Dirr, Tallamy, ISA), names a mechanism (laziness in IPM thresholds, root-zone training in deep-infrequent watering), or is flagged as a stated assumption. This is harder to enforce in soft-knowledge domains than in regulated ones; the discipline matters more, not less.

6. **Extension network as a meta-source.** Rather than citing 50 individual state extensions in line, the agent treats "your state's cooperative extension" as a citable institution. The sources file lists representative examples and says "any state's extension is authoritative for that state." This avoids both over-citation and the trap of citing only one state's recommendations as if universal.
