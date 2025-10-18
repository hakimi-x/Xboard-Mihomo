/// 日期时间工具函数
library;

/// 日期时间扩展
extension DateTimeExtensions on DateTime {
  /// 判断是否为今天
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// 判断是否为昨天
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// 判断是否为明天
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// 判断是否在过去
  bool get isPast => isBefore(DateTime.now());

  /// 判断是否在未来
  bool get isFuture => isAfter(DateTime.now());

  /// 格式化为友好的时间显示
  String toFriendlyString() {
    if (isToday) {
      return '今天 ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else if (isYesterday) {
      return '昨天 ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else if (isTomorrow) {
      return '明天 ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else {
      return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')} '
          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
  }

  /// 格式化为 ISO 8601 格式
  String toIso8601() => toIso8601String();

  /// 获取当天的开始时间（00:00:00）
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// 获取当天的结束时间（23:59:59）
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// 获取当月的第一天
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  /// 获取当月的最后一天
  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0);
  }

  /// 获取时间差的友好显示
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}周前';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else {
      return '${(difference.inDays / 365).floor()}年前';
    }
  }
}

/// 可空日期时间扩展
extension NullableDateTimeExtensions on DateTime? {
  /// 判断是否为 null 或在过去
  bool get isNullOrPast => this == null || this!.isPast;

  /// 判断是否为 null 或在未来
  bool get isNullOrFuture => this == null || this!.isFuture;

  /// 如果为 null，返回默认值
  DateTime orDefault(DateTime defaultValue) {
    return this ?? defaultValue;
  }

  /// 如果为 null，返回当前时间
  DateTime get orNow => this ?? DateTime.now();
}

