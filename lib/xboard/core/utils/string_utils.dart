/// 字符串工具函数
library;

/// 字符串扩展
extension StringExtensions on String {
  /// 判断字符串是否为空或只包含空白字符
  bool get isBlank => trim().isEmpty;

  /// 判断字符串是否不为空且包含非空白字符
  bool get isNotBlank => trim().isNotEmpty;

  /// 首字母大写
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// 首字母小写
  String decapitalize() {
    if (isEmpty) return this;
    return '${this[0].toLowerCase()}${substring(1)}';
  }

  /// 判断是否为有效的邮箱地址
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// 判断是否为有效的 URL
  bool get isValidUrl {
    try {
      final uri = Uri.parse(this);
      return uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      return false;
    }
  }

  /// 截断字符串到指定长度，超出部分用省略号替代
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// 移除所有空白字符
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// 将字符串转换为 snake_case
  String toSnakeCase() {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceFirst(RegExp(r'^_'), '');
  }

  /// 将字符串转换为 camelCase
  String toCamelCase() {
    return split('_').asMap().entries.map((entry) {
      if (entry.key == 0) return entry.value;
      return entry.value.capitalize();
    }).join('');
  }
}

/// 可空字符串扩展
extension NullableStringExtensions on String? {
  /// 判断字符串是否为 null 或空
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// 判断字符串是否为 null 或只包含空白字符
  bool get isNullOrBlank => this == null || this!.isBlank;

  /// 如果为 null 或空，返回默认值
  String orDefault(String defaultValue) {
    return isNullOrEmpty ? defaultValue : this!;
  }
}

