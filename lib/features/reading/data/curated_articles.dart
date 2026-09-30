import 'package:side_b/features/reading/domain/curated_article.dart';

final curatedArticles = <CuratedArticle>[
  CuratedArticle(
    id: 'shimokitazawa-cafe-hop',
    source: 'note',
    author: '奥森皐月',
    dateLabel: '2026.05.17',
    titleJa: '梯子喫茶のすすめ｜マルディグラとジャズ喫茶マサコ【下北沢】',
    titleEn: 'Café hopping in Shimokitazawa: Mardi Gras and Jazz Kissa Masako',
    noteJa: '徒歩20秒の二軒をつなぐ、生活者の街歩き。音だけでなく、席や照明まで含めて店を好きになる過程が見える。',
    noteEn:
        'A local walk between two cafés just seconds apart, attentive to the seats, light, and small rituals that make a room memorable.',
    tagsJa: ['下北沢', 'ジャズ喫茶', '街歩き'],
    tagsEn: ['Shimokitazawa', 'Jazz kissa', 'Walk'],
    url: Uri.parse('https://note.com/okumoris/n/n02c163278518'),
    featured: true,
  ),
  CuratedArticle(
    id: 'tokyo-record-cafe-tour',
    source: 'note',
    author: 'keisuko',
    dateLabel: '2026.05.28',
    titleJa: '東京のレコードカフェやジャズ喫茶、ジャズレコード店巡りなど',
    titleEn: 'A tour of Tokyo record cafés, jazz kissa, and record shops',
    noteJa: '渋谷から御茶ノ水まで、初めてレコードのある店へ出かける人に近い目線で、一日の巡り方をたどれる。',
    noteEn:
        'A first-person route from Shibuya to Ochanomizu that makes record cafés and jazz kissa feel approachable to newcomers.',
    tagsJa: ['渋谷', '御茶ノ水', 'レコード'],
    tagsEn: ['Shibuya', 'Ochanomizu', 'Vinyl'],
    url: Uri.parse('https://note.com/keisuko/n/nf2598a8f7e97'),
  ),
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
  ),
  CuratedArticle(
    id: 'lady-jane',
    source: 'ARBAN',
    author: '富山英三郎',
    dateLabel: '2017.03.23 / UPDATED 2020.11.25',
    titleJa: '下北沢 LADY JANE——刺激的なライブが楽しめる、老舗ジャズバー',
    titleEn:
        'LADY JANE: an experimental jazz bar with roots in 1970s Shimokitazawa',
    noteJa: '開店は1975年。音楽、映画、演劇が交わる。街と店が一緒に歳を重ねる姿を、店主の言葉から読む。',
    noteEn:
        'A history of a bar founded in 1975, told where music, film, and theatre meet—and where a venue grows old with its neighborhood.',
    tagsJa: ['下北沢', 'ライブ', '老舗'],
    tagsEn: ['Shimokitazawa', 'Live', 'History'],
    url: Uri.parse('https://www.arban-mag.com/article/4977'),
  ),
  CuratedArticle(
    id: 'tower-records-beer',
    source: 'Mikiki',
    author: '土佐有明',
    dateLabel: '2026.09.08',
    titleJa: '原 摩利彦がTOWER RECORDS BEERで語る、選盤と映画音楽',
    titleEn:
        'Marihiko Hara on record selection and film music at TOWER RECORDS BEER',
    noteJa: 'レコードを買う場所と飲む場所が重なった、渋谷の新しい一角を訪ねる。原 摩利彦の選盤も読みどころ。',
    noteEn:
        'A composer selects records inside a new Shibuya bar, showing what changes when buying, listening, and drinking share one floor.',
    tagsJa: ['渋谷', '選盤', '新しい店'],
    tagsEn: ['Shibuya', 'Selection', 'New opening'],
    url: Uri.parse('https://mikiki.tokyo.jp/articles/-/45992'),
  ),
];
