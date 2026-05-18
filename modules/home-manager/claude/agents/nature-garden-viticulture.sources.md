# Sources — nature-garden-viticulture

Provenance file for the `nature-garden-viticulture` domain agent.

## Existing agents and skills consulted

Searched `~/.claude/agents/` and the nixfiles `modules/home-manager/claude/agents/` directory at authoring time. No existing agriculture, horticulture, garden, or food-production domain agents existed prior to this batch. All current agents are software-domain (`software-*`) or technology-stack (`technology-*`) agents. No reference patterns to adopt from prior agriculture agents.

Reviewed the [VoltAgent awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) catalog — focused on software engineering subagents; no viticulture or horticulture content. Not adopted.

Sibling agents in the same authoring batch (relevant to scope boundaries):

- `nature-garden-general` — general horticulture/gardening agent. Bidirectional deferral with viticulture: general defers viticulture depth here; viticulture defers basic soil chemistry, irrigation hardware, broad IPM theory, and non-vineyard horticulture to general.
- `nature-garden-roses` — specialist agent. No overlap (different crop, different management profile).
- `recreation-cycling-maintenance`, `nature-pet-dog`, `social-relationships-romantic`, `psychology-developmental` — unrelated domains, no overlap.

## Bodies of knowledge surveyed

| Source | Type | Version / date | Jurisdiction or scope | Notes |
|---|---|---|---|---|
| Winkler & Amerine, *General Viticulture* (UC Press) | Foundational textbook | 1974 (revised) | California/global | The Winkler index / heat-summation classification. Aging but still in use. |
| Smart & Robinson, *Sunlight Into Wine* | Practitioner handbook | 1991 (Winetitles) | Global | Canopy management principles; "Smart scorecard" leaf-layer / shoot density targets. Foundational for canopy decisions. |
| Robinson, Harding & Vouillamoz, *Wine Grapes* | Ampelographic reference | 2012 (Allen Lane) | Global | ~1,368 variety entries; parentage, origin, synonymy. The canonical variety reference. |
| UC Davis Viticulture & Enology Extension (wineserver.ucdavis.edu) | Academic extension | Continuously updated | California-leaning, global relevance | Authoritative on rootstock, canopy, disease, deficit irrigation. Williams (water), Matthews (water/quality), Gubler (trunk disease/PM). |
| UC Statewide IPM Program — Grape Pest Management Guidelines (ipm.ucanr.edu) | Extension/regulatory | Continuously updated | California with general principles | Pest thresholds, FRAC code rotation, materials, REIs. Industry standard reference. |
| Cornell Cooperative Extension — Viticulture & Enology (cals.cornell.edu/viticulture-enology) | Academic extension | Continuously updated | Eastern US, cool/humid climate | GDC origin (Shaulis), hybrid varieties, humid-climate disease, cold-climate viticulture. |
| Australian Wine Research Institute (AWRI) | Industry research body | Continuously updated | Australia/global | Practical canopy management, irrigation, wine chemistry-vine linkage. |
| OIV — International Organisation of Vine and Wine (oiv.int) | Intergovernmental standards | Continuously updated | International | Standards on viticultural terminology, sensory descriptors, climate adaptation reports. |
| Pearson & Goheen, *Compendium of Grape Diseases* (APS Press) | Reference compendium | 1988, with revisions | Global | Disease diagnostics and management. Foundational. |
| Wilcox, Gubler & Uyemoto, *Compendium of Grape Diseases, Disorders, and Pests*, 2nd ed. | Reference compendium | 2015 (APS Press) | Global | Updated successor; current trunk-disease and Pierce's-disease chapters. |
| University of Minnesota Cold Hardy Grape Breeding | Variety release program | 1980s–present | Cold-climate North America | Marquette, Frontenac, La Crescent, Itasca releases. |
| Cornell Grape Breeding (Bruce Reisch et al.) | Variety release program | Continuously | Eastern US | Traminette, Noiret, Aromella, Arandell releases. |
| UC Davis Pierce's Disease–resistant breeding program (Andy Walker) | Variety release program | 2019–2024 releases | PD-affected regions | Camminare Noir, Paseante Noir, Errante Noir, Ambulo Blanc, Caminante Blanc — vinifera-quality with PD resistance. |
| eVineyard / Viticulture & Enology applied trade literature | Practitioner trade | Continuously updated | Global, applied | GDD calculation guides, irrigation scheduling, applied technique. |
| Lodi Winegrape Commission and other regional grower associations | Industry association | Continuously updated | Specific AVA/region | Regionally-tuned best practice; useful for hot-region adaptation. |
| Oregon State University Extension viticulture publications | Academic extension | Continuously updated | Pacific Northwest cool-climate | Rootstock vigor reports, cool-climate vinifera. |
| Iowa State Midwest Grape and Wine Industry Institute | Academic/industry | Continuously updated | Midwest US, hybrids | Hybrid viticulture, cold-climate, trunk-disease research. |

