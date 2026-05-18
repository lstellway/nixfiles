# Social Relationships — Romantic Partnership Agent: Sources

Companion to `social-relationships-romantic.md`. Documents the bodies of knowledge surveyed, what was used, what was reviewed but not adopted, and the value-laden / contested-evidence challenges this domain poses for agent authoring.

---

## Existing Agents & Skills Reviewed

Searched [VoltAgent/awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) (May 2026) — 131+ agents across software, business, and research categories. **No agents in this collection cover relationships, dating, couples, romantic partnership, family dynamics, therapy, counseling, psychology, or emotional support.** This is a greenfield domain for the public catalog.

Searched `~/.claude/agents/` and the repo's `modules/home-manager/claude/agents/` directory (May 2026) — existing agents are software/technology only (`software-*`, `technology-*`). No prior social/relationships/psychology agents. This batch is the first non-software domain set in this user's library.

No prior reference implementations to mirror, so the authoring leaned on: (a) the `agent-domain` skill's structural template, and (b) one existing software agent (`software-user-experience.md`) for stylistic reference on persona-as-stance and bidirectional scope deferrals.

---

## Bodies of Knowledge Surveyed

This domain draws from peer-reviewed psychological research, clinical practitioner traditions, sociology of the family, and popular self-help. The agent qualifies claims by their evidence type — the table below distinguishes those types.

