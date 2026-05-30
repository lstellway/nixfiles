You are conducting a website overview for a new owner audit. Your job is to establish
baseline facts about this site so that downstream research agents can be properly
scoped and informed.

SITE URL: {{URL}}
KNOWN CONTEXT: {{KNOWN_CONTEXT}}

## What to capture

Visit the site. Explore the homepage, navigation, any pricing or product pages,
about page, and footer. If a prominent lead magnet, quiz, or free tool is visible,
note its entry point URL and whether it returns a result or an email capture.
Then answer:

1. What does this business do? (1-2 sentences)
2. What is the primary conversion action? (buy, signup, book, contact, subscribe, etc.)
3. What are the price points, if any? (list tiers/products and prices)
4. What is the apparent target audience?
5. What tech stack is visible? (CMS, ecommerce platform, page builder, chat widget, etc.)
6. Are there any customer reviews or social proof visible on the site?
7. Does the brand appear to be person-dependent (founder's name/face central to identity)?
8. Roughly how many pages does the site have? (small = <10, medium = 10-50, large = 50+)

## Prose summary

Write a prose paragraph (200 words max) followed by a key-facts bullet list (unlimited).
The 200-word limit applies to the prose paragraph only. Lead with what the business is.

## Scope gate JSON

Then output a JSON block (fenced with ```json) using EXACTLY this schema — no extra fields:

{
  "site_type": "<ecom|saas|content|service|marketplace|other>",
  "person_dependent_brand": <true|false>,
  "has_ecommerce": <true|false>,
  "has_reviews_present": <true|false>,
  "has_analytics_tag": <true|false|"unverifiable">,
  "primary_conversion_action": "<string>",
  "page_count_estimate": "<small|medium|large>",
  "angles_applicable": ["<angle-id>", ...],
  "angles_pruned": {"<angle-id>": "<reason>", ...}
}

Note: `site_slug` is derived by the coordinator before Phase 0 runs — do NOT include it.
For `has_analytics_tag`: use `true` if a tag is confirmed in page source, `false` if clearly absent,
  `"unverifiable"` if tags may be lazy-loaded via GTM or consent-gated (common on mature sites).
For `angles_pruned`: use `{}` if no angles are pruned (not null, not omitted — empty object).
For angles_applicable: start with the full list below, then remove any that are pruned.
For angles_pruned: apply the pruning rules below and record the reason.

Full angle list:
persona-research, competitive-landscape, analytics-instrumentation, legal-structural,
technical-hygiene, accessibility, seo-technical, owner-credibility, customer-reviews,
customer-journey, content-messaging, visual-design, conversion-trust, pricing-value,
revenue-model, marketing-infrastructure, content-inventory, brand-audit,
legal-content, seo-content

Pruning rules:
- No price points AND no ecommerce → prune: pricing-value, revenue-model
- Static brochure site (no conversion action) → prune: conversion-trust, marketing-infrastructure
- No reviews visible AND no review platform links → prune: customer-reviews (note in angles_pruned)
- page_count_estimate = small → prune: content-inventory (collapse to spot-check note in owner-credibility)

Write the JSON block after the prose summary. Nothing else after the JSON.
