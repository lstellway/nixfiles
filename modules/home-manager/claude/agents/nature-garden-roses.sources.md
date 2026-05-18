# Sources — nature-garden-roses

Companion provenance file for the `nature-garden-roses` domain agent.

## Existing agents and skills consulted

- **VoltAgent awesome-claude-code-subagents** (https://github.com/VoltAgent/awesome-claude-code-subagents) — surveyed; the collection is software-development-focused and contains no horticulture, gardening, or rose-cultivation agent. Reviewed but not adopted as a content source. Useful only as a reminder that domain agents outside software remain unrepresented in community catalogs.
- **`~/.claude/agents/software-*` and `~/.claude/agents/technology-*`** — surveyed for format and structural patterns. Adopted the frontmatter shape (`name`, `description`, `tools`), the `## Scope` + `## Knowledge` + `## Heuristics` + `## Output Format` skeleton, and the consultation-leads-with-tradeoff/decision/design split. Did not adopt the software-review checklist style — that style is artifact-review-centric and was deliberately demoted to a secondary mode per the agent-domain skill spec.
- **Skill: `agent-domain` (`~/.claude/skills/agent-domain/SKILL.md`)** — followed end-to-end. The persona-stance guidance ("strong: a stance and judgment frame; weak: an expertise claim") shaped the opening sentences of the agent. The specificity test, citation discipline, and heuristics-not-checklists rules guided knowledge density.

## Sibling agents (Step 4 scope boundaries)

- **`nature-garden-general`** — paired sibling. Bidirectional scope boundary stated in the agent body: rose-specific soil targets, rose IPM, rose placement, rose-companion interactions stay here; general soil amendment, garden-wide IPM principles, garden design, irrigation system selection, mulch tradeoffs, non-rose ornamental issues defer there.
- **`nature-garden-viticulture`** — no overlap. Both are specialists under the garden umbrella with disjoint subject matter.
- Other agents in the parallel batch (`recreation-cycling-maintenance`, `nature-pet-dog`, `social-relationships-romantic`, `psychology-developmental`) — no overlap with rose cultivation.

## Bodies of knowledge surveyed (Step 2)

| Source | Type | Version / date | Jurisdiction or scope | Notes |
|---|---|---|---|---|
| American Rose Society "Rose Classifications" | Professional association reference | Current (rose.org/rose-classifications) | International (ARS holds ICRA authority since 1955) | Authoritative class taxonomy; ~39 classes; basis for the Knowledge: Class section |
| ARS "Guidelines for Judging Roses" | Standards body / judging manual | March 2024 | ARS-sanctioned shows (primarily US/Canada) | Six judging elements with point allocations; basis for Exhibition Culture section |
| ARS "Fungicides Made Simple" | Practitioner reference | Current | US-applicable; FRAC group classification is international | Rotation logic for FRAC 3/11/M3/M5 fungicides; underpins black spot rotation guidance |
| ARS "A Fertilizer Primer: What's In that Rose Food?" | Practitioner reference | Current | US-applicable | Macronutrient role descriptions; cited in fertility section |
| ARS "Winterizing Roses in the North Central District" | Practitioner reference | Current | US Zone 3–5 central/upper Midwest | Source for hilling, Minnesota tip cross-reference |
| Modern Roses XII (ARS registry) | Registry / catalog | 12th ed., 2007 (with ongoing online updates) | International cultivar registry | Cited as durable reference for cultivar identity; variety-specific data changes constantly so referenced not embedded |
| Beales, *Classic Roses: An Illustrated Encyclopedia and Grower's Manual* | Reference book | Peter Beales, 1985/1997 | International, OGR-focused | Authoritative on Old Garden Rose class behavior |
| Help Me Find — Roses (helpmefind.com/rose) | Community-maintained database | Ongoing | International cultivar database | Cross-reference for cultivar lineage and class; not directly cited but acknowledged as the community standard |
| Combined Rose List (CRL) | Annual commercial catalog | Annual | US/Canada nursery sources | Source-availability reference; not directly cited |
| Oklahoma State Extension EPP-7329 "Rose Rosette Disease" | University extension publication | Current | US central plains baseline; widely applicable | Primary RRV reference; symptom description, *Phyllocoptes fructiphilus* vector identification, management |
| Texas A&M AgriLife "Rose Rosette Virus" | University extension publication | Current | Texas baseline; widely applicable | RRV management; ongoing breeding program for resistance |
| APS *Plant Disease* "Identification of a Second Vector for Rose Rosette Virus" | Peer-reviewed research | 2023 | International | Update on vector biology; *P. fructiphilus* remains primary |
| APS *Plant Health Progress* "Rose Rosette Disease: A Diagnostic Guide" | Peer-reviewed practitioner ref | 2022 | International | Diagnostic protocol |
| UFlorida IFAS PP268 "Black Spot of Rose" | University extension publication | Current | US Southeast humid baseline; widely applicable | Primary black spot lifecycle and management reference |
| UFlorida IFAS PP338 "Rose Mosaic Virus" | University extension publication | Current | US Southeast | PNRSV/ApMV complex; transmission and management |
| PNW Pest Management Handbook — Rose Black Spot / Powdery Mildew / Rust / Rose Mosaic | Regional handbook | Current annual ed. | US Pacific Northwest | Regional disease management; cited for rust prevalence and downy mildew |
| Clemson HGIC "Pruning Roses" and "Rose Insects & Related Pests" | University extension publication | Current | US Southeast | Pruning class-specific guidance; pest field guide |
| UMd Extension "Guide to Pruning Roses" | University extension publication | Current | US Mid-Atlantic | Cross-checked pruning protocols |
| UC IPM "Roses: Insects and Mites" (pnrosesinsect.pdf) | University extension IPM | Current | US California-focused; widely applicable | Comprehensive rose pest IPM |
| Iowa State Extension "How to Propagate Roses" | University extension publication | Current | US Midwest | Propagation cross-reference |
| OSU Extension Service "Pruning Roses" | University extension publication | Current | Oregon / PNW | Pruning timing |
| UTennessee Extension W833 "Rose Diseases: Identification and Management" | University extension publication | 2021 | US Mid-South | Disease management cross-reference |
| HortScience 59(5):673 "Effect of Fungicides and Application Intervals for the Control of Black Spot of Roses" | Peer-reviewed research | 2024 | International applicable | Modern fungicide efficacy data; FRAC rotation evidence |
| David Austin Roses "A Guide to Pruning" (eu.davidaustinroses.com/blogs/rose-care/a-guide-to-pruning) | Breeder cultivation guide | Current | International (Austin's English roses) | English/Austin shrub pruning protocol — distinct from HT/Floribunda |
| Santa Clarita Valley Rose Society "Update on Different Kinds of Rose Rootstocks" | ARS local society practitioner ref | Current | US-applicable | Rootstock comparison; Dr. Huey, multiflora, fortuniana, canina behavior |
| Temecula Valley Rose Society "Discover Your Roots" | ARS local society practitioner ref | Current | US-applicable | Rootstock cross-reference |
| Bachman's "Minnesota Tip Method for Winterizing Tender Roses" | Commercial nursery practitioner ref | Current | Zone 3–5 | Procedure detail for Minnesota tip; history (Jerry Olson and Albert Nelson, 1950s) |
| Hartmann & Kester *Plant Propagation: Principles and Practices* | Textbook | 8th ed., 2010 (or current) | International horticultural standard | Foundational reference for IBA hormone concentrations and cutting protocols (not a rose-specific source but the underlying horticultural science) |
| Royal Horticultural Society — Modern Bush Pruning, Climbing Rose Pruning, Powdery Mildew | Professional society practitioner ref | Current | UK-applicable; widely transferable | Cross-checked pruning and disease guidance |
| New York Botanical Garden Mertz Library "Pruning Roses" research guide | Botanical garden library | Current | US Northeast | Cross-reference |
| University of Maine Cooperative Extension "Black Spot of Rose" | University extension publication | Current | US Northeast | Cross-reference for black spot |
| MDPI *Pathogens* "Exploring the Host Range of Rose rosette Virus among Herbaceous Annual Plants" | Peer-reviewed research | 2022 | International | RRV host range research |
| PMC10780848 "Comparative Study of Bioactive Compounds and Biological Activities of Five Rose Hip Species Grown in Sicily" | Peer-reviewed research | 2024 | International | Vitamin C and carotenoid content by rose species |
| University of Missouri Extension G6601 "Roses: Selecting and Planting" | University extension publication | Current | US Midwest | Site preparation cross-reference |
| Johnson County K-State Extension "Rose Care" | University extension publication | Current | US Kansas/Midwest | Fertility program cross-reference |
| Greater Palm Beach Rose Society "Fertilizers, Soil pH and Fertilizing Your Roses" | ARS local society practitioner ref | Current | Florida/subtropical | pH/micronutrient guidance |

### Notes on absence

- **No formal "rose certification" body** for growers (unlike viticulture's WSET) — domain is community/society-mediated rather than credentialed.
- **Virus-indexed nursery stock standards** in the US are voluntary and patchy; the agent qualifies this in the Rose Mosaic section.
- **Variety-specific resistance data shifts continuously** — RRV resistance breeding is active at multiple land-grant universities, and a "resistant" cultivar list from even 5 years ago will be incomplete. The agent embeds structural disease knowledge and references the live ARS "Roses in Review" annual publication as the durable source for current ratings.

## Citations referenced in the agent body (Step 8 reconciliation)

Inline citation pointers in `nature-garden-roses.md` resolve to:

| Pointer | Full source |
|---|---|
| ARS-1, "ARS Rose Classifications" | https://rose.org/rose-classifications/ |
| ARS *Guidelines for Judging Roses*, March 2024 | https://rose.org/wp-content/uploads/2024/06/2024-Horticulture-Judging-Guidelines.pdf |
| ARS "Fungicides Made Simple" | https://rose.org/fungicides-made-simple/ |
| ARS "A Fertilizer Primer" | https://rose.org/a-fertilizer-primer-whats-in-that-rose-food/ |
| ARS "Winterizing Roses in the North Central District" | https://rose.org/winterizing-roses-in-the-north-central-district/ |
| Beales | Peter Beales, *Classic Roses: An Illustrated Encyclopedia and Grower's Manual*. Holt, rev. ed. 1997. |
| MR-XII | American Rose Society, *Modern Roses XII*. ARS, 2007. |
| Oklahoma State EPP-7329 | https://extension.okstate.edu/fact-sheets/print-publications/epp-entomology-and-plant-pathologhy/rose-rosette-disease-epp-7329.pdf |
| Texas A&M AgriLife "Rose Rosette Virus" | https://agrilifeextension.tamu.edu/asset-external/rose-rosette-virus/ |
| APS Plant Disease 2023 "Identification of a Second Vector" | https://apsjournals.apsnet.org/doi/10.1094/PDIS-11-22-2686-SC |
| Plant Health Progress 2022 RRD Diagnostic Guide | https://apsjournals.apsnet.org/doi/10.1094/PHP-05-22-0047-DG |
| UFlorida IFAS PP268 | https://ask.ifas.ufl.edu/publication/PP268 |
| UFlorida IFAS PP338 | https://ask.ifas.ufl.edu/publication/PP338 |
| OSU Extension Rose Mosaic | https://extension.okstate.edu/programs/digital-diagnostics/plant-diseases/rose-mosaic |
| NMSU Plant Clinic OD-9 | https://plantclinic.nmsu.edu/documents/rose-mosaic-virus-_od-9__final.pdf |
| PNW Pest Management Handbook | https://pnwhandbooks.org/plantdisease/host-disease/rose-rosa-spp-hybrids-black-spot (and parallel disease entries) |
| Clemson HGIC Pruning Roses | https://hgic.clemson.edu/factsheet/pruning-roses/ |
| Clemson HGIC Rose Insects | https://hgic.clemson.edu/factsheet/rose-insects-related-pests/ |
| UMd Extension Pruning Roses | https://extension.umd.edu/resource/guide-pruning-roses |
| UC IPM Roses Insects and Mites | https://ipm.ucanr.edu/pdf/pestnotes/pnrosesinsect.pdf |
| Iowa State Extension Propagate Roses | https://yardandgarden.extension.iastate.edu/how-to/how-propagate-roses |
| OSU Extension Pruning Roses | https://extension.oregonstate.edu/gardening/flowers-shrubs-trees/pruning-roses |
| UTennessee Extension W833 | https://plantsciences.tennessee.edu/wp-content/uploads/sites/25/2021/11/UT-Extension-Rose-diseases-Identification-and-management-W833.pdf |
| HortScience 59(5):673 (2024) | https://journals.ashs.org/hortsci/view/journals/hortsci/59/5/article-p673.xml |
| David Austin Pruning Guide | https://eu.davidaustinroses.com/blogs/rose-care/a-guide-to-pruning |
| Santa Clarita Valley Rose Society Rootstock | http://www.santaclaritarose.org/Rootstock2.html |
| Temecula Valley Rose Society "Discover Your Roots" | https://www.temeculavalleyrosesociety.org/ars-articles/11-Discover-your-roots.html |
| Bachman's Minnesota Tip Method | https://www.bachmans.com/information/resource-hub/minnesota-tip-method-winterizing-tender-roses |
| MDPI Pathogens 2022 RRV Host Range | https://www.mdpi.com/2076-0817/11/12/1514 |
| PMC10780848 Rose Hip Bioactive | https://pmc.ncbi.nlm.nih.gov/articles/PMC10780848/ |
| RHS Modern Bush Pruning | https://www.rhs.org.uk/plants/roses/modern-bush/pruning-guide |
| RHS Climbing Rose Pruning | https://www.rhs.org.uk/plants/roses/climbing/pruning-guide |
| RHS Powdery Mildew | https://www.rhs.org.uk/disease/rose-powdery-mildew |
| UMaine Extension Black Spot | https://extension.umaine.edu/ipm/ipddl/publications/5097e/ |
| UMissouri Extension G6601 | https://extension.missouri.edu/sites/default/files/legacy_media/wysiwyg/Extensiondata/Pub/pdf/agguides/hort/g06601.pdf |
| Johnson County K-State Rose Care | https://www.johnson.k-state.edu/programs/lawn-garden/agent-articles-fact-sheets-and-more/agent-articles/emg-fact-sheets/roses-docs/Rose%20Care.pdf |
| Greater Palm Beach Rose Society Fertilizers | https://www.gpbrs.org/fertilizers-soil-ph-and-fertilizing-your-roses/ |
| Royal National Rose Society (historical) | Defunct as of 2017; legacy publications referenced via ARS and RHS where republished |
| Help Me Find — Roses | https://www.helpmefind.com/rose/index.php |

## Jurisdictional and temporal caveats

- **Rose rosette virus** geographic pressure shifts year-over-year and varies sharply by state and county. The agent's RRV section is calibrated to "ask the user's state and survey for *R. multiflora*" rather than embedding a fixed risk map. Re-survey OSU and Texas A&M AgriLife annually for current vector biology updates and breeding-program resistant cultivar releases.
- **Fungicide product availability and registration** vary by US state and outside the US. The agent names FRAC groups and active ingredients rather than product brand names where possible. Users in EU or other regulatory regimes must verify local registration; the agent's defaults are calibrated to US availability ca. 2024–2026.
- **Rootstock availability** is regional. Dr. Huey dominates US commercial supply; *R. canina* and *R. laxa* dominate EU; *R. fortuniana* is Gulf Coast / Florida specialty. The decision frame in the Rootstock section is geographically scoped accordingly.
- **Cultivar disease resistance is dynamic.** Knock Out (`RADrazz`) is repeatedly cited in the agent body for documented resistance, but its black-spot resistance has eroded in some regions due to new fungal strains, and it is highly susceptible to RRV in mass plantings. Future re-surveys should update both the resistance claims and the mass-planting RRV warning.
- **ARS judging standards** are pinned to the March 2024 edition. The point allocations have shifted historically and may shift again — re-survey before any deep exhibition-prep consultation.

## Design Notes

These observations during authoring may benefit future domain agents (especially other horticulture-adjacent specialists):

- **Class taxonomy is the load-bearing organizing principle for rose questions.** Almost every rose recommendation flows from class behavior — pruning timing, expected disease pressure, expected hardiness, expected size, expected bloom habit. The agent's Knowledge section leads with class, and the heuristics enforce class-first reasoning ("if the plant blooms once a year, prune after bloom"). For other domain agents organized around a similar core taxonomy (dog breeds for `nature-pet-dog`? grape varieties for `nature-garden-viticulture`?), leading with the taxonomy and then deriving behaviors from it produces a more usable knowledge base than organizing by symptom or task.
- **Structural vs. variety-specific knowledge split.** The skill brief flagged this explicitly for roses ("variety-specific knowledge changes constantly; structural knowledge is durable — embed structural, reference variety-specific"). In practice this translated to: embed disease lifecycles, pruning principles per class, hormone concentrations, rootstock behaviors; *reference* specific cultivar names as examples without baking in a "best cultivars" list. The Modern Roses XII registry and ARS "Roses in Review" annual are named as the live sources for variety-specific decisions. This pattern likely applies to other domains with annual cultivar/breed/model churn.
- **Disease pressure × resistance × site triangle** as a dominant evaluation criterion (analogous to software architecture's "tradeoffs explicitly named" frame). When recommendations feel arbitrary, the agent returns to this triangle. Naming a single dominant criterion in the persona section anchors every subsequent answer.
- **Surface-then-defer for cross-cutting concerns.** The bidirectional boundary with `nature-garden-general` is explicit in the Scope section and an example is given (compost strategy: give the rose-specific nutrient targets, defer the bed-build to general). Without this explicit example, "defer to general" is ambiguous.
- **Pressure-test the "naive grower" question.** During Step 7 self-review, traced "what rose should I plant?" — the agent must not answer with a cultivar list; it must ask zone, sun hours, and "what bothered you about your last rose?" The last question is the high-information one and was added during review. Other domain agents with broad "what should I buy/use/do?" questions in their surface area may want a similar three-question scaffold rather than an immediate recommendation.
- **Fungicide rotation specificity.** FRAC group rotation is the kind of detail where vague generality ("rotate your fungicides") fails the specificity test. Naming concrete FRAC groups (3, 11, M3, M5), the 2-sequential-application limit on FRAC 11, and tank-mix vs. alternate-mode logic turns a label into a usable heuristic. This pattern — find the named-group/named-mechanism layer of any field — generalizes to most science-grounded domain agents.
