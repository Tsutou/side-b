# SIDE B — Product Brief

## Product statement

SIDE B is an editorial guide to Tokyo places where music is a meaningful reason to visit. It combines the point of view of an independent culture magazine with the utility of a location-aware product.

**Vision:** Discover places worth listening to.

## MVP audience and job

For people deciding where to spend a music-led night in Tokyo, SIDE B should make it easy to browse a small, trusted selection, understand the character of each room, save possibilities, and eventually go there.

The first experience is **browse → notice → save → visit**. AI is not the home screen and is not part of Phase 1.

## Phase 1 scope

- Read: a lightweight, human-edited shelf of external essays, interviews, city guides, and films about Tokyo listening culture. A dedicated Visitor's View mixes English-language reporting with an official neighborhood primer, so the English interface is useful rather than merely translated. Readers can filter the full shelf by language or editorial angle—neighborhoods, people, sound, film, or practical planning. Each item keeps the publisher, author, date, and original URL visible; SIDE B adds only a short bilingual note.
- Place detail: identity, area, type, genres, atmosphere signals, hours, price, and editorial note.
- Map: an editorial schematic with mood and genre filters and numbered venue stories until verified provider data is connected. The production map filters to venues within a verified 20-minute walking route from either the user's current location or a place they choose.
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

The reading shelf follows the same separation rule. Every published story must resolve to one identifiable, currently operating real venue and carry both the publisher URL and a reviewed Google Maps search URL. Roundups, neighborhood guides, temporary events, closed venues, and ambiguous subjects stay outside the shelf. SIDE B does not embed, scrape, or republish article text, images, or Google Maps data.

## Current prototype data

All seven included venues are explicitly fictional. Names, hours, areas, prices, descriptions, and map positions are mock data and make no real-world claims.

## Success signals after MVP

The first meaningful funnel is venue viewed → venue saved → directions opened. `directions_opened` is the strongest early proxy for an intended visit. Analytics is intentionally deferred until the product surface is validated.

## Near-term decisions

- Select and verify the first real editorial cohort.
- Define provider and editorial field ownership before adding Google Places.
- Add verified coordinates or Place IDs for every published venue, then connect a server-side walking-route matrix. Never infer a 20-minute walk from schematic positions or a fixed straight-line radius.
- Request browser geolocation only after the user chooses “current location”; on denial or failure, keep “choose a place” available.
- Decide how language selection persists.
- Validate whether local saved places should migrate automatically after account creation.
