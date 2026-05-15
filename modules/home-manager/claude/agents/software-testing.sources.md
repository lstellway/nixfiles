# Sources — software-testing.md

## Primary References

### Test Pyramid
- **Martin Fowler, "The Practical Test Pyramid"** (martinfowler.com/articles/practical-test-pyramid.html)
  Used for: layer definitions (unit / integration / UI), the ice cream cone anti-pattern, test duplication across layers, and the principle that E2E tests should cover only critical user journeys.

### Test Doubles Taxonomy
- **Martin Fowler, "TestDouble"** (martinfowler.com/bliki/TestDouble.html)
  Used for: the canonical five-type taxonomy — Dummy, Stub, Spy, Mock, Fake — with Fowler's verbatim definitions as the authoritative source.

- **Martin Fowler, "Mocks Aren't Stubs"** (martinfowler.com/articles/mocksArentStubs.html)
  Used for: classical vs. mockist TDD, state verification vs. behavior verification, the coupling cost of mockist tests, and the refactoring resilience tradeoff.

### Unit Test Definitions
- **Martin Fowler, "UnitTest"** (martinfowler.com/bliki/UnitTest.html)
  Used for: the sociable vs. solitary unit test distinction and the principle that "unit" is team-defined.

### Integration Tests
- **Martin Fowler, "IntegrationTest"** (martinfowler.com/bliki/IntegrationTest.html)
  Used for: narrow vs. broad integration tests, the recommendation to separate them from the fast suite, and the serialization/deserialization boundary as a meaningful narrow integration test target.

### Coverage
- **Martin Fowler, "TestCoverage"** (martinfowler.com/bliki/TestCoverage.html)
  Used for: the "coverage as a diagnostic, not a target" framing, the coverage-as-mandate anti-pattern, and Brian Marick's observation that weak coverage in detectable ways implies weak coverage in undetectable ways. Fowler's expectation of upper 80s–90s coverage with thoughtful testing (but not 100%) informed the assessment guidance.

### Non-Determinism / Flakiness
- **Martin Fowler, "Eradicating Non-Determinism in Tests"** (martinfowler.com/articles/nonDeterminism.html)
  Used for: the five root causes of flaky tests (lack of isolation, async behavior, remote services, time dependencies, resource leaks) and the specific fixes for each (injectable clock abstraction, callback/polling over sleep, transaction rollback for isolation, strict resource pool limits).

### Contract Tests
- **Martin Fowler, "ContractTest"** (martinfowler.com/bliki/ContractTest.html)
  Used for: the definition of contract tests as verifiers that test doubles match real external service behavior, the external service's change cycle cadence, and the consumer-driven contracts recommendation.

- **Pact documentation, "How Pact Works"** (docs.pact.io/getting_started/how_pact_works)
  Used for: the consumer-provider-pact-file-verification workflow, the "consumer defines minimal interactions" model, and Pact's applicability to both synchronous HTTP and asynchronous message-based systems.

### Given-When-Then / Test Structure
- **Martin Fowler, "GivenWhenThen"** (martinfowler.com/bliki/GivenWhenThen.html)
  Used for: Given-When-Then structure as the test readability standard, its relationship to Arrange-Act-Assert, and the Four-Phase Test pattern (Setup, Exercise, Verify, Teardown).

### FIRST Principles
- **Jeff Langr & Tim Ottinger, "FIRST"** (agileinaflash.blogspot.com/2009/02/first.html)
  The canonical source for the FIRST acronym: Fast, Isolated, Repeatable, Self-validating, Timely. The specific violation checks in the agent were derived from this post. Originally introduced in Andy Hunt and Dave Thomas, "Pragmatic Unit Testing in Java with JUnit" (Pragmatic Bookshelf).

### Test Smells
- **Gregor Gaertner et al., testsmells.org — Test Smell Types** (testsmells.org/pages/testsmells.html)
  Used for: the catalog of named test smells. All smell names cited in the agent are from this catalog: Assertion Roulette, Conditional Test Logic, Duplicate Assert, Eager Test, Empty Test, Exception Handling, General Fixture, Lazy Test, Magic Number Test, Mystery Guest, Redundant Assertion, Redundant Print, Sensitive Equality, Sleepy Test, Unknown Test.
  
  Conceptual origin: **Gerard Meszaros, "xUnit Test Patterns: Refactoring Test Code"** (Addison-Wesley, 2007). Meszaros introduced the formal vocabulary of test smells, fixture patterns, and the test double taxonomy (the latter was later synthesized by Fowler). The testsmells.org catalog operationalizes Meszaros's work.

---

## Adjacent / Background References

- **Mike Cohn, "Succeeding with Agile" (Addison-Wesley, 2009)** — originator of the Test Pyramid metaphor. Fowler's practical-test-pyramid article is the more commonly cited and more operationally detailed treatment; Cohn is the conceptual source.

- **ISTQB Glossary (current edition: v4.0, 2023)** — provides standardized definitions for testing concepts. Not directly cited in agent heuristics because ISTQB terminology is more useful for certification alignment than for code-level execution. Concepts like equivalence partitioning, boundary value analysis, and decision table testing are implicit in the assertion quality and edge case guidance.

- **VoltAgent awesome-claude-code-subagents** (github.com/VoltAgent/awesome-claude-code-subagents) — surveyed for existing testing agent examples. No testing agent in that collection covers test strategy, test double taxonomy, or flaky test patterns at the level of specificity required here. The `qa-expert` and `test-automator` entries are automation-infrastructure focused rather than test quality / specification focused. No content from that repository was incorporated into the agent.

---

## Design Doc Notes

Patterns observed during this authoring process that would benefit future agent design documentation:

1. **"Would this catch a regression?" as the master heuristic.** Every testing sub-topic reduces to this question. The persona frame — "a test that passes but doesn't catch regressions is not a safety net" — is more generative than "you are an expert in testing frameworks." Future agents benefit from a single prioritization question that can be applied across all sub-topics.

2. **Taxonomy citations belong in the agent, not just in sources.** For subjects with established taxonomies (test smells, test double types), listing the canonical names inline is more actionable than a generic "watch for smells." Future agents in domains with established catalogs (STRIDE, OWASP Top 10, CWE classes) should incorporate the catalog names directly rather than paraphrasing.

3. **"What changes at each layer" is a useful scope framing.** The pyramid balance section works because it gives the model a decision rule: "which layer should this behavior live at?" rather than just "is there test coverage?" Design assistance modes in future agents benefit from this "which tier/layer/phase" framing.

4. **Sources.md is more useful when it records what was *not* used and why.** The note on VoltAgent and ISTQB — explaining the gap between what exists and what was needed — makes it easier for a future author to know whether to re-check those sources.
