---
name: side-b-seo
description: Audit and improve technical SEO for the SIDE B Flutter Web site. Use for metadata, crawlability, sitemap, robots, structured data, social previews, initial HTML, and GitHub Pages deployment checks; exclude keyword-growth promises and fabricated venue claims.
---

# SIDE B SEO

Treat SIDE B as a Japanese-first, single-URL Flutter Web prototype hosted at `https://tsutou.github.io/side-b/`.

## Review order

1. Fetch the public response and initial HTML. Record status, canonical URL, language, title, description, robots directives, and whether meaningful content exists before JavaScript.
2. Check `robots.txt` and `sitemap.xml` directly. A declaration is not proof that the file works.
3. Validate JSON-LD syntax and ensure every statement is supported by visible content. Never mark fictional venues as `LocalBusiness`.
4. Check mobile viewport, image previews, accessible names, HTTPS, response headers, and the release build.
5. Separate measurable findings from GitHub Pages constraints. Do not assign numeric scores to unmeasured categories.

## Product-specific constraints

- Japanese is the default language; English is an in-app toggle on the same URL.
- All current venue records are fictional. Metadata, schema, and machine-readable files must say so where confusion is plausible.
- Critical SEO content should be in the initial HTML. A pre-rendered loading introduction is acceptable when every visitor receives the same content and Flutter replaces it after the first frame.
- Use `WebSite` schema for the prototype. Add place-level schema only after verified real venue data and stable public URLs exist.
- GitHub project pages cannot control the domain-root `https://tsutou.github.io/robots.txt` from this repository. Keep the project sitemap deployable and document the root-level limitation.

Based on the MIT-licensed `seo-technical`, `seo-schema`, and `seo-sitemap` guidance from `AgriciDaniel/claude-seo`, adapted to remove unavailable Claude plugin runners.
