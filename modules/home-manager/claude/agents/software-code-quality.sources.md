# Software Code Quality Agent — Sources

References that informed the heuristics in `software-code-quality.md`.

## Existing Agents & Skills

- [VoltAgent/awesome-claude-code-subagents — code-reviewer](https://github.com/VoltAgent/awesome-claude-code-subagents) — "code quality guardian" focused on reviewing code changes; referenced for coverage gaps and overlap with refactoring-specialist and legacy-modernizer agents in the 04. Quality & Security category.

## Frameworks & Standards

### Refactoring: Improving the Design of Existing Code (Fowler, 2nd ed., 2018)
- [Refactoring catalog — refactoring.com](https://refactoring.com/catalog/) — canonical online catalog of all refactorings from the second edition, used as the source for smell names and definitions (Feature Envy, Shotgun Surgery, Divergent Change, Data Clumps, Primitive Obsession, Temporary Field, Message Chains, Middle Man, Refused Bequest, Parallel Inheritance Hierarchies, Speculative Generality, Lazy Element, Dead Code, Global Data, Mutable Data, Flag Argument).
- [Martin Fowler — The Second Edition of "Refactoring"](https://martinfowler.com/articles/refactoring-2nd-ed.html) — notes on what changed from 1st to 2nd edition; used to confirm smell list is from the current edition.
- [Luzkan — Code Smells Catalog](https://luzkan.github.io/smells/) — comprehensive community-maintained catalog organized by category (Bloaters, Change Preventers, Couplers, Data Dealers, Dispensables, Lexical Abusers, Obfuscators, Object-Oriented Abusers); used to cross-check Fowler's list and fill in smell descriptions including Boolean Blindness, Clever Code, Obscured Intent, Tramp Data.

### A Philosophy of Software Design (Ousterhout, 2nd ed., 2021)
- [Amazon — A Philosophy of Software Design, 2nd Edition](https://www.amazon.com/Philosophy-Software-Design-2nd/dp/173210221X) — confirmed current edition is 2nd (2021), ISBN 9781732102217.
- [janmeppe.com — A Philosophy of Software Design](https://www.janmeppe.com/blog/a-philosophy-of-software-design-john-ousterhout/) — chapter-level summary used to extract: deep vs. shallow modules framing, information hiding vs. information leakage, pull complexity downward, temporal coupling, classitis, two strategies for complexity (eliminate vs. encapsulate).

### Cognitive Complexity (SonarSource, G. Ann Campbell)
- [SonarSource — Cognitive Complexity white paper](https://www.sonarsource.com/docs/CognitiveComplexity.pdf) — primary specification; PDF not machine-accessible but version April 5, 2021 confirmed from SonarSource landing page.
- [SonarSource — Cognitive Complexity resource page](https://www.sonarsource.com/resources/cognitive-complexity/) — describes the metric as a Sonar exclusive that "breaks from mathematical models" by combining cyclomatic precedents with human assessment.
- [Baeldung — Cognitive Complexity and Its Effect on the Code](https://www.baeldung.com/java-cognitive-complexity) — concrete examples of increment rules: +1 per control flow structure (if, else if, else, for, while, do-while, catch, switch, ternary, goto/break/continue-to-label), +1 per nesting level on top of the base increment. Default threshold: 15.
- [SonarSource eslint-plugin-sonarjs — cognitive-complexity rule](https://github.com/SonarSource/eslint-plugin-sonarjs/blob/master/docs/rules/cognitive-complexity.md) — confirms default threshold of 15 in the JavaScript linting implementation.
- [Medium — Clean Code: Cognitive Complexity by SonarQube](https://medium.com/@himanshuganglani/clean-code-cognitive-complexity-by-sonarqube-659d49a6837d) — additional worked examples of nesting penalty.

### Cyclomatic Complexity (McCabe, 1976)
- [McCabe — A Testing Methodology Using Cyclomatic Complexity](https://www.mccabe.com/pdf/mccabe-nist235r.pdf) — original McCabe recommendation of 10 as upper bound per function.
- [Klocwork — McCabe Cyclomatic Complexity](https://help.klocwork.com/2024/en-us/concepts/mccabecyclomaticcomplexity.htm) — contemporary tool documentation confirming threshold of 10 (acceptable) to 15 (with justification); used to calibrate the threshold guidance in the agent.
- [Wikipedia — Cyclomatic complexity](https://en.wikipedia.org/wiki/Cyclomatic_complexity) — structural definition: each branch predicate (`if`, `else if`, `for`, `while`, `case`, `catch`, `&&`, `||`) adds 1.

### Clean Code (Robert C. Martin, 2008)
- Referenced for: function length heuristics (~20 lines), single responsibility at function level, guard clauses, boolean flag parameters, naming-as-communication, output parameter anti-pattern, and the principle that function names must match observable behavior.

### SOLID, DRY, YAGNI, KISS
- [Scalastic — Principles of Software Development: SOLID, DRY, KISS](https://scalastic.io/en/solid-dry-kiss/) — used for practical framing of SOLID at the code level: SRP as "one reason to change," OCP as signal for speculative generality, LSP for Refused Bequest check, ISP for shallow interface detection, DIP for constructor injection check.
- [dev.to — Clean Code Essentials: YAGNI, KISS, DRY](https://dev.to/juniourrau/clean-code-essentials-yagni-kiss-and-dry-in-software-engineering-4i3j) — YAGNI framing ("abstraction for an imaginary future") and DRY framing (structural vs. conceptual duplication distinction).

## Design Doc Notes

The following patterns emerged during authoring that may be useful for future agent files:

**Persona framing beats expertise framing.** "You evaluate code by how much cognitive load it places on the next reader" shapes prioritization more usefully than "you are a Clean Code expert." The persona encodes the evaluation criterion, not just the domain. Future agents should start the persona with the primary evaluation question, not a credential.

**Specificity test is load-bearing.** The instruction "can the model identify this from reading code?" forces heuristics to be executable. Concept labels ("check naming") that fail the test should be rewritten as detectable patterns ("flag names that require reading the implementation to understand their purpose"). This should be a named principle in a design doc for agent authoring.

**Scope deferrals need two-way clarity.** It is not enough to say "defer security to the Security agent." The boundary needs to be described from both sides: what this agent covers that touches the adjacent domain (e.g., error message verbosity is here; injection vulnerabilities are Security). Ambiguous overlap is where agents double-count or miss issues.

**Task modes shape output format.** The four task modes (PR review, file/module review, refactoring assistance, smell identification) each have a different primary question and a different useful output shape. Collapsing them into one format produces outputs that are simultaneously too detailed for PR review and too shallow for refactoring guidance.

**Smell inventory vs. smell explanation.** For code smell checks, a flat inventory (smell + location + one sentence) is more actionable than a section-per-smell with paragraph explanations. The explanation belongs in the refactoring assistance mode, not the identification mode.
