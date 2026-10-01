# SIDE B — Engineering and release review

## Delivery loop

Each change should move through a small evidence-based loop:

1. **Intent** — update or cite the product, design, data, or messaging rule that the change serves.
2. **Scenario** — describe the observable behavior, including locale, viewport, saved state, and input method when relevant.
3. **Implementation** — keep facts, community observations, and editorial interpretation separate.
4. **Verification** — format, analyze, test, build, and inspect the rendered result at compact and wide sizes.
5. **Release** — deploy only from `main`; confirm the GitHub Pages workflow and fetch the public artifact rather than assuming the push equals a release.

The Pages workflow enforces formatting, static analysis, widget tests, a release build, and the presence of SEO discovery files before deployment.

The curated reading shelf also has a deterministic media step. `dart run tool/refresh_article_thumbnails.dart` fetches only declared social-preview images, validates their size, and produces local 1200×675 JPEGs. Tests require one normalized asset for every article, so adding a story without completing its preview cannot pass release QA.

For articles without a usable social preview, `--normalize-ai <source-image> <article-id>` applies the same output contract to an original generated image. The article record must declare `ArticleThumbnailKind.aiGenerated`; the UI then discloses the source as `AI VISUAL`. A shared generated fallback prevents a broken image frame if an asset is unexpectedly unavailable at runtime.

## Intended vs. implemented review — 2026-09-29

| Intent | Implementation evidence | Status |
| --- | --- | --- |
| The map is the primary way to choose the next place | Map is the initial tab, first navigation destination, largest element on wide screens, and paired with a visible seven-venue index | Matched |
| Japanese is the default; English remains available | App locale initializes to `ja`, the header retains the EN/JP selector, and the initial HTML is `lang="ja"` | Matched |
| Material 3 supplies familiar interaction behavior | `ThemeData(useMaterial3: true)` plus Material navigation, segmented controls, buttons, chips, tooltips, and focus behavior | Matched |
| The publication should feel editorial rather than like a generic card dashboard | Map-first composition, numbered venue index, ink/paper palette, compact editorial labels, and restrained corners | Matched |
| Prototype data must not be mistaken for real venue facts | The in-app notice, detail notice, initial HTML, product documentation, and `llms.txt` identify all current records as fictional | Matched |
| Controls need clear semantics and independent actions | Map markers and venue-index rows are named buttons; card navigation and save toggles are sibling controls rather than nested controls | Matched |
| Public content should be discoverable | Canonical metadata, initial Japanese content, `WebSite` JSON-LD, social cards, sitemap, and project-level robots file ship in the build | Partially matched |

## Known constraints

- Flutter Web remains client-rendered after the initial loading introduction. Stable, indexable venue pages require real data plus URL routing or static rendering.
- This project repository can publish `/side-b/robots.txt`, but it cannot control the GitHub Pages domain-root `/robots.txt`. A custom domain or the `Tsutou.github.io` root repository is needed for that.
- Futura is requested as a local family but is not bundled. Production needs a licensed webfont or an approved metric-compatible fallback.
- Security headers beyond GitHub Pages defaults cannot be configured from this static project. Move to a configurable host if a strict CSP becomes a release requirement.
- No real place, map, directions, or search-performance integration should be enabled until data ownership, attribution, credentials, and provider terms are documented.
