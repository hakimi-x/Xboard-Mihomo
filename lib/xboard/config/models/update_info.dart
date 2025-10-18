import 'config_entry.dart';

/// 更新信息
/// 
/// 扩展ConfigEntry，添加更新服务特有的属性
class UpdateInfo extends ConfigEntry {
  final String? version;
  final String? checksum;
  final String? region;
  final int? fileSize;

  const UpdateInfo({
    required String url,
    required String description,
    this.version,
    this.checksum,
    this.region,
    this.fileSize,
    Map<String, dynamic>? metadata,
  }) : super(url: url, description: description, metadata: metadata);

  /// 从JSON创建更新信息
  factory UpdateInfo.fromJson(Map<String, dynamic> json) {
    return UpdateInfo(
      url: json['url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      version: json['version'] as String?,
      checksum: json['checksum'] as String?,
      region: json['region'] as String?,
      fileSize: json['fileSize'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      if (version != null) 'version': version,
      if (checksum != null) 'checksum': checksum,
      if (region != null) 'region': region,
      if (fileSize != null) 'fileSize': fileSize,
    });
    return json;
  }

  /// 检查是否为HTTPS连接
  bool get isSecure => url.startsWith('https://');

  /// 获取文件大小的可读格式
  String get fileSizeFormatted {
    if (fileSize == null) return 'Unknown';
    
    const units = ['B', 'KB', 'MB', 'GB'];
    double size = fileSize!.toDouble();
    int unitIndex = 0;
    
    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }
    
    return '${size.toStringAsFixed(1)} ${units[unitIndex]}';
  }

  @override
  String toString() {
    return 'UpdateInfo(url: $url, version: $version, region: $region, size: $fileSizeFormatted)';
  }
}