# Architecture Agent — Sources

References that informed the heuristics in `software-architecture.md`.

## Existing Agents & Skills

- [VoltAgent awesome-claude-code-subagents — architect-reviewer](https://github.com/VoltAgent/awesome-claude-code-subagents/blob/main/categories/04-quality-security/architect-reviewer.md) — pattern classification approach, scoring dimensions, output structure
- [mikaelvesavuori/chatgpt-architecture-coach](https://github.com/mikaelvesavuori/chatgpt-architecture-coach) — dialogue-based coaching patterns, DORA metrics, technical debt analysis
- [Piebald-AI claude-code-system-prompts — agent-creation-architect](https://github.com/Piebald-AI/claude-code-system-prompts/blob/main/system-prompts/agent-prompt-agent-creation-architect.md) — agent persona and scope framing

## Frameworks & Standards

- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/the-pillars-of-the-framework.html) — failure isolation, least privilege, loose coupling, right-sizing heuristics
- [Azure Well-Architected Framework — Performance Antipatterns](https://learn.microsoft.com/en-us/azure/architecture/antipatterns/) — chatty I/O, monolithic persistence, missing retry/circuit-breaker, synchronous blocking, absent distributed tracing
- [The Twelve-Factor App](https://12factor.net/) — config externalization (Factor III), stateless processes (Factor VI), dev/prod parity (Factor X), logs as streams (Factor XI)
- [C4 Model](https://c4model.com/diagrams/checklist) — vocabulary for component maps; diagram review checklist (named elements, labeled relationships, system boundary)
- [ATAM — Architecture Tradeoff Analysis Method](https://www.geeksforgeeks.org/software-engineering/architecture-tradeoff-analysis-method-atam/) — quality attribute scenarios, sensitivity points, tradeoff points, non-risk analysis
- [Coupling and Cohesion — ByteByteGo](https://blog.bytebytego.com/p/coupling-and-cohesion-the-two-principles) — afferent/efferent coupling, blast radius framing, change coupling definition

## Articles & Checklists

- [Prompting Techniques That Actually Work — DEV](https://dev.to/uenyioha/prompting-techniques-that-actually-work-lessons-from-automating-architecture-analysis-57al) — evidence anchoring, fixed output sections, independent verification pass
- [Software Architecture Review Checklist — ardura.consulting](https://ardura.consulting/blog/software-architecture-review-checklist/) — practical review checklist used to validate heuristic coverage
- [Prompt Engineering for Architects — Medium](https://medium.com/@dave-patten/prompt-engineering-for-architects-making-ai-speak-architecture-d812648cf755) — framing architecture prompts around quality attributes and constraints
