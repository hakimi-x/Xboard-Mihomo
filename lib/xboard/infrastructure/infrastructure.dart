/// XBoard Infrastructure 模块 - 基础设施层
///
/// 提供基础设施服务，包括：
/// - 存储服务
/// - HTTP 客户端
/// - 网络服务
/// - 缓存服务
///
/// 本模块依赖 Core 层，提供具体的基础设施实现
///
/// 使用示例：
/// ```dart
/// import 'package:fl_clash/xboard/infrastructure/infrastructure.dart';
///
/// // 创建存储
/// final storage = await SharedPrefsStorage.create();
/// final result = await storage.getString('key');
///
/// // 使用 HTTP 客户端
/// final client = XBoardHttpClient();
/// final result = await client.get('/api/data');
///
/// // 使用域名竞速
/// final fastestDomain = await DomainRacingService.raceSelectFastestDomain(domains);
///
/// // 使用缓存
/// final cache = MemoryCache<String, String>();
/// cache.set('key', 'value', ttl: Duration(minutes: 5));
/// ```
library;

// ===== 导出存储模块 =====
export 'storage/storage.dart';

// ===== 导出 HTTP 客户端 =====
export 'http/http.dart';

// ===== 导出网络模块 =====
export 'network/network.dart';

// ===== 导出缓存模块 =====
export 'cache/cache.dart';

