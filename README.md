# SIDE B

**Tokyo Music Bar Guide** — an editorial guide to places worth listening to.

Live prototype: <https://tsutou.github.io/side-b/>

This repository contains the Phase 1 Flutter Web prototype: Discover, a schematic Map, persistent local Saved places, venue detail pages, and Japanese/English localization. Japanese is the default language. Every venue currently shown is fictional mock data.

## Run locally

```sh
flutter pub get
flutter run -d chrome
```

## Verify

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web
```

Product scope and data policy are in [`docs/product.md`](docs/product.md). Visual direction and accessibility decisions are in [`docs/design.md`](docs/design.md).
