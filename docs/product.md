# SIDE B — Product Brief

## Product statement

SIDE B is an editorial guide to Tokyo places where music is a meaningful reason to visit. It combines the point of view of an independent culture magazine with the utility of a location-aware product.

**Vision:** Discover places worth listening to.

## MVP audience and job

For people deciding where to spend a music-led night in Tokyo, SIDE B should make it easy to browse a small, trusted selection, understand the character of each room, save possibilities, and eventually go there.

The first experience is **browse → notice → save → visit**. AI is not the home screen and is not part of Phase 1.

## Phase 1 scope

- Discover: human-edited collections and concise observations.
- Place detail: identity, area, type, genres, atmosphere signals, hours, price, and editorial note.
- Map: an editorial schematic with mood filters and numbered venue stories until verified provider data is connected.
- Google Maps handoff: an area search for fictional records, designed to accept exact Place IDs when real venues are introduced.
- Saved: device-local saving, without requiring an account.
- Japanese and English localization infrastructure.

Not included: Firebase, authentication, Spotify, Ask SIDE B, LLMs, production Google Places data, check-ins, or analytics.

## Editorial and data policy

Eligibility depends on whether music is central to choosing the place—not merely present. Strong signals include intentional selection, a record collection, a dedicated sound system, listening-oriented space, and repeated public emphasis on music.

Future records must keep three sources visibly separate:

1. Objective facts from a licensed external provider or venue source.
2. Time-stamped community observations.
3. SIDE B editorial interpretation.

Uncertain classifications stay in review. Google Maps must not be scraped; provider terms and attribution apply.

## Current prototype data

All seven included venues are explicitly fictional. Names, hours, areas, prices, descriptions, and map positions are mock data and make no real-world claims.

## Success signals after MVP

The first meaningful funnel is venue viewed → venue saved → directions opened. `directions_opened` is the strongest early proxy for an intended visit. Analytics is intentionally deferred until the product surface is validated.

## Near-term decisions

- Select and verify the first real editorial cohort.
- Define provider and editorial field ownership before adding Google Places.
- Decide how language selection persists.
- Validate whether local saved places should migrate automatically after account creation.
