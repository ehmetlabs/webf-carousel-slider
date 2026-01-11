import 'dart:convert';

/// 轮播图片项
class CarouselImageItem {
  final Object id;
  final String url;

  const CarouselImageItem({
    required this.id,
    required this.url,
  });

  Map<String, Object> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}

/// 解析轮播图片数据
///
/// 支持输入:
/// - List<Map> 结构
/// - JSON 字符串
List<CarouselImageItem> parseCarouselItems(dynamic value) {
  if (value == null) {
    return const <CarouselImageItem>[];
  }

  dynamic rawValue = value;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return const <CarouselImageItem>[];
    }
    try {
      rawValue = jsonDecode(trimmed);
    } catch (_) {
      return const <CarouselImageItem>[];
    }
  }

  if (rawValue is! List) {
    return const <CarouselImageItem>[];
  }

  final items = <CarouselImageItem>[];
  for (final entry in rawValue) {
    if (entry is! Map) {
      continue;
    }
    final id = entry['id'];
    final urlValue = entry['url'];
    if (id == null || urlValue == null) {
      continue;
    }
    final url = urlValue.toString().trim();
    if (url.isEmpty) {
      continue;
    }
    items.add(CarouselImageItem(id: id, url: url));
  }

  return items;
}
