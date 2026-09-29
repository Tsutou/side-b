---
name: side-b-a11y-review
description: Review and test SIDE B accessibility across Flutter semantics, keyboard operation, contrast, focus, text scaling, responsive reflow, and meaningful states. Use for UI changes, accessibility audits, and release QA.
---

# SIDE B accessibility review

Use the POUR model and inspect every meaningful state, not only the default render.

## Required checks

- Perceivable: meaningful images have localized labels; decorative paint is excluded; normal text reaches 4.5:1 contrast; UI boundaries and focus indicators reach 3:1; content reflows at 320px and large text sizes.
- Operable: every action is reachable and usable by keyboard; focus order follows the visual order; targets are at least 48 logical pixels in this product; no control is nested inside another control in the semantics tree.
- Understandable: visible labels and accessible names agree; save/unsave state is announced; Japanese and English controls retain the same meaning.
- Robust: buttons expose button semantics, toggles expose state, map markers have names, and hidden or excluded semantics never contain the only operable control.

Use Flutter's `tapTargetGuideline`, `labeledTapTargetGuideline`, and `textContrastGuideline` in widget tests when the surface can be represented there. Supplement automation with a browser keyboard pass because automated checks do not prove focus order, text scaling, or usability.

When accepting a limitation, name the exact state, impact, and follow-up; do not silently disable a failing check.

Adapted from Langflow's MIT-licensed `ibm-a11y-testing-guide` for this Flutter Web codebase.
