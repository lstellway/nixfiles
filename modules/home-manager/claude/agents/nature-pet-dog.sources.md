# nature-pet-dog — Sources

Authoring date: 2026-05-17. Companion to `nature-pet-dog.md`.

This domain agent consults on raising a dog as a companion animal across the lifespan. Where the agent encounters medical diagnosis, prescription, or behavior emergencies (bite history, sudden behavior change), it routes the user to a licensed veterinarian or a board-certified veterinary behaviorist rather than answering definitively. The sources below underwrite the agent's claims; the agent embeds inline citation pointers (AAHA 2022, AVSAB 2021, AAFCO, CAPC, WSAVA, etc.) that resolve here.

## Step 1 — Existing agents and skills consulted

- **`~/.claude/agents/` and `/Users/logan/go/src/github.com/lstellway/nixfiles/modules/home-manager/claude/agents/`** — surveyed. No existing pet, dog, animal, veterinary, or biology agent. No prior art to pattern off within the repo for the `nature-` prefix. The existing software-* and technology-* agents follow a documentation-fetch convention that is appropriate for software-library agents but not for a body-of-knowledge domain like this one; the agent uses the agent-domain skill's consultation-first structure rather than the technology-agent template.
- **VoltAgent `awesome-claude-code-subagents`** (https://github.com/VoltAgent/awesome-claude-code-subagents) — checked via WebFetch. The catalog covers software development, DevOps, data, and business categories; no pet, dog, veterinary, or animal-care agents exist. The only tangentially relevant entries (`game-developer`, `healthcare-admin`) are not in scope. **Nothing adopted; used purely as a scope sanity check.**
- **`/Users/logan/.claude/skills/agent-domain/SKILL.md`** — the authoring spec. Steps 1–9 followed.

## Step 2 — Bodies of knowledge surveyed

| Source | Type | Version / date | Jurisdiction or scope | Notes |
|---|---|---|---|---|
| AAHA Canine Vaccination Guidelines | Professional association practice guideline | 2022, updated 2024 | U.S. companion-animal practice (widely adopted internationally) | Core/non-core/risk-based vaccine framework. 2024 update moved leptospirosis to core. |
| AAHA Canine Life Stage Guidelines | Professional association practice guideline | 2019 | U.S. companion-animal practice | Five life stages (puppy / young adult / mature adult / senior / end-of-life); exam-frequency cadence and per-stage focus areas. |
| AAHA Dental Care Guidelines for Dogs and Cats | Professional association practice guideline | 2019 | U.S. companion-animal practice | Defines COHAT/COPAT standard, rejects non-anesthetic dentistry. |
| AAHA Weight Management / BCS chart | Professional association resource | n.d. (post-2014) | U.S. companion-animal practice | Cross-walk between 5- and 9-point BCS. |
| AAFCO Dog Food Nutrient Profiles | Model regulation (industry standard adopted by states) | Current; profile revisions tracked annually by AAFCO Pet Food Committee | U.S. (basis of state pet-food law) | Two profiles: Growth & Reproduction; Adult Maintenance. "All Life Stages" and large-breed-puppy-specific calcium ceilings. |
| WSAVA Global Nutrition Guidelines / nutritional toolkit | International veterinary association consensus | 2011, with continuing toolkit updates | International | Manufacturer-evaluation question set; 9-point BCS chart; muscle-condition score. |
| WSAVA Body Condition Score (Dog) | Standardized assessment tool | 2013 chart, updated 2020 / 2025 | International | 9-point BCS; ideal 4–5/9. |
| CAPC Guidelines (Companion Animal Parasite Council) | Professional association guideline | Continuously updated | North America (primary focus) | Year-round broad-spectrum parasite prevention; heartworm screening cadence; tick-borne disease testing in endemic regions. |
| AVMA Guidelines for the Euthanasia of Animals | Professional association practice guideline | 2020 edition (current) | U.S. | Technical standards for euthanasia methods. |
| AVMA position on raw / unprocessed pet food | Professional association position | 2012, reaffirmed | U.S. | Discourages raw because of public-health (zoonotic) risk. |
| AVSAB Position Statement on Puppy Socialization | Professional association position statement | 2008 | U.S. (widely cited internationally) | Behavioral risk of under-socialization > infectious risk of careful early exposure; foundational to "socialize before vaccine series complete." |
| AVSAB Position Statement on Humane Dog Training | Professional association position statement | 2021 | U.S. | Reward-based methods only; "no role for aversive training". |
| AVSAB Position Statement on the Use of Punishment | Professional association position statement | 2007 | U.S. | Earlier statement on the harms of P+. |
| OFA / CHIC (Orthopedic Foundation for Animals; Canine Health Information Center) | Independent health registry | Continuously updated | U.S.-centered, but submissions accepted internationally | Hip/elbow grading; breed-specific CHIC panels published by parent clubs. |
| CCPDT (Certification Council for Professional Dog Trainers) | Certifying body for trainers/behavior consultants | Founded 2001 | International (English-language) | CPDT-KA, CBCC-KA credentials; enforces LIMA. |
| IAABC (International Association of Animal Behavior Consultants) | Certifying body for behavior consultants | Founded ~2004 | International | CDBC (Certified Dog Behavior Consultant); LIMA-aligned. |
| ACVB / DACVB (American College of Veterinary Behaviorists) | Veterinary specialty board | n/a | U.S. (specialty board recognized by AVMA) | Defines the DACVB credential; the apex referral for behavior + behavior pharmacology. |
| Scott & Fuller, *Genetics and the Social Behavior of the Dog* | Foundational text | 1965 (still cited) | Theoretical / international | The Bar Harbor studies; origin of the canonical socialization-period framing. |
| Serpell ed., *The Domestic Dog: Its Evolution, Behaviour and Interactions with People* | Edited academic volume | 2nd ed. 2017 (CUP) | International | Standard reference for dog cognition, behavior, welfare. |
| Bradshaw, *Dog Sense* / *In Defence of Dogs* | Trade synthesis of academic work | 2011 | International | Accessible synthesis; debunks dominance theory. |
| Mills (Daniel) et al., *Journal of Veterinary Behavior* output | Peer-reviewed literature | Ongoing | International | Companion animal welfare science; affective state assessment. |
| Karen Pryor, *Don't Shoot the Dog* | Foundational trade book | 1984 (rev. 1999) | n/a | Operant conditioning applied to training; founding text of marker training. |
| Jean Donaldson, *The Culture Clash*; *Mine!* | Trade / practitioner book | 1996; 2002 | n/a | Behaviorist-style training framework; resource-guarding protocol. |
| Patricia McConnell, *The Other End of the Leash*; *For the Love of a Dog* | Trade / academic | 2002; 2007 | n/a | Body-language reading and human-dog communication. |
| Ian Dunbar (puppy curriculum and Sirius Puppy Training) | Practitioner | 1980s-onward | n/a | "100 people by 12 weeks" socialization target; early puppy-class movement. |
| Malena DeMartini-Price, *Treating Separation Anxiety in Dogs* (2014); *Separation Anxiety in Dogs: Next Generation Treatment Protocols and Practices* (2020) | Practitioner book | 2014, 2020 | n/a | Standard-of-care protocol for separation anxiety; CSAT credential program. |
| Leslie McDevitt, *Control Unleashed* (multiple editions) | Practitioner book | 2007–present | n/a | LAT/look-at-that; pattern games for reactive and over-aroused dogs. |
| Grisha Stewart, *Behavior Adjustment Training 2.0* | Practitioner book | 2016 | n/a | BAT for reactivity. |
| Hiby, Rooney & Bradshaw 2004; Herron, Shofer & Reisner 2009; Cooper et al. 2014 (Defra-funded e-collar study); Ziv 2017 review; China, Mills & Cooper 2020 | Peer-reviewed studies | 2004–2020 | International | Empirical basis for AVSAB 2021; consistent finding that aversive methods correlate with higher fear/aggression with no efficacy advantage. |
| Hart et al., UC Davis breed-specific neutering analyses | Peer-reviewed studies | 2013–2020 series | U.S. data, international applicability | Breed-by-breed associations between gonadectomy timing and joint disease / certain cancers. |
| Morrill et al., "Ancestry-inclusive dog genomics challenges popular breed stereotypes" | Peer-reviewed study, *Science* | 2022 | International | Behavioral variation poorly predicted by breed (~9%). |
| Kealy et al., "Effects of diet restriction on life span and age-related changes in dogs" (Purina lifetime study) | Peer-reviewed study, JAVMA | 2002 | n/a | Lean-fed Labradors lived ~1.8 years longer. |
| FDA, Investigation into Potential Link between Certain Diets and Canine Dilated Cardiomyopathy | Regulatory investigation | 2018 onward; FDA paused public updates Dec 2022 | U.S. | The BEG-diet/DCM open question. No established causal mechanism; signal persists. |
| Mellor et al., Five Domains Model (2020 update) | Academic welfare framework | 2020 | International | Inputs (nutrition/environment/health/behavior) → resulting Mental State. |
| Shepherd, "Ladder of Aggression" (in BSAVA Manual of Canine and Feline Behavioural Medicine) | Practitioner-academic | 2009 | International | Continuum from subtle to overt aggression; basis of "do not punish the growl." |
| Villalobos, HHHHHMM Quality-of-Life Scale | Veterinarian-authored practitioner tool | 2004 (Pawspice), widely adopted | International | End-of-life decision framework. |
| AKC, UKC, FCI breed standards | Breed-registry documents | Continuously revised | International (breed-specific) | Descriptive of conformation and an idealized temperament — not predictive of an individual dog's behavior. The agent uses these for "what is this breed bred to do" framing and explicitly rejects them as predictions for any specific dog. |

**Jurisdictional / temporal caveats:**

- **Rabies schedule** is governed by state and municipal law, not AAHA. The agent defers schedule specifics to the local vet.
- **AAHA / AVSAB / CAPC / WSAVA** are U.S.- and English-language-centered; non-U.S. users may have parallel national bodies (BSAVA in the UK, FECAVA in continental Europe, etc.). The agent surfaces this when the user signals a non-U.S. context.
- **AAHA Canine Vaccination Guidelines 2022 (updated 2024)** — the leptospirosis-as-core move is **2024**. The agent's claim is pinned to that update.
- **FDA DCM investigation** — public updates paused December 2022. The honest current state is "open question, no causal mechanism established, signal in BEG diets, default away absent indication." Update if FDA resumes publication or the cardiology community converges on a new position.
- **Hart et al. spay/neuter timing series** — breed-by-breed, accumulating. The agent's recommendation that this is "genuinely individualized" reflects the current state; do not collapse to a single rule.
- **Morrill et al. 2022** — the 9% breed-explained-variance figure applies to the behavioral traits sampled (across a citizen-science dataset). The principle ("breed predicts category, not individual") is robust; the specific figure may be revised in future replications.

## Step 3 — Distillation notes

Knowledge sections in the agent map to these knowledge clusters:

- **Acquisition** — breeder vs. rescue decision, health-screening registries (OFA/CHIC), Morrill 2022 epistemic check on breed-as-predictor.
- **Developmental windows** — Scott & Fuller through AVSAB 2008.
- **Training fundamentals** — four-quadrant operant model, LIMA hierarchy, the AVSAB 2021 evidence summary.
- **Common training tasks and behavior problems** — practitioner protocols (Pryor, Donaldson, McConnell, Dunbar, McDevitt, Stewart, DeMartini-Price).
- **Nutrition** — AAFCO substantiation hierarchy, WSAVA manufacturer questions, large-breed-puppy calcium, BEG/DCM open question, raw-feeding risk.
- **Body condition** — WSAVA 9-point BCS, Kealy 2002.
- **Preventive health** — AAHA 2022/2024 (vaccines), CAPC (parasites), AAHA 2019 (dental).
- **Spay/neuter** — Hart et al. breed-specific evidence.
- **Senior care & end-of-life** — AAHA 2019 Life Stage, Villalobos HHHHHMM, AVMA Euthanasia Guidelines 2020.
- **Body language & welfare** — Shepherd's Ladder, Mellor Five Domains.
- **Enrichment** — Markowitz five-category framework adapted to companion dogs.

## Step 4 — Scope boundary notes

The clear safety floor: **medical and behavioral-emergency questions defer**. The agent is built around the surface-then-defer pattern — it names what a symptom or behavior could indicate, gives an urgency band, and routes. It does not work diagnostic problems and it does not advise on dosing, prescription, or active bite-history management.

Anticipated peer agents the boundary points toward:

- **`health-veterinary-clinical`** (hypothetical, future) — diagnostic depth, pharmacology, surgery. The agent defers and names a "licensed veterinarian (DVM/VMD)" when this peer does not exist.
- **`behavior-veterinary` / DACVB referral** — board-certified veterinary behaviorist. Always named explicitly, since the credentialing distinction (DACVB ≠ "behaviorist" used loosely) materially affects what a user gets.
- **Credentialed trainer/consultant referrals** — CCPDT (CPDT-KA, CBCC-KA), IAABC (CDBC) named so the user can recognize the credentials when searching locally.
- **`social-relationships-romantic`, `psychology-developmental`** — confirmed no overlap.
- **Sibling batch agents (`recreation-cycling-maintenance`, `nature-garden-general`, `nature-garden-roses`, `nature-garden-viticulture`)** — no overlap. Note this agent uses the `nature-pet-` sub-prefix; future `nature-pet-cat`, `nature-pet-bird`, etc., would slot in alongside.

## Step 5 — Consultation modes

The agent's Output Format covers:

- **Knowledge question** — direct answer, named distinction, source pointer (AAHA / AVSAB / AAFCO / etc.).
- **Tradeoff / decision** — recommendation + considerations + flip conditions + open questions. Used for the canonical hard calls (puppy vs. adult; breeder vs. rescue; spay timing; what to feed; one vet's advice vs. another).
- **Design / planning help** — concrete plans with realistic failure modes flagged.
- **Behavior or symptom triage** — explicit urgency band and a routing recommendation, not a diagnosis.

The agent does not have a generic "artifact review" mode because the domain rarely produces artifacts a layperson would submit for review (a feeding plan or training plan is the closest, and is handled under design/planning). If the user pastes a vet's recommendation or a trainer's plan, the agent can interpret it but the deference to the credentialed source is preserved.

## Step 6–7 — Author and review

Three test invocations traced:

1. **Knowledge question**: "What's the difference between core and risk-based vaccines for dogs?" → direct answer, names DAP / rabies / lepto as core (per AAHA 2022/2024), names Bordetella/Lyme/influenza as risk-based, points to the AAHA 2022 (2024-updated) guideline, notes rabies-schedule-is-state-law. Source pointer present. Does not drift into review.
2. **Tradeoff / decision**: "Should I get a puppy from a breeder or adopt from a rescue?" → recommendation framed not as a single answer but as "depends on your tolerance for unknowns, breed-specific needs, and the ethics-of-the-source question", with considerations on each side, conditions that flip it, and explicit open questions about the user's lifestyle. Real recommendation, not a hedge.
3. **Design request**: "Help me make a socialization plan for my 9-week-old puppy" → candidate plan (volume of exposures, types of stimuli, threshold management, what to do if puppy freezes, when to involve a puppy class), why these choices (AVSAB 2008; Dunbar's "100 people"; primary socialization window biology), where it fails (single bad scare; over-exposure / flooding), decision points (signs of fear that warrant slowing down or pulling back).

Persona check: the persona is a stance ("you treat every question as a welfare problem first and a behavior problem second… you hold the line on evidence… you do not treat aversive-versus-positive as a balanced two-sides debate") — not an expertise claim. Heuristics check: each heuristic is a conditional with a *because* embedded (often implicit). Deferrals are bidirectional in spirit (the agent will look medical-bound questions in the eye, then route them; a future medical agent would route back here for husbandry and training depth).

## Step 9 — Design Notes

Patterns that emerged that may help other domain agents:

- **Evidence-contested methods need a stance, not a hedge.** In a domain like dog training where the evidence is asymmetric (reward-based methods are well-supported; aversive methods are documented to harm) but the popular discourse treats it as a balanced two-sides debate, the agent must take the evidence-aligned stance and say plainly where the data sit, while still respecting user autonomy on their own dog. The agent encodes this in both the persona and the AVSAB 2021 citation, and in a heuristic ("if a method requires the dog to be afraid of you to work, it's the wrong method"). The same pattern likely applies in other domains with similar asymmetries (e.g., evidence-based parenting, evidence-based medicine when popular practice diverges). The pattern: **cite the body of evidence in the agent body, encode the stance in a heuristic, and explicitly call out that the agent is not treating the question as evenly weighted.**

- **Safety floor as routing, not refusal.** The agent does not refuse medical and behavior-emergency questions. It engages — names what the symptom or behavior could indicate, places urgency, and routes to the credentialed authority. Refusing leaves the user without orientation; routing gives them orientation and the correct next step. Useful for any domain with adjacent licensed-professional terrain (medical, legal, financial, mental-health). The agent surfaces *the right credential's name* (DACVB, IAABC-CDBC, CCPDT-CBCC-KA) so the user knows what to look for locally — a generic "see a behaviorist" is unhelpful because "behaviorist" is loosely used.

- **Descriptive-vs-predictive disclaimer for "standards" documents.** Breed standards are commonly mistaken as predictive of an individual's behavior. The agent makes this disclaimer explicit and grounds it in Morrill et al. 2022. Any domain that has "standards" or "profiles" that sound predictive but are actually descriptive (job-description-style documents, personality-type frameworks, etc.) benefits from the same explicit treatment.

- **"Surface-then-defer" applied to bodily/medical context.** The pattern from the skill spec is most often illustrated with peer agents. Here, the deferral target is mostly a real-world licensed professional, not another agent. The pattern still works — it gives the user orientation and the next step. Worth noting as a generalization for any domain bordering a regulated profession.

- **Tradeoff sections that name the disputed empirical state.** Spay/neuter timing, raw feeding, grain-free diets — three places where users will encounter strong opinions both ways. Rather than picking a winner where the evidence does not support a single answer, the agent explicitly names *where the weight of evidence currently sits* and *what would change the answer*. Useful pattern for other domains with active scientific or community disputes.

- **Heuristics paired with welfare framing**, not just behavioral framing. Several heuristics are framed as welfare imperatives ("the single most impactful welfare intervention available is calorie reduction") rather than as training mechanics. This grounds the heuristics in the agent's stated frame (welfare first, behavior second) and makes their priority transparent. Any domain that has both a "how to do the thing" layer and a "who/what is being affected by the thing" layer benefits from this dual framing.
