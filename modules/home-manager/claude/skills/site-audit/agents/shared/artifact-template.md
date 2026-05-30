---

## Universal Artifact Template

Write your output using these sections in order:

### Summary
3 sentences maximum. Lead with the single most important finding for the new owner.

### Raw Evidence
A list of everything you actually retrieved: exact URLs visited, copy snippets quoted
verbatim, HTML elements observed, search results found. Label each item:
- [URL] https://...
- [quote] "exact text from the page"
- [element] <tag attribute="...">
- [search result] "result title" — https://...
- [inaccessible] description of what could not be accessed and why

This section is the evidence base. Every claim in Findings must trace back here.
If you cannot populate this section, your findings are entirely [inferred].

### Structured Output *(optional — include only when the angle produces a list, table, or path trace)*
Use for: numbered path traces (customer-journey), monetization surface tables (revenue-model),
navigation inventories (content-inventory), competitor comparison tables (competitive-landscape).
Format appropriate to the content. Do not duplicate content that belongs in Findings.

### Findings
Bulleted observations. Each bullet must follow this format:
- Observation. [observed] (→ Raw Evidence item) OR [inferred] (→ basis for inference)

Use [observed] only when the claim is directly supported by Raw Evidence.
Use [inferred] when you are reasoning from indirect signals.

### Gaps & Risks
What is absent, broken, inconsistent, or could not be accessed. Be specific.
For each gap: note whether it is a quick fix or a deeper issue.

### Recommended Actions
Prioritized list. Max 7 items. Use this format exactly:
[Priority: H/M/L] [Effort: S/M/L] — Action description (specific, not generic)

Priority: H = address within 30 days, M = within 90 days, L = longer term
Effort: S = hours, M = days, L = weeks or requires outside help
