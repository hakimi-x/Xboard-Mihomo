import '../models/update_info.dart';

/// 更新服务
/// 
/// 负责更新相关的基础操作，暂不实现可用性测试等内部方法
class UpdateService {
  final List<UpdateInfo> _updates;

  UpdateService(this._updates);

  /// 获取所有更新源列表
  List<UpdateInfo> getAllUpdateSources() {
    return List.unmodifiable(_updates);
  }

  /// 获取第一个可用的更新源
  UpdateInfo? getFirstUpdateSource() {
    return _updates.isNotEmpty ? _updates.first : null;
  }

  /// 获取第一个可用的更新URL
  String? getFirstUpdateUrl() {
    final update = getFirstUpdateSource();
    return update?.url;
  }

  /// 根据地区筛选更新源
  List<UpdateInfo> getUpdateSourcesByRegion(String region) {
    return _updates.where((update) => update.region == region).toList();
  }

  /// 根据版本筛选更新源
  List<UpdateInfo> getUpdateSourcesByVersion(String version) {
    return _updates.where((update) => update.version == version).toList();
  }

  /// 获取安全更新源（HTTPS）
  List<UpdateInfo> getSecureUpdateSources() {
    return _updates.where((update) => update.isSecure).toList();
  }

  /// 获取非安全更新源（HTTP）
  List<UpdateInfo> getInsecureUpdateSources() {
    return _updates.where((update) => !update.isSecure).toList();
  }

  /// 获取有校验和的更新源
  List<UpdateInfo> getUpdateSourcesWithChecksum() {
    return _updates.where((update) => update.checksum != null).toList();
  }

  /// 获取有文件大小信息的更新源
  List<UpdateInfo> getUpdateSourcesWithFileSize() {
    return _updates.where((update) => update.fileSize != null).toList();
  }

  /// 获取所有可用的版本
  List<String> getAvailableVersions() {
    return _updates
        .where((update) => update.version != null)
        .map((update) => update.version!)
        .toSet()
        .toList();
  }

  /// 获取所有可用的地区
  List<String> getAvailableRegions() {
    return _updates
        .where((update) => update.region != null)
        .map((update) => update.region!)
        .toSet()
        .toList();
  }

  /// 检查是否有安全连接
  bool hasSecureConnections() {
    return _updates.any((update) => update.isSecure);
  }

  /// 检查是否有指定版本的更新源
  bool hasVersion(String version) {
    return _updates.any((update) => update.version == version);
  }

  /// 检查是否有指定地区的更新源
  bool hasRegion(String region) {
    return _updates.any((update) => update.region == region);
  }

  /// 获取总文件大小
  int getTotalFileSize() {
    return _updates
        .where((update) => update.fileSize != null)
        .map((update) => update.fileSize!)
        .fold(0, (sum, size) => sum + size);
  }

  /// 获取平均文件大小
  double getAverageFileSize() {
    final sourcesWithSize = getUpdateSourcesWithFileSize();
    if (sourcesWithSize.isEmpty) return 0.0;
    
    final totalSize = sourcesWithSize
        .map((update) => update.fileSize!)
        .fold(0, (sum, size) => sum + size);
    
    return totalSize / sourcesWithSize.length;
  }

  /// 获取更新服务统计信息
  Map<String, dynamic> getUpdateStats() {
    final stats = <String, dynamic>{
      'totalUpdateSources': _updates.length,
      'secureConnections': getSecureUpdateSources().length,
      'insecureConnections': getInsecureUpdateSources().length,
      'sourcesWithChecksum': getUpdateSourcesWithChecksum().length,
      'sourcesWithFileSize': getUpdateSourcesWithFileSize().length,
      'versions': getAvailableVersions(),
      'regions': getAvailableRegions(),
      'totalFileSize': getTotalFileSize(),
      'averageFileSize': getAverageFileSize(),
    };

    // 按地区统计数量
    final regionCounts = <String, int>{};
    for (final region in getAvailableRegions()) {
      regionCounts[region] = getUpdateSourcesByRegion(region).length;
    }
    stats['regionCounts'] = regionCounts;

    // 按版本统计数量
    final versionCounts = <String, int>{};
    for (final version in getAvailableVersions()) {
      versionCounts[version] = getUpdateSourcesByVersion(version).length;
    }
    stats['versionCounts'] = versionCounts;

    // 协议分布
    stats['protocolDistribution'] = {
      'https': getSecureUpdateSources().length,
      'http': getInsecureUpdateSources().length,
    };

    return stats;
  }

  @override
  String toString() {
    return 'UpdateService(updateSources: ${_updates.length}, '
           'secure: ${getSecureUpdateSources().length}, '
           'versions: ${getAvailableVersions().join(', ')})';
  }
}