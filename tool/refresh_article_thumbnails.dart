import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:side_b/features/reading/data/curated_articles.dart';
import 'package:side_b/features/reading/domain/curated_article.dart';

const _targetWidth = 1200;
const _targetHeight = 675;
const _maxDownloadBytes = 20 * 1024 * 1024;

Future<void> main(List<String> args) async {
  if (args.isNotEmpty && args.first == '--normalize-ai') {
    if (args.length != 3) {
      throw const FormatException(
        'Usage: --normalize-ai <source-image> <article-id>',
      );
    }
    await _normalizeAiImage(File(args[1]), args[2]);
    return;
  }
  final client =
      HttpClient()
        ..connectionTimeout = const Duration(seconds: 15)
        ..userAgent =
            'SIDE-B-Editorial-Refresh/1.0 (+https://tsutou.github.io/side-b/)';
  final output = Directory('assets/images/articles');
  await output.create(recursive: true);

  var updated = 0;
  final failures = <String>[];
  try {
    final articles =
        args.isEmpty
            ? curatedArticles
            : curatedArticles.where((article) => args.contains(article.id));
    for (final article in articles) {
      try {
        if (article.thumbnailKind == ArticleThumbnailKind.aiGenerated) {
          await _validateGeneratedThumbnail(File(article.thumbnailAsset));
          stdout.writeln('ok ${article.id} <- AI-generated editorial image');
          continue;
        }
        final imageUrl = await _findSocialImage(client, article.url);
        final sourceBytes = await _download(client, imageUrl);
        final source = img.decodeImage(sourceBytes);
        if (source == null) {
          throw const FormatException('unsupported image format');
        }
        if (source.width < 600 || source.height < 315) {
          throw FormatException(
            'image is too small (${source.width}×${source.height})',
          );
        }

        final thumbnail = _normalize(source);
        final bytes = img.encodeJpg(thumbnail, quality: 82);
        final file = File(article.thumbnailAsset);
        final unchanged =
            await file.exists() && _sameBytes(await file.readAsBytes(), bytes);
        if (!unchanged) {
          await file.writeAsBytes(bytes, flush: true);
          updated++;
        }
        stdout.writeln(
          '${unchanged ? 'ok' : 'updated'} ${article.id} <- $imageUrl',
        );
      } catch (error) {
        failures.add('${article.id}: $error');
        stderr.writeln('failed ${article.id}: $error');
      }
    }
  } finally {
    client.close(force: true);
  }

  stdout.writeln('Thumbnail refresh complete: $updated changed.');
  if (failures.isNotEmpty) {
    throw StateError(
      '${failures.length} article thumbnail(s) failed:\n${failures.join('\n')}',
    );
  }
}

Future<void> _normalizeAiImage(File sourceFile, String articleId) async {
  final source = img.decodeImage(await sourceFile.readAsBytes());
  if (source == null) {
    throw FormatException('unsupported image format: ${sourceFile.path}');
  }
  final output = File('assets/images/articles/$articleId.jpg');
  await output.parent.create(recursive: true);
  await output.writeAsBytes(
    img.encodeJpg(_normalize(source), quality: 82),
    flush: true,
  );
  stdout.writeln('updated $articleId <- AI-generated editorial image');
}

Future<void> _validateGeneratedThumbnail(File file) async {
  if (!await file.exists()) {
    throw FileSystemException('AI-generated thumbnail is missing', file.path);
  }
  final image = img.decodeImage(await file.readAsBytes());
  if (image == null ||
      image.width != _targetWidth ||
      image.height != _targetHeight) {
    throw FormatException(
      'AI-generated thumbnail must be $_targetWidth×$_targetHeight: ${file.path}',
    );
  }
}

Future<Uri> _findSocialImage(HttpClient client, Uri pageUrl) async {
  final response = await _get(client, pageUrl);
  final bytes = await _readLimited(response, 4 * 1024 * 1024);
  final html = utf8.decode(bytes, allowMalformed: true);
  final tags = RegExp(r'<meta\s+[^>]*>', caseSensitive: false).allMatches(html);

  String? fallback;
  for (final match in tags) {
    final tag = match.group(0)!;
    final attributes = <String, String>{};
    for (final attribute in RegExp(
      r'''([\w:-]+)\s*=\s*["']([^"']*)["']''',
      caseSensitive: false,
    ).allMatches(tag)) {
      attributes[attribute.group(1)!.toLowerCase()] = _decodeHtml(
        attribute.group(2)!,
      );
    }
    final key =
        (attributes['property'] ?? attributes['name'] ?? '').toLowerCase();
    final content = attributes['content'];
    if (content == null || content.isEmpty) continue;
    if (key == 'og:image' || key == 'og:image:secure_url') {
      return _resolveImageUrl(pageUrl, content);
    }
    if (key == 'twitter:image' || key == 'twitter:image:src') {
      fallback ??= content;
    }
  }
  if (fallback != null) return _resolveImageUrl(pageUrl, fallback);
  throw const FormatException('no og:image or twitter:image metadata');
}

