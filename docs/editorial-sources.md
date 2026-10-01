# SIDE B — Reading Shelf Sources

## What belongs here

The reading shelf helps someone understand Tokyo's listening culture before visiting a place or after coming home. A useful piece offers at least one of these: a first-person route through a neighborhood, an interview with the person shaping a room, a close look at sound and selection, or a record of how a venue and its city changed together.

The shelf is deliberately small. Specialist publications such as ARBAN add reporting and musical context. Time Out Tokyo is useful for concise, practical orientation. Resident Advisor supplies an international view of Japanese listening-bar culture, especially through film. Visitor's View groups English-language reporting without hiding it from Japanese readers. Future additions can come from personal writing, independent newsletters, venue journals, local magazines, radio archives, podcasts, and books, provided one real venue, the original source, and the rights are clear.

Each article has one language facet and one or more editorial-angle facets. The Reading filters use this reviewed metadata rather than inferring categories at runtime.

## Publication rules

- Link to the original publisher. Do not copy article bodies or use publisher images outside the page's declared social preview.
- Use only the page's declared Open Graph or Twitter Card image as its linked preview. Cache a compressed derivative for performance, retain a visible publisher label, and remove it if the publisher changes the preview or requests removal.
- Show the publisher, author, publication date, and update date when one is supplied.
- Write a short SIDE B note that explains why the piece is worth the reader's time. Do not disguise a summary as reporting.
- Check every link and its metadata before release. Recheck the shelf quarterly and remove dead, substantially changed, or misleading entries.
- Require one identifiable, currently operating real venue and a reviewed Google Maps search URL. Skip roundups, neighborhood guides, temporary events, permanently closed venues, and stories whose subject cannot be resolved to one venue.
- Treat the Google Maps link as a navigation handoff, not as verified venue data. Do not scrape Maps; use the documented search URL format and review the result manually.
- Keep editorial links separate from verified venue facts. An article can provide context, but it does not by itself verify current opening hours, prices, or accessibility.
- Prefer a small, varied shelf over a feed. Seven considered links are more useful than an automated stream of loosely related posts.

## Thumbnail refresh

Run `dart run tool/refresh_article_thumbnails.dart` after changing the shelf. The script reads each publisher's current social-image metadata, requires a reasonable source resolution, and writes a 1200×675 JPEG with consistent crop and compression. Its deterministic print grade normalizes midtone brightness before applying restrained saturation, warm shadow/highlight separation, and subtle paper grain. A failed or undersized source stops the refresh so it can be reviewed rather than silently shipping a poor preview.

If a page has no usable social preview, generate an original SIDE B editorial image from the article's verified subject and facets only. Do not imitate a named artist, reproduce the article's photography, or invent a venue interior. Normalize it with `dart run tool/refresh_article_thumbnails.dart --normalize-ai <source-image> <article-id>`, set `thumbnailKind` to `ArticleThumbnailKind.aiGenerated`, and keep the visible `AI VISUAL` label. The shared `ai-fallback.jpg` is only the last-resort runtime fallback for a missing asset.

## Prototype shelf

Checked on 2026-10-01.

1. ARBAN / 富山英三郎 — [【東京・下北沢／tonlist】ジャズ喫茶文化の音響面を色濃く継承する ホットドッグが美味しいお店](https://www.arban-mag.com/article/76910), 2023-04-28; updated 2026-05-22.
2. Time Out Tokyo — [ミュージックバー 道](https://www.timeout.jp/tokyo/ja/%E3%83%90%E3%83%BC/michi), 2025-02-04.
3. Resident Advisor — [Japan's Hidden Listening Bars: SHeLTeR](https://ra.co/features/3496), 2019-07-11.
Stories about multiple venues, neighborhoods, temporary events, closed venues, or ambiguous destinations remain outside the published shelf. LADY JANE was removed after its reviewed Google Maps result reported the venue permanently closed.
