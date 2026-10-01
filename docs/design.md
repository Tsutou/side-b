# SIDE B — Design Direction

## Intent

The interface should feel edited, curious, cultural, and slightly nostalgic without becoming a record-shop costume. Its pacing borrows from Japanese city magazines: an assertive masthead, warm paper, practical captions, surprising image crops, and deliberate negative space. Record culture enters through the 33⅓ motif, jacket-like hero composition, and one expressive painted scene rather than through decorative vinyl clichés everywhere.

The map is the primary editorial surface: a full-width, jacket-like night map pairs numbered markers with one selected venue story. The map owns the visual density; the surrounding page stays quiet so the interface feels collected rather than decorated.

## Visual system

- **Ink** `#191816`: navigation, night surfaces, primary text.
- **Ivory** `#F2EEE5`: paper-like primary background.
- **Paper** `#F8F5EE`: raised light surfaces.
- **Vermilion** `#B9452C`: restrained editorial markers and active states.
- **Album yellow** `#D6A62E`: the featured story's jacket-like color field.
- **Midnight** `#20283A`: navigation and factual notices.
- **Oxblood** `#6D2D24`: a deep print accent within featured material.
- **Warm gray** `#8A8278`: secondary information.
- **Moss** `#4E5745`: optional quiet secondary accent.

English typography uses Futura across display, body, labels, and brand elements. Japanese uses the bundled Noto Sans JP variable font while preserving the same hierarchy; the `SIDE B` wordmark remains Futura in both locales. Noto Sans JP is distributed under the SIL Open Font License, stored alongside the font asset. Futura is referenced as a locally installed family in the prototype; a licensed webfont asset is required before relying on it in production.

Spacing follows a 4/8/12/16/24/32/48/72 scale. Editorial image and rule compositions can stay square; interactive surfaces use the Material 3 shape scale (8, 16, and 28px) so controls, cards, and dialogs expose a consistent hierarchy. Shadows are reserved for genuinely floating surfaces. Motion uses 140 ms and 240 ms durations, and the MVP avoids required animation so reduced-motion users lose no context.

## Material Design foundation

Material 3 is the interaction and component foundation. Navigation uses `NavigationBar`, language selection uses `SegmentedButton`, venue signals use `Chip`, and actions use Material button variants with their standard focus, hover, pressed, selected, disabled, tooltip, and semantic behavior. The color scheme maps SIDE B's ink, ivory, vermilion, midnight, and album yellow onto primary, secondary, tertiary, and surface-container roles. Component themes own shape, padding, state, and tonal emphasis so editorial screens do not invent a separate interaction language. Editorial composition, photography, and typography carry the publication identity without replacing familiar platform behavior.

## Components in the MVP

- `BrandHeader`: publication identity, edition, and language switch.
- `VenueCard`: image, area, venue type, sound, editorial observation, save action.
- `MapPreview`: layered Tokyo schematic, accessible numbered markers, and a single crossfading venue preview.
- Map filters: Material `FilterChip` controls styled as record-like bubbles, split into mood and genre rows. Selections use OR within a row and AND across rows, with a clear no-results state.
- `SaveButton`: a 48px accessible toggle with semantic and tooltip labels.
- `BottomNavigation`: three primary destinations with text on the active item.
- `ReadingShelf`: editorial article cards with visible source metadata, a single outbound action, and locally cached social-preview artwork. Every preview is center-cropped to 16:9, softened to the SIDE B palette, and labeled with its publisher; cards never load third-party images at runtime. `Visitor's View` appears before the general shelf so English-language reporting and official travel context are easy to find without creating a separate tourist mode.
- Reading filters: a single-select row of Material `FilterChip` bubbles for language and editorial angle. Every chip exposes selected state, the result count updates immediately, and empty sections collapse rather than leaving ornamental headings behind.
- Detail facts and venue signals: bordered factual units, not decorative pills.
- Google Maps action: a full-width detail CTA that searches the venue's area during the fictional-data phase; production records will add Place IDs for exact destinations.

## Responsive behavior

The content column is capped at 1120px. Editorial splits become vertical below 680–760px. Venue grids move from three columns to two and then one. The bottom navigation remains available on desktop because it is part of the requested application shell, not a desktop dashboard.

## Accessibility baseline

- Ink/ivory and vermilion/ivory combinations maintain strong contrast.
- Interactive targets are at least 48px.
- Images, navigation, map markers, selected states, and save toggles have semantics.
- Controls are standard Flutter focusable widgets for web keyboard use.
- Layouts avoid fixed text-height containers where copy can scale.
- No information depends on motion, color, or hover alone.

## Imagery

The hero is an original AI-generated figurative painting of a fictional listening bar, art-directed around the broader visual language of late-1970s record sleeves: rhythmic group movement, elongated gestures, warm oil texture, and a dense listening-room atmosphere. It does not reproduce a named artist's work or an existing jacket composition. Supporting venue photography is also original and fictional, with distinct amber listening-bar, rain-lit jazz-kissa, and midnight DJ-room scenes to avoid repetitive cards. Production imagery will require provenance, permission, alt text, and clear association with verified place records.
