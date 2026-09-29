---
name: side-b-design-review
description: Audit and improve the rendered SIDE B interface against its editorial direction and user task. Use for visual QA, responsive polish, hierarchy, interaction states, AI-slop detection, or requests to make the product feel more intentional.
---

# SIDE B design review

Review the rendered product before reading implementation details. Calibrate findings against `docs/design.md` and the primary job: choose a music-led place for tonight.

Make seven passes:

1. Information hierarchy: the map and next-place decision are primary.
2. Interaction states: default, selected, saved, empty, detail, compact, and wide layouts.
3. User journey: map → understand a room → save or open details.
4. Editorial specificity: city-magazine pacing, record-culture cues, and useful captions without costume or vinyl clichés.
5. Design-system alignment: Material 3 behavior with SIDE B tokens and typography.
6. Responsive accessibility: 320px reflow, text scaling, keyboard focus, target size, contrast, and reduced motion.
7. Template/slop check: reject generic SaaS cards, ornamental labels, gratuitous gradients, and repeated decoration that does not encode information.

For every finding, provide observed evidence, user impact, a concrete change, and a way to verify it. Preserve strong existing decisions under a “do not touch” note. Fix high-confidence issues; surface genuine taste or scope tradeoffs instead of silently deciding them.

This portable repository skill adapts the MIT-licensed review principles of `garrytan/gstack` without its Claude/Bun runtime coupling.