Uri _resolveImageUrl(Uri pageUrl, String value) {
  final candidate = value.trim();
  try {
    return pageUrl.resolve(candidate);
  } on FormatException {
    throw FormatException('invalid social image URL: $candidate');
  }
}

Future<Uint8List> _download(HttpClient client, Uri url) async {
  final response = await _get(client, url);
  return Uint8List.fromList(await _readLimited(response, _maxDownloadBytes));
}

Future<HttpClientResponse> _get(HttpClient client, Uri url) async {
  final request = await client.getUrl(url).timeout(const Duration(seconds: 20));
  request.headers.set(
    HttpHeaders.acceptHeader,
    'text/html,image/avif,image/webp,image/*,*/*;q=0.8',
  );
  final response = await request.close().timeout(const Duration(seconds: 30));
  if (response.statusCode < 200 || response.statusCode >= 300) {
    await response.drain<void>();
    throw HttpException('HTTP ${response.statusCode}', uri: url);
  }
  return response;
}

Future<List<int>> _readLimited(HttpClientResponse response, int limit) async {
  final bytes = <int>[];
  await for (final chunk in response) {
    bytes.addAll(chunk);
    if (bytes.length > limit) {
      throw const FileSystemException('download exceeded the size limit');
    }
  }
  return bytes;
}

img.Image _normalize(img.Image source) {
  final scale = math.max(
    _targetWidth / source.width,
    _targetHeight / source.height,
  );
  final resized = img.copyResize(
    source,
    width: (source.width * scale).round(),
    height: (source.height * scale).round(),
    interpolation: img.Interpolation.cubic,
  );
  final cropped = img.copyCrop(
    resized,
    x: (resized.width - _targetWidth) ~/ 2,
    y: (resized.height - _targetHeight) ~/ 2,
    width: _targetWidth,
    height: _targetHeight,
  );
  var luminanceTotal = 0.0;
  for (final pixel in cropped) {
    luminanceTotal +=
        .2126 * pixel.rNormalized +
        .7152 * pixel.gNormalized +
        .0722 * pixel.bNormalized;
  }
  final averageLuminance = luminanceTotal / (cropped.width * cropped.height);
  final brightness = (0.48 / averageLuminance).clamp(.88, 1.12);
  final graded = img.adjustColor(
    cropped,
    saturation: .58,
    contrast: 1.1,
    brightness: brightness,
  );

  for (final pixel in graded) {
    final luminance =
        .2126 * pixel.rNormalized +
        .7152 * pixel.gNormalized +
        .0722 * pixel.bNormalized;
    final paperR = .07 + .84 * luminance;
    final paperG = .07 + .75 * luminance;
    final paperB = .09 + .58 * luminance;
    final grain =
        (((pixel.x * 13 + pixel.y * 7 + (pixel.x * pixel.y) % 17) % 19) - 9) /
        1100;
    const inkMix = .14;
    final red = (pixel.rNormalized * (1 - inkMix) + paperR * inkMix + grain)
        .clamp(0.0, 1.0);
    final green = (pixel.gNormalized * (1 - inkMix) + paperG * inkMix + grain)
        .clamp(0.0, 1.0);
    final blue = (pixel.bNormalized * (1 - inkMix) + paperB * inkMix + grain)
        .clamp(0.0, 1.0);
    pixel.setRgba(red * 255, green * 255, blue * 255, pixel.a);
  }
  return graded;
}

String _decodeHtml(String value) => value
    .replaceAll('&amp;', '&')
    .replaceAll('&quot;', '"')
    .replaceAll('&#39;', "'")
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>');

bool _sameBytes(List<int> left, List<int> right) {
  if (left.length != right.length) return false;
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) return false;
  }
  return true;
}