Theoretical/applied split: the field is heavily applied (extension publications dominate), but plant physiology (water relations, source/sink, hormonal control of fruit development, ABA stomatal regulation) and pathology (population genetics of *Erysiphe necator* resistance, *Xylella* epidemiology) provide the mechanistic base. The agent should reason from physiology and pathology when applied guidance is silent or contradictory across regions.

Jurisdictional/temporal caveats:

- Rootstock recommendations are pinned to current knowledge of phylloxera biotypes (post-AxR1 era). Future biotype emergence could shift recommendations.
- Pesticide active ingredients, FRAC codes, REIs, and label legality vary by jurisdiction and change with each regulatory cycle. The agent should defer to current labels and local PCAs for application decisions.
- AVA (American Viticultural Area), DOC/DOCG (Italy), AOC (France), DO (Spain) regulatory frameworks vary by country and update periodically — out of scope for this agent except as terroir framing.
- UC Davis PD-resistant variety releases are recent (2019–2024) and field performance data is still accumulating.

## Citations referenced in the agent body

- **Winkler index / GDD classification**: Winkler, A.J., Cook, J.A., Kliewer, W.M., Lider, L.A. *General Viticulture*, UC Press, 1974. https://en.wikipedia.org/wiki/Winkler_index — quick reference for region thresholds.
- **Huglin Index**: Huglin, P. (1978). "Nouveau mode d'évaluation des possibilités héliothermiques d'un milieu viticole." *Symposium International sur l'Écologie de la Vigne*.
- **Variety pedigrees and synonymy**: Robinson, J., Harding, J., Vouillamoz, J. *Wine Grapes*, Allen Lane, 2012.
- **Canopy management principles, Smart scorecard, leaf layer number targets**: Smart, R. & Robinson, M. *Sunlight Into Wine*, Winetitles, 1991. https://smartvit.com.au/product/sunlight-into-wine/
- **GDC origin and balanced pruning formula**: Shaulis, N., Amberg, H., Crowe, D. (1966). "Response of Concord grapes to light, exposure and Geneva Double Curtain training." *Proc. Am. Soc. Hort. Sci.* Cornell Cooperative Extension materials.
- **Rootstock characteristics (1103P, 110R, Riparia Gloire, vigor and soil tolerance)**: UC Davis FPS rootstock guide; https://wineserver.ucdavis.edu/. Double A Vineyards rootstock guide. Novavine rootstock chart. https://www.novavine.com/media/11790/Rootstock-Chart-.pdf
- **AxR1 phylloxera biotype B history**: Granett, J., Walker, M.A., Kocsis, L., Omer, A.D. (2001). "Biology and management of grape phylloxera." *Annual Review of Entomology* 46:387–412.
- **UC IPM Grape Pest Management Guidelines (powdery mildew, downy mildew, botrytis, FRAC rotation)**: https://ipm.ucanr.edu/agriculture/grape/
- **Gubler-Thomas powdery mildew risk model**: Gubler, W.D., Rademacher, M.R., Vasquez, S.J. (1999). "Control of powdery mildew using the UC Davis powdery mildew risk index." APSnet feature.
- **10:10:24 downy mildew rule**: Mills, W.D., LaPlante, A.A. (1951). "Diseases and insects in the orchard." Cornell Extension Bulletin 711.
- **Ontogenic resistance of berries to mildews**: Gadoury, D.M., Seem, R.C., Ficke, A., Wilcox, W.F. (2003). "Ontogenic resistance to powdery mildew in grape berries." *Phytopathology* 93:547–555.
- **Grapevine trunk disease management, double pruning, wound protectants**: Gubler, W.D., Rolshausen, P.E., Trouillas, F.P. et al. (2005–present). UC Davis trunk disease research. Mondello, V., et al. (2018). "Grapevine trunk diseases: A review of fifteen years of trials." *Plant Disease* https://apsjournals.apsnet.org/doi/full/10.1094/PDIS-04-17-0512-FE
- **Pruning wound susceptibility and protectants**: Sosnowski, M.R., Loschiavo, A.P., Wicks, T.J., Scott, E.S. (2013). "Evaluating treatments and spray application for the protection of grapevine pruning wounds." *Plant Disease* 97:1599–1604.
- **Pierce's disease and glassy-winged sharpshooter**: UC IPM Pierce's Disease guidelines https://ipm.ucanr.edu/agriculture/grape/pierces-disease/. Tumber, K.P., Alston, J.M., Fuller, K.B. (2014). "Pierce's disease costs California $104 million per year." *California Agriculture* 68:20–29.
- **UC Davis PD-resistant variety releases**: Walker, M.A. et al. (2019–2024) variety release announcements. https://wineserver.ucdavis.edu/
- **Deficit irrigation, RDI, pressure chamber methods**: Matthews, M.A., Anderson, M.M. (1988). "Fruit ripening in *Vitis vinifera* L.: Responses to seasonal water deficits." *Am. J. Enol. Vitic.* 39:313–320. Williams, L.E., Matthews, M.A. (1990). "Grapevine." In *Irrigation of Agricultural Crops*, ASA Monograph 30.
- **Petiole nitrogen and potassium targets**: Christensen, L.P. (2005). "Use of tissue analysis in viticulture." UC ANR Publication 3419.
- **Harvest chemistry targets (Brix, TA, pH, Brix:TA ratio)**: Amerine, M.A., Roessler, E.B. (1958). "Methods of determining field maturity of grapes." *Am. J. Enol. Vitic.* 9:37–40. OSU Extension EM 9583 "Preparing for harvest: Grape chemistry and prefermentation adjustments." Ohio State Ohioline HYG-1436 "Determining Grape Maturity and Fruit Sampling."
- **Phenolic ripeness sensory evaluation**: AWRI publications on berry sensory assessment. Iland, P., Bruer, N., Ewart, A., Markides, A., Sitters, J. (2000). *Techniques for Chemical Analysis and Quality Monitoring during Winemaking*.

