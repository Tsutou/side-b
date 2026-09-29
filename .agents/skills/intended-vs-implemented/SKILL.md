---
name: intended-vs-implemented
description: Compare SIDE B's documented product, design, and data-policy intent with the implementation. Use for release reviews, scope checks, and audits of whether the prototype matches its own documentation.
---

# Intended vs. implemented

Use `docs/product.md`, `docs/design.md`, and `.agents/product-marketing.md` as claims about intended behavior, not as proof that the code satisfies them.

For each material claim:

1. Cite the documented intent.
2. Find the concrete implementation evidence in source, tests, built output, or the rendered product.
3. Classify the result as matched, drifted, undocumented, or not measurable.
4. Report only mismatches that affect user trust, task completion, accessibility, data provenance, release safety, or product scope.
5. Give a specific fix and a verification method.

Do not invent intent where the documents are silent. Treat a missing or stale document as a finding when it prevents a reliable review.

Adapted for this repository from `phuryn/pm-skills`' MIT-licensed `intended-vs-implemented` skill.
