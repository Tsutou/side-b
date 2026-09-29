# Walking-area implementation contract

SIDE B's location filter means **a walking route whose returned duration is 20 minutes or less**. It is not a 20-minute straight-line radius.

## User flow

1. The map offers two explicit origins: the device's current location or a place chosen by the user.
2. Current location is requested only after the user presses the control. Denial, timeout, and unavailable location leave the map usable and offer place search.
3. Place search resolves the selected prediction to a stable Place ID and coordinates.
4. The route service computes walking durations from the origin to every currently eligible venue.
5. Venues with a successful duration of at most 1,200 seconds remain visible. Mood and genre filters are then applied to that set.
6. Loading, permission denied, route failure, no matches, and stale results are distinct states. A failed route is never treated as being within range.

## Data required before activation

Each published venue needs verified latitude/longitude, a stable provider ID where available, a source, and a `verifiedAt` timestamp. The seven prototype venues do not have these fields because their identities and positions are fictional.

## Service boundary

The static Flutter client must not contain an unrestricted web-service credential. A small server endpoint accepts one origin and the current venue IDs, resolves only allow-listed venue coordinates, calls a walking route matrix, and returns venue ID, duration seconds, distance meters, and per-destination status. It must enforce origin bounds, destination count, quota, caching, and rate limits.

Google Places Autocomplete may power “choose a place,” subject to its attribution and session-token requirements. Google Routes `computeRouteMatrix` with `travelMode: WALK` is suitable for one origin and multiple destinations. Provider errors and missing routes must remain visible as unknown, not be approximated.

## Acceptance checks

- No location permission prompt occurs on page load.
- A successful current-location request and a chosen place produce the same filtering behavior for the same coordinates.
- 1,200 seconds is included; 1,201 seconds is excluded.
- Denied permission offers place search without clearing existing mood or genre filters.
- Changing the origin cancels or ignores responses from the previous origin.
- No API key, raw device location, or route response is written to source control, analytics, or local persistence.
