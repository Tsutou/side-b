---
name: test-scenarios
description: Turn SIDE B user stories and acceptance criteria into executable test scenarios. Use when planning QA, extending widget tests, or validating a release across Japanese, English, mobile, keyboard, saved state, and map flows.
---

# Test scenarios

For each user story, define:

- the observable behavior being validated;
- starting state and test data;
- viewport, locale, and input method;
- numbered user actions;
- expected outcome after each action;
- empty, error, boundary, and persistence cases that matter.

Prefer executable Flutter widget tests or deterministic browser checks. Cover the smallest matrix that represents real behavior: Japanese and English where copy changes; compact and wide viewports where layout changes; pointer and keyboard where controls differ; empty and populated saved states.

Do not assert implementation details or exact decorative wording unless that wording is itself a product requirement.

Adapted for this repository from `phuryn/pm-skills`' MIT-licensed `test-scenarios` skill.