| Source | Type | Version / Date | Scope | Notes / Use in Agent |
|---|---|---|---|---|
| Bowlby, *Attachment and Loss* (Vol. 1–3, 1969/1973/1980) | Foundational theory | Mid-20th c. | Attachment theory origin | Cited as origin; depth in `psychology-developmental` |
| Ainsworth et al., *Patterns of Attachment* (1978) — Strange Situation | Foundational empirical | 1978 | Infant attachment | Cited as origin; depth in `psychology-developmental` |
| Hazan & Shaver, "Romantic love conceptualized as an attachment process" (*J. Pers. Soc. Psychol.*, 1987) | Empirical paper | 1987 | Adult romantic attachment extension | Cited as seminal extension to adult pair-bonds |
| Fraley & Shaver, "Adult Romantic Attachment: Theoretical Developments, Emerging Controversies, and Unanswered Questions" (*Review of General Psychology*, 2000) | Review | 2000 | Theoretical development | Used for taxonomy of styles and unresolved questions |
| Mikulincer & Shaver, *Attachment in Adulthood: Structure, Dynamics, and Change* (Guilford, 2nd ed. 2016) | Empirical synthesis monograph | 2016 (2nd ed.) | Comprehensive adult attachment | Primary anchor for adult attachment knowledge section; hyperactivation/deactivation strategies; ECR scale |
| Fraley (2002) meta-analysis on attachment stability | Meta-analysis | 2002 | Lifespan stability | Cited for moderate longitudinal stability |
| Gottman & Levenson, multiple papers from "Love Lab" / UW | Empirical observational | 1970s–2010s, ongoing | Marital interaction | Four Horsemen, 5:1 ratio, repair attempts, predictors of divorce |
| Gottman Institute — "The Four Horsemen" page | Practitioner / institutional | Updated through 2020s | Public-facing summary | Vocabulary anchoring; URL cited in agent |
| Gottman & Silver, *The Seven Principles for Making Marriage Work* (1999, updated 2015) | Trade book by primary researcher | 1999/2015 | Practical synthesis | Sound Relationship House model, antidotes |
| Johnson, *Hold Me Tight* (2008); EFT clinical literature | Clinical framework + outcome research | 2008 book; EFT research since 1980s | Emotionally Focused Therapy for couples | Cited as clinical framework with empirical outcome support; multiple meta-analyses including Beasley & Ager 2019 |
| Wiebe & Johnson, "A Review of the Research in Emotionally Focused Therapy for Couples" (*Family Process*, 2016) | Review | 2016 | EFT outcomes | Cited as EFT's empirical base |
| Beasley & Ager, systematic review of EFT effectiveness (2019) | Systematic review | 2019 | EFT outcomes | Cited for "significantly improves relationship satisfaction, sustained 2y" |
| Tatkin, *Wired for Love* (2011); PACT Institute materials | Clinical framework | 2011 onward | Psychobiological Approach to Couple Therapy | Cited as clinical framework; not presented as research |
| Real, *I Don't Want to Talk About It* (1997); *How Can I Get Through to You* (2002); *Us* (2022) | Clinical framework | 1997–2022 | Relational Life Therapy, men, patriarchy, shame | Cited as one influential clinician's framework; named explicitly when used |
| Perel, *Mating in Captivity* (2006); *The State of Affairs* (2017) | Clinical framework / cultural analysis | 2006 / 2017 | Desire-security paradox; infidelity | Cited as Perel's framework; critique noted (grief minimization risk) |
| Basson, "The female sexual response: a different model" (*J. Sex Marital Ther.*, 2000) | Clinical model | 2000 | Responsive desire | Used for spontaneous-vs-responsive desire distinction |
| Rosenberg, *Nonviolent Communication: A Language of Life* (1st ed. 1999; 3rd ed. 2015) | Practitioner framework | 1999/2015 | NVC structure (OFNR) | Cited as practitioner scaffold, not research |
| Conley, Ziegler, Moors, Matsick & Valentine, "A Critical Examination of Popular Assumptions About the Benefits and Outcomes of Monogamous Relationships" (*Personality and Social Psychology Review*, 2013) | Empirical review | 2013 | Monogamy assumptions | Cited for "evidence for benefits of monogamy is lacking" finding |
| Conley, Matsick, Moors & Ziegler, "Investigation of Consensually Nonmonogamous Relationships" (*Perspectives on Psychological Science*, 2017) | Empirical | 2017 | CNM relationship quality | Cited for satisfaction/trust/commitment parity |
| Moors et al., meta-analyses of CNM relationship outcomes | Meta-analysis | 2024 | CNM vs monogamy | Cited as "no average difference" finding (n ~11,650 CNM vs ~20,114 monogamous) |
| Stanley, Rhoades & Markman — sliding vs. deciding literature on cohabitation | Empirical | 2000s–2010s | Cohabitation effect | Cited as nuance on cohabitation effect |
| Doss, Rhoades, Stanley & Markman, "The Effect of the Transition to Parenthood on Relationship Quality: An Eight-Year Prospective Study" (*J. Pers. Soc. Psychol.*, 2009) | Longitudinal | 2009 | Transition to parenthood | Cited for satisfaction-dip pattern |
| Lavner & colleagues — newlywed satisfaction trajectories, premarital parenthood | Longitudinal | 2010s | Newlywed couples, low-income samples | Cited for VSA model and premarital parenthood findings |
| Carlson & colleagues — Council on Contemporary Families briefing papers on egalitarian housework and satisfaction | Empirical briefs | 2018–2022 | Dual-earner US couples | Cited for shared routine housework / satisfaction link |
| Council on Contemporary Families (https://thesocietypages.org/ccf/) | Research-distribution org | Ongoing | US families | Cited as source organization |
| Power and Control Wheel (Duluth Model, Domestic Abuse Intervention Programs) | Clinical framework | 1984; ongoing use | IPV identification | Used in safety-deferral heuristic; cited by name |
| National Domestic Violence Hotline (thehotline.org, 1-800-799-7233) | Service / hotline | Current | US | Referred for IPV deferrals |
| 988 Suicide & Crisis Lifeline (US) | Service / hotline | Current (988 since 2022) | US | Referred for suicidality deferrals |
| Emery — longitudinal randomized study of court-based custody mediation, 12-year follow-up | Empirical longitudinal | 2001 study; 2010s follow-up | Divorce and children | Cited for mediation vs. litigation outcomes |
| Amato — divorce and children meta-analyses | Meta-analyses | 1990s–2010s | Divorce effects on children | Used for "post-divorce conflict mediates, not divorce per se" |
| Fisher — *Why We Love* (2004); neuroimaging work on romantic love | Empirical neuroscience + popular synthesis | 2000s | Lust / attraction / attachment three-systems model | Cited as one neurobiology lens; not centered |
| *Journal of Marriage and Family*, *Journal of Family Psychology* | Journals | Ongoing | Field-level reference | Named as primary journals |

---

## Citations Referenced in Agent Body — Full References

- **Bowlby, J.** (1969/1982). *Attachment and Loss, Vol. 1: Attachment*. Basic Books. [Cited as origin of attachment theory.]
- **Ainsworth, M. D. S., Blehar, M., Waters, E., & Wall, S.** (1978). *Patterns of Attachment: A Psychological Study of the Strange Situation*. Erlbaum.
- **Hazan, C., & Shaver, P.** (1987). Romantic love conceptualized as an attachment process. *Journal of Personality and Social Psychology, 52*(3), 511–524.
- **Fraley, R. C., & Shaver, P. R.** (2000). Adult romantic attachment: Theoretical developments, emerging controversies, and unanswered questions. *Review of General Psychology, 4*(2), 132–154.
- **Mikulincer, M., & Shaver, P. R.** (2016). *Attachment in Adulthood: Structure, Dynamics, and Change* (2nd ed.). Guilford Press.
- **Gottman, J. M., & Levenson, R. W.** Multiple papers, including: Gottman, J. M., & Levenson, R. W. (2000). The timing of divorce: Predicting when a couple will divorce over a 14-year period. *Journal of Marriage and the Family, 62*(3), 737–745.
- **Gottman Institute.** "The Four Horsemen: Criticism, Contempt, Defensiveness, and Stonewalling." https://www.gottman.com/blog/the-four-horsemen-recognizing-criticism-contempt-defensiveness-and-stonewalling/ (verified May 2026).
- **Gottman, J. M., & Silver, N.** (1999/2015). *The Seven Principles for Making Marriage Work*. Harmony Books.
- **Johnson, S. M.** (2008). *Hold Me Tight: Seven Conversations for a Lifetime of Love*. Little, Brown.
- **Wiebe, S. A., & Johnson, S. M.** (2016). A Review of the Research in Emotionally Focused Therapy for Couples. *Family Process, 55*(3), 390–407.
- **Beasley, C. C., & Ager, R.** (2019). Emotionally Focused Couples Therapy: A Systematic Review of Its Effectiveness over the Past 19 Years. *Journal of Evidence-Based Social Work*.
- **Tatkin, S.** (2011). *Wired for Love*. New Harbinger. PACT Institute: https://www.thepactinstitute.com/
- **Real, T.** (1997). *I Don't Want to Talk About It*. Scribner. — (2002). *How Can I Get Through to You*. Scribner. — (2022). *Us: Getting Past You and Me to Build a More Loving Relationship*. Goop Press.
- **Perel, E.** (2006). *Mating in Captivity: Unlocking Erotic Intelligence*. Harper. — (2017). *The State of Affairs: Rethinking Infidelity*. Harper.
- **Basson, R.** (2000). The female sexual response: A different model. *Journal of Sex & Marital Therapy, 26*(1), 51–65.
- **Rosenberg, M. B.** (2015). *Nonviolent Communication: A Language of Life* (3rd ed.). PuddleDancer Press.
- **Conley, T. D., Ziegler, A., Moors, A. C., Matsick, J. L., & Valentine, B.** (2013). A critical examination of popular assumptions about the benefits and outcomes of monogamous relationships. *Personality and Social Psychology Review, 17*(2), 124–141.
- **Conley, T. D., Matsick, J. L., Moors, A. C., & Ziegler, A.** (2017). Investigation of Consensually Nonmonogamous Relationships: Theories, Methods, and New Directions. *Perspectives on Psychological Science, 12*(2), 205–232.
- **Moors, A. C., et al.** Meta-analyses of CNM outcomes (2024). [Aggregate finding cited; specific paper citations to be verified at use-time.]
- **Stanley, S. M., Rhoades, G. K., & Markman, H. J.** (2006). Sliding versus deciding: Inertia and the premarital cohabitation effect. *Family Relations, 55*, 499–509.
- **Doss, B. D., Rhoades, G. K., Stanley, S. M., & Markman, H. J.** (2009). The effect of the transition to parenthood on relationship quality: An eight-year prospective study. *Journal of Personality and Social Psychology, 96*(3), 601–619.
- **Carlson, D. L.** Council on Contemporary Families briefing papers on housework and relationship satisfaction. https://thesocietypages.org/ccf/
- **Domestic Abuse Intervention Programs (Duluth Model).** Power and Control Wheel: https://www.theduluthmodel.org/wheels/
- **National Domestic Violence Hotline.** https://www.thehotline.org/ — 1-800-799-7233
- **988 Suicide & Crisis Lifeline.** https://988lifeline.org/ — dial 988 (US)
- **Emery, R. E.** Multiple papers; e.g., Emery, R. E., Laumann-Billings, L., Waldron, M. C., Sbarra, D. A., & Dillon, P. (2001). Child custody mediation and litigation: Custody, contact, and coparenting 12 years after initial dispute resolution. *Journal of Consulting and Clinical Psychology, 69*, 323–332.
- **Amato, P. R.** (2000, 2010). Multiple reviews on divorce and children's outcomes.
- **Fisher, H.** (2004). *Why We Love: The Nature and Chemistry of Romantic Love*. Holt.

---

## Reviewed but Not Adopted (or Used with Caveats)

- **Chapman, G., *The Five Love Languages* (1992; popular through present).** Reviewed; used in the agent only as an example of "popular self-help, not research-backed." Multiple empirical studies and recent reviews (including a 2023 *Current Directions in Psychological Science* analysis) find the empirical evidence does not support that matched love languages predict relationship outcomes. The agent explicitly names this caveat. The vocabulary remains useful as a conversation prompt; the theory does not have predictive support.
- **Pop evolutionary psychology of gender ("men are X, women are Y").** Reviewed; not adopted as a knowledge frame. The empirical literature on sex differences in relationships is real but heavily moderated by culture and selection; popular distillations overclaim. The agent avoids gender-essentialist framing.
- **Rules-based dating systems (e.g., *The Rules*, "alpha/beta" frameworks, dating-app gurus).** Reviewed; rejected. Not grounded in empirical literature; tend to be prescriptive in ways that conflict with the agent's frame-transparent, value-neutral stance.
- **Imago Therapy (Hendrix).** Reviewed; mentioned only as one of several clinician frameworks. Not centered; less empirical support than EFT or Gottman.
- **The PREP / SYMBIS / Marriage Encounter programs.** Reviewed as practitioner resources; not centered. PREP has some empirical support (Markman/Stanley) and is incorporated implicitly through the sliding-vs-deciding citation.
- **Polysecure (Jessica Fern, 2020).** Reviewed; an applied attachment-in-CNM framework. Cited implicitly through the CNM section; not named individually to avoid suggesting it is the canonical CNM source.
- **TikTok / Instagram "relationship coaches" and pop-attachment-style content.** Reviewed for vocabulary in current use; not adopted as authority. Popular labels ("anxious", "avoidant", "narcissist") have proliferated in usage in ways that often misapply the technical concepts; the agent treats labels with mild suspicion as a heuristic.

---

## Jurisdictional & Temporal Caveats

- **Divorce law, child custody, mediation availability** vary by jurisdiction. The agent does not give legal advice and does not pretend to. When users ask about divorce mechanics, the agent's job is the relational and child-welfare dimensions; legal questions defer to attorneys.
- **Hotline numbers** (1-800-799-7233, 988) are US. International users may need different numbers — the agent should be aware and ask if needed.
- **Cultural and religious frames.** US secular-egalitarian defaults are explicit in the agent. Frame transparency is a core requirement: the agent names its frame and switches frames at the user's request.
- **LGBTQ+ relationships.** Most of the research base used (Gottman, attachment, EFT) was developed primarily on heterosexual samples, especially older studies. The Four Horsemen and attachment dynamics replicate broadly in same-sex couples; some specifics (e.g., gendered patterns around mental load, transition-to-parenthood dynamics) may map differently. The agent should be aware and qualify when needed.
- **CNM research** is younger and smaller than monogamy research; some findings rest on convenience samples. The agent should not overclaim the empirical equivalence finding even where it leans on it.
- **Date of knowledge cutoff for this agent**: May 2026. Sources subject to update.

---

## Design Notes

Patterns that emerged during authoring of this agent — particularly relevant for other soft-domain (value-laden, contested-evidence) agents in this batch and future.

### 1. The "three kinds of claim" structure for contested-evidence domains

The agent distinguishes four evidence types explicitly in its body: research finding / clinical framework / one author's framework / popular not-research-backed. This was load-bearing for this domain. Without it, the agent would conflate "Gottman's Four Horsemen are an empirical finding from longitudinal observation" with "Perel's eroticism paradox is one clinician's interpretive reframe" with "love languages is popular vocabulary without predictive support" — all of which are useful, but not interchangeable.

Pattern for other soft-domain agents: when survey reveals mixed evidence quality, the agent must teach the user to distinguish *what kind of claim* is being made, not just *what the claim is*. This belongs in a top-level Knowledge section, not buried in caveats. The agent should be able to say "this is a clinical framework, not a research finding" naturally and frequently.

### 2. Frame transparency as an explicit feature

For value-laden domains (relationships, religion, parenting, money), the agent has a frame whether or not it admits it. The agent here defaults to American secular-egalitarian, names this default explicitly in the Context section, and offers to reason from other frames (religious, monogamous-by-default, kink-affirming, CNM-affirming) at the user's request. This is more useful than feigning a view from nowhere and more honest than pretending the agent has no frame.

Pattern: every value-laden agent should name its default frame in Context, commit to switching frames on request, and refuse to argue users out of their values. The frame is a setting, not a hidden assumption.

### 3. The hard-deferral pattern for safety-critical adjacencies

This domain has a tier of concerns where consultation mode is itself harmful: intimate partner violence, coercive control, suicidality, untreated acute mental illness, addiction. For these, the agent does not "consult" — it names what it sees, refers out to a specific professional resource (hotline number, specialist), and stops the consultation. This is a stronger pattern than "surface-then-defer" (which is for cross-cutting concerns where consultation is still appropriate). It is a hard cutoff.

Pattern: any agent operating in a domain where bad consultation can produce harm needs a Hard Deferral tier explicitly carved out in Scope. The agent must name (a) the triggering patterns, (b) the specific resource to direct to, (c) the explicit instruction to stop the current consultation mode. Couples therapy being contraindicated for ongoing abuse is the model here — the agent should refuse to play "let's think about your relationship" when the operative question is safety planning.

### 4. The "thoughtful interlocutor not therapist" persona

The persona explicitly rejects the role the user might project onto it (therapist, advice-giver, partner-judge). The framing "you live in your relationship and I don't" stays as a stated commitment. The agent positions itself as a thinking partner — someone helpful in clarifying what the user already half-knows, not someone with authority over the relationship's outcome.

Pattern: for domains where users may project authority/expertise that the agent should not have (medical, legal, mental-health-adjacent, deeply personal), the persona should explicitly state what role the agent is *not* taking. Negative role-naming is more useful than positive role-naming alone.

### 5. The "don't take sides in absentia" heuristic

When a user describes their partner's behavior, the agent is hearing one side. Multiple heuristics in the body push back against the temptation to side-take ("your partner sounds awful") or assign blame ("they're the problem"). The discipline is to stay curious about the dynamic both partners are inside, while not dismissing the user's experience.

Pattern: for any agent fielding interpersonal questions, build in the discipline of remembering the absent party. Side-taking from limited evidence is the failure mode.

### 6. Label suspicion as a domain-specific heuristic

The proliferation of pop psychology vocabulary in social media (narcissist, avoidant, gaslighting, love-bombing, trauma-bond) is a real phenomenon and the agent encounters it regularly. The heuristic "treat the label with mild suspicion" without invalidating the user's experience is structurally important. The label may name a real pattern; it also flattens a person into a category.

Pattern: in any domain where popular vocabulary has outrun technical precision, the agent should hold both — engage with the user's framing without endorsing or contradicting the label, and redirect to the underlying pattern.

### 7. Sibling-agent boundary cues

The boundary with `psychology-developmental` had to be drawn with a usable cue, not just a topic split. "If the question is 'what does my partner's childhood explain about them as a person', that's developmental; if it's 'what does that mean for how we fight in this relationship', that's here." This cue-based boundary is more actionable than a topic-list-based boundary.

Pattern: bidirectional scope boundaries should include not just *what* each agent owns but a *cue for distinguishing borderline questions*. "How would a user phrase this differently in your domain vs. the peer's?" The cue is what makes the boundary usable in practice.

### 8. Empirical citation discipline in a soft domain

Even though the domain is value-laden and contested, the agent cites specific empirical findings (Gottman's 5:1 ratio, Conley et al. on CNM outcomes, Doss et al. on transition to parenthood, Emery on mediation outcomes) where the literature supports them. The discipline is to be empirically grounded *and* honest about where the literature thins out or doesn't exist. The agent's authority comes from this calibration, not from sounding confident.

Pattern: in soft domains, the temptation is to either fake hard-science certainty or retreat to vague advice. Both are failure modes. The discipline is fine-grained calibration: name what's well-evidenced, name what's clinical-consensus, name what's one-clinician's-view, name what's popular-but-unsupported.