## Design notes

Patterns from authoring this agent that may help future domain agents:

1. **Theoretical-applied split with regional dimensions.** Viticulture has a foundation in plant physiology, soil science, and pathology (universal) layered with regionally-specific applied knowledge (varieties, climate adaptation, regulated pesticides). The agent prompt explicitly names this so the model knows to reason from physiology when the applied literature runs out — and to ask for region first because the applied answer flips across climate. This pattern likely applies to other agricultural/horticultural domains.

2. **Downstream-domain explicit out-of-scope flag.** Viticulture stops at the harvest bin; winemaking (enology) begins there. I made this boundary explicit even though the peer agent (`nature-food-enology` or similar) does not yet exist. This lets a future enology agent be authored with a clean claim on the boundary and prevents this agent from drifting downstream. Pattern: **when a clear downstream domain is foreseeable but not yet authored, name it as out-of-scope explicitly.**

3. **Scale-axis tradeoff (hobby vs commercial).** Same biology, very different economics. Rather than authoring two agents, the prompt makes scale a context variable and asks the agent to explicitly state when it's relaxing rigor for hobby scale. The heuristic "for a 20-vine block I'd skip petiole testing; at 2 acres that flips" makes the scale-relaxation visible to the user. This pattern works for any domain where amateur and professional practice diverge on cost but share theory.

4. **Heuristic structure: conditional default + reason.** Heuristics in this prompt follow "If X, default to Y, because Z" with the cause embedded. This is more useful than rule-without-reason because it tells the agent when to revisit — when Z stops being true.

5. **Naming the regulated-professional handoff.** For decisions that cross into regulated pesticide application, AVA compliance, or business valuation, the agent is told to route the user to a credentialed professional (PCA, consulting viticulturist, enologist) rather than answer. This is analogous to "consult a lawyer/CPA" in legal/financial agents — worth standardizing across domains where regulatory or licensure boundaries exist.

6. **Frontmatter `description` density matters.** I packed several concrete example invocations into the description because the agent will be selected against many others — including a sibling general garden agent. The explicit out-of-scope statement at the end of the description ("Does NOT cover winemaking/enology") is selection guidance for the router, not just user-facing prose.
