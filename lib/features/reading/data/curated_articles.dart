import 'package:side_b/features/reading/domain/curated_article.dart';

Uri _googleMapsSearch(String query) =>
    Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': query});

final curatedArticles = <CuratedArticle>[
  CuratedArticle(
    id: 'tonlist',
    source: 'ARBAN',
    author: '富山英三郎',
    dateLabel: '2023.04.28 / UPDATED 2026.05.22',
    titleJa: '下北沢 tonlist——ジャズ喫茶文化の音響面を色濃く継承する店',
    titleEn:
        'tonlist: carrying jazz-kissa sound culture forward in Shimokitazawa',
    noteJa: 'タンノイの音と、片面ずつ聴かせる選曲。昔ながらの作法を、明るいホットドッグ店へ移した理由を店主に聞く。',
    noteEn:
        'An owner interview on Tannoy speakers, playing one record side at a time, and bringing jazz-kissa practice into a bright café.',
    tagsJa: ['下北沢', '音響', '店主'],
    tagsEn: ['Shimokitazawa', 'Sound', 'Owner'],
    url: Uri.parse('https://www.arban-mag.com/article/76910'),
    googleMapsUri: _googleMapsSearch('tonlist 下北沢 東京'),
    facets: {ArticleFacet.japanese, ArticleFacet.people, ArticleFacet.sound},
    featured: true,
  ),
  CuratedArticle(
    id: 'music-bar-michi',
    source: 'Time Out Tokyo',
    author: 'Time Out Tokyo',
    dateLabel: '2025.02.04',
    titleJa: 'ミュージックバー 道',
    titleEn: 'Music Bar Michi',
    noteJa: '湯島駅前にある、千枚を超えるレコードと日替わりの店番のバー。短く実用的で、今夜の一軒を探すときにいい。',
    noteEn:
        'A concise, practical portrait of a Yushima bar with more than a thousand records and a rotating cast behind the counter.',
    tagsJa: ['湯島', 'シティポップ', '深夜'],
    tagsEn: ['Yushima', 'City pop', 'Late'],
    url: Uri.parse('https://www.timeout.jp/tokyo/ja/%E3%83%90%E3%83%BC/michi'),
    googleMapsUri: _googleMapsSearch('ミュージックバー 道 湯島 東京'),
    facets: {ArticleFacet.japanese, ArticleFacet.practical, ArticleFacet.sound},
  ),
  CuratedArticle(
    id: 'shelter-film',
    source: 'Resident Advisor',
    author: 'Resident Advisor',
    dateLabel: '2019.07.11',
    titleJa: 'Japan’s Hidden Listening Bars: SHeLTeR',
    titleEn: 'Japan’s Hidden Listening Bars: SHeLTeR',
    noteJa: '郊外の一室で、30年かけて音を磨く。店を設備の一覧ではなく、人が集まる場所として捉えた短編映像。',
    noteEn:
        'A short film about three decades of refining one sound system—and the friendships that turn equipment into a place.',
    tagsJa: ['八王子', '音響', '映像'],
    tagsEn: ['Hachioji', 'Sound', 'Film'],
    url: Uri.parse('https://ra.co/features/3496'),
    googleMapsUri: _googleMapsSearch('SHeLTeR 八王子 東京 リスニングバー'),
    facets: {ArticleFacet.english, ArticleFacet.sound, ArticleFacet.film},
    visitorPick: true,
  ),
];
