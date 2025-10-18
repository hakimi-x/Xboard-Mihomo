# XBoard Config - 配置解析模块

## 📖 概述

`config` 是 XBoard 的配置解析和管理模块，负责从多个配置源（redirect、gitee）获取和解析配置信息，包括面板 URL、代理 URL、WebSocket URL、更新 URL 和订阅信息。

这是第二版配置模块（V2），采用了更清晰的分层架构和统一的 API 设计。

## 🎯 核心特性

- ✅ **多源配置**: 支持多个配置源（redirect, gitee）
- ✅ **多提供商**: 支持多个提供商（Flclash, Flclash）
- ✅ **配置合并**: 自动合并多个源的配置
- ✅ **订阅管理**: 支持加密和非加密订阅链接
- ✅ **域名竞速**: 自动选择最快的面板 URL
- ✅ **热更新**: 支持运行时刷新配置
- ✅ **状态监听**: 可监听配置变化和状态变化
- ✅ **错误处理**: 完善的错误处理和日志记录

## 🏗️ 架构设计

### 分层架构

```
┌─────────────────────────────────────────┐
│   API Layer (XBoardConfig)            │  ← 统一入口
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│   Accessor Layer (ConfigAccessor)       │  ← 配置访问器
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│   Service Layer (各种 Service)           │  ← 业务服务
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│   Parser Layer (配置解析器)              │  ← 配置解析
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│   Fetcher Layer (配置获取器)             │  ← 远程获取
└─────────────────────────────────────────┘
```

### 目录结构

```
config/
├── xboard_config.dart          # 统一入口 API ⭐
│
├── core/                          # 核心层
│   ├── config_settings.dart       # 配置设置
│   ├── module_initializer.dart    # 模块初始化器
│   └── service_locator.dart       # 服务定位器
│
├── internal/                      # 内部实现层
│   └── xboard_config_accessor.dart # 配置访问器（内部）
│
├── models/                        # 数据模型
│   ├── config_entry.dart          # 配置条目（基类）
│   ├── panel_configuration.dart   # 面板配置
│   ├── parsed_configuration.dart  # 解析后的配置
│   ├── proxy_info.dart            # 代理信息
│   ├── websocket_info.dart        # WebSocket 信息
│   ├── update_info.dart           # 更新信息
│   ├── subscription_info.dart     # 订阅信息
│   └── online_support_info.dart   # 在线支持信息
│
├── parsers/                       # 解析器
│   ├── configuration_parser.dart  # 配置解析器
│   └── config_merger.dart         # 配置合并器
│
├── services/                      # 业务服务
│   ├── panel_service.dart         # 面板服务
│   ├── proxy_service.dart         # 代理服务
│   ├── websocket_service.dart     # WebSocket 服务
│   ├── update_service.dart        # 更新服务
│   └── online_support_service.dart # 在线支持服务
│
├── fetchers/                      # 配置获取器
│   └── remote_config_manager.dart # 远程配置管理器
│
├── utils/                         # 工具类
│   ├── config_validator.dart      # 配置验证器
│   ├── error_handler.dart         # 错误处理器
│   └── logger.dart                # 日志工具
│
└── README.md                      # 本文档
```

## 🚀 快速开始

### 1. 初始化模块

```dart
import 'package:fl_clash/xboard/config/xboard_config.dart';

// 简单初始化（使用默认配置）
await XBoardConfig.initialize(provider: 'Flclash');

// 或使用自定义配置
final settings = ConfigSettings(
  currentProvider: 'Flclash',
  remote: RemoteConfigSettings(
    sources: [
      RemoteSourceConfig(
        name: 'redirect',
        url: 'https://example.com/config',
        priority: 100,
      ),
    ],
  ),
);
await XBoardConfig.initialize(settings: settings);
```

### 2. 获取配置

```dart
// 获取第一个面板 URL
final panelUrl = XBoardConfig.panelUrl;

// 获取第一个代理 URL
final proxyUrl = XBoardConfig.proxyUrl;

// 获取第一个 WebSocket URL
final wsUrl = XBoardConfig.wsUrl;

// 获取第一个更新 URL
final updateUrl = XBoardConfig.updateUrl;

// 获取所有面板 URL 列表
final allPanelUrls = XBoardConfig.allPanelUrls;
```

### 3. 订阅管理

```dart
// 获取订阅信息
final subscriptionInfo = XBoardConfig.subscriptionInfo;

// 获取第一个订阅 URL
final subscriptionUrl = XBoardConfig.subscriptionUrl;

// 构建订阅 URL（带 token）
final url = XBoardConfig.buildSubscriptionUrl(
  userToken,
  preferEncrypt: true, // 优先使用加密链接
);

// 获取所有订阅 URL
final allUrls = XBoardConfig.allSubscriptionUrls;

// 获取所有支持加密的订阅 URL
final encryptUrls = XBoardConfig.allEncryptSubscriptionUrls;
```

### 4. 域名竞速

```dart
// 并发测试所有面板 URL，返回最快的
final fastestUrl = await XBoardConfig.getFastestPanelUrl();
print('最快的面板 URL: $fastestUrl');
```

### 5. 刷新配置

```dart
// 从所有源刷新配置
await XBoardConfig.refresh();

// 从指定源刷新
await XBoardConfig.refreshFromSource('redirect');
await XBoardConfig.refreshFromSource('gitee');
```

### 6. 监听配置变化

```dart
// 监听配置变化
XBoardConfig.configChangeStream.listen((stats) {
  print('配置已更新:');
  print('- 面板数量: ${stats['panels']}');
  print('- 代理数量: ${stats['proxies']}');
  print('- WebSocket 数量: ${stats['websockets']}');
});

// 监听状态变化
XBoardConfig.stateChangeStream.listen((state) {
  print('状态变更: $state');
  // ConfigAccessorState.uninitialized
  // ConfigAccessorState.loading
  // ConfigAccessorState.ready
  // ConfigAccessorState.error
});
```

## 📊 数据模型

### ConfigEntry（配置条目基类）

```dart
class ConfigEntry {
  final String url;
  final int priority;
  
  ConfigEntry({
    required this.url,
    required this.priority,
  });
}
```

### ProxyInfo（代理信息）

```dart
class ProxyInfo extends ConfigEntry {
  final bool supportEncrypt;
  
  ProxyInfo({
    required String url,
    required int priority,
    this.supportEncrypt = false,
  }) : super(url: url, priority: priority);
}
```

### WebSocketInfo（WebSocket 信息）

```dart
class WebSocketInfo extends ConfigEntry {
  final String? protocol;
  
  WebSocketInfo({
    required String url,
    required int priority,
    this.protocol,
  }) : super(url: url, priority: priority);
}
```

### UpdateInfo（更新信息）

```dart
class UpdateInfo extends ConfigEntry {
  final String? version;
  final String? changelog;
  
  UpdateInfo({
    required String url,
    required int priority,
    this.version,
    this.changelog,
  }) : super(url: url, priority: priority);
}
```

### SubscriptionInfo（订阅信息）

```dart
class SubscriptionInfo {
  final List<SubscriptionUrlInfo> urls;
  
  // 获取第一个 URL
  String? get firstUrl => urls.isNotEmpty ? urls.first.url : null;
  
  // 获取第一个支持加密的 URL
  SubscriptionUrlInfo? get firstEncryptUrl => 
      urls.firstWhere((e) => e.supportEncrypt, orElse: () => urls.first);
  
  // 构建订阅 URL（带 token）
  String? buildSubscriptionUrl(String token, {bool forceEncrypt = false}) {
    // 实现逻辑...
  }
}

class SubscriptionUrlInfo {
  final String url;
  final bool supportEncrypt;
  final int priority;
}
```

## 🔧 配置说明

### ConfigSettings（配置设置）

```dart
final settings = ConfigSettings(
  // 当前使用的提供商
  currentProvider: 'Flclash', // 或 'Flclash'
  
  // 远程配置设置
  remote: RemoteConfigSettings(
    // 配置源列表
    sources: [
      RemoteSourceConfig(
        name: 'redirect',
        url: 'https://redirect.example.com',
        priority: 100,
      ),
      RemoteSourceConfig(
        name: 'gitee',
        url: 'https://gitee.com/xxx/config',
        priority: 90,
      ),
    ],
    
    // 超时时间
    timeout: Duration(seconds: 10),
    
    // 重试次数
    retryCount: 3,
  ),
  
  // 日志设置
  log: LogSettings(
    level: XBoardLogLevel.debug,
    enabled: true,
  ),
);

await XBoardConfig.initialize(settings: settings);
```

### 支持的提供商

目前支持的提供商：

1. **Flclash** (默认)
   - 适用于 Flclash 平台
   - 完整的功能支持

2. **Flclash**
   - 适用于 Wujie 平台
   - 完整的功能支持

### 配置源

1. **redirect** (主要)
   - 重定向源，通常是主要配置源
   - 优先级高

2. **gitee** (备用)
   - Gitee 源，作为备用配置源
   - 当主源失败时使用

### 配置源选择机制

配置源采用**并发请求 + 优先级选择**的策略，两个源同时发起请求，但有固定的优先级：

| 场景 | Redirect | Gitee | 最终使用 |
|------|----------|-------|---------|
| ✅ **正常情况** | 成功 ✓ | 成功 ✓ | Redirect（优先级高）|
| ⚠️ **Redirect慢** | 8秒成功 | 2秒成功 | Redirect（等待所有完成）|
| 🔥 **Redirect失败** | 失败 ✗ | 成功 ✓ | Gitee（容错） |
| 💥 **全部失败** | 失败 ✗ | 失败 ✗ | 初始化失败 |

**特点**：
- 并发请求提高速度
- 固定优先级保证稳定性
- 双源容错提高可靠性

## 📈 状态管理

### ConfigAccessorState（配置状态）

```dart
enum ConfigAccessorState {
  uninitialized,  // 未初始化
  loading,        // 加载中
  ready,          // 就绪
  error,          // 错误
}

// 获取当前状态
final state = XBoardConfig.state;

// 监听状态变化
XBoardConfig.stateChangeStream.listen((state) {
  switch (state) {
    case ConfigAccessorState.loading:
      // 显示加载指示器
      break;
    case ConfigAccessorState.ready:
      // 配置已就绪，可以使用
      break;
    case ConfigAccessorState.error:
      // 处理错误
      final error = XBoardConfig.lastError;
      print('错误: $error');
      break;
  }
});
```

## 🔍 高级用法

### 1. 配置统计信息

```dart
final stats = XBoardConfig.stats;
print('配置统计:');
print('- 面板数量: ${stats['panels']}');
print('- 代理数量: ${stats['proxies']}');
print('- WebSocket 数量: ${stats['websockets']}');
print('- 更新源数量: ${stats['updates']}');
print('- 订阅 URL 数量: ${stats['subscriptions']}');
```

### 2. 获取详细配置列表

```dart
// 获取面板配置列表（包含优先级等详细信息）
final panelList = XBoardConfig.panelList;
for (final panel in panelList) {
  print('面板: ${panel.url}, 优先级: ${panel.priority}');
}

// 获取代理配置列表
final proxyList = XBoardConfig.proxyList;
for (final proxy in proxyList) {
  print('代理: ${proxy.url}, 支持加密: ${proxy.supportEncrypt}');
}

// 获取 WebSocket 配置列表
final wsList = XBoardConfig.webSocketList;

// 获取更新配置列表
final updateList = XBoardConfig.updateList;
```

### 3. 订阅链接高级用法

```dart
// 获取订阅信息对象
final subscriptionInfo = XBoardConfig.subscriptionInfo;

if (subscriptionInfo != null) {
  // 获取所有订阅 URL 信息（带详细信息）
  final urlList = subscriptionInfo.urls;
  
  for (final urlInfo in urlList) {
    print('订阅 URL: ${urlInfo.url}');
    print('支持加密: ${urlInfo.supportEncrypt}');
    print('优先级: ${urlInfo.priority}');
  }
  
  // 构建订阅 URL（带 token）
  final token = 'user_token_here';
  
  // 优先使用加密链接
  final encryptUrl = subscriptionInfo.buildSubscriptionUrl(
    token,
    forceEncrypt: true,
  );
  
  // 使用第一个可用链接
  final normalUrl = subscriptionInfo.buildSubscriptionUrl(
    token,
    forceEncrypt: false,
  );
}
```

### 4. 自定义日志

```dart
import 'package:fl_clash/xboard/config/xboard_config.dart';

// 设置日志级别
ConfigLogger.setLevel(XBoardLogLevel.debug);

// 手动记录日志
ConfigLogger.debug('调试信息');
ConfigLogger.info('普通信息');
ConfigLogger.warning('警告信息');
ConfigLogger.error('错误信息');
```

## 🐛 错误处理

### 常见错误

1. **未初始化错误**
```dart
try {
  final url = XBoardConfig.panelUrl; // 未初始化前调用
} catch (e) {
  // StateError: XBoardConfig not initialized. Call initialize() first.
}
```

**解决方法**: 先调用 `initialize()`

2. **配置获取失败**
```dart
// 监听错误状态
XBoardConfig.stateChangeStream.listen((state) {
  if (state == ConfigAccessorState.error) {
    final error = XBoardConfig.lastError;
    print('配置加载失败: $error');
    
    // 可以尝试重新刷新
    XBoardConfig.refresh();
  }
});
```

3. **刷新失败**
```dart
try {
  await XBoardConfig.refresh();
} catch (e) {
  print('刷新配置失败: $e');
  // 处理错误...
}
```

## 💡 最佳实践

### 1. 初始化时机

```dart
// ✅ 推荐：在应用启动时初始化
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化配置模块
  await XBoardConfig.initialize(provider: 'Flclash');
  
  runApp(MyApp());
}
```

### 2. 错误处理

```dart
// ✅ 推荐：检查配置是否可用
final panelUrl = XBoardConfig.panelUrl;
if (panelUrl != null) {
  // 使用配置
} else {
  // 配置不可用，显示错误或使用默认值
}
```

### 3. 监听配置变化

```dart
// ✅ 推荐：在需要实时更新的地方监听配置
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late StreamSubscription _subscription;
  
  @override
  void initState() {
    super.initState();
    
    // 监听配置变化
    _subscription = XBoardConfig.configChangeStream.listen((stats) {
      setState(() {
        // 更新 UI
      });
    });
  }
  
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // 构建 UI
  }
}
```

### 4. 使用域名竞速

```dart
// ✅ 推荐：在需要最佳性能时使用域名竞速
Future<void> connectToPanel() async {
  // 获取最快的面板 URL
  final fastestUrl = await XBoardConfig.getFastestPanelUrl();
  
  if (fastestUrl != null) {
    // 使用最快的 URL 连接
    await connectTo(fastestUrl);
  }
}
```

## 🔬 测试

### 单元测试示例

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:fl_clash/xboard/config/xboard_config.dart';

void main() {
  group('XBoardConfig', () {
    setUp(() async {
      // 初始化
      await XBoardConfig.initialize(provider: 'Flclash');
    });
    
    tearDown(() {
      // 清理
      XBoardConfig.reset();
    });
    
    test('should get panel URL', () {
      final url = XBoardConfig.panelUrl;
      expect(url, isNotNull);
      expect(url, startsWith('http'));
    });
    
    test('should refresh configuration', () async {
      await XBoardConfig.refresh();
      expect(XBoardConfig.state, ConfigAccessorState.ready);
    });
  });
}
```

## 📝 更新日志

### v2.0.0
- ✨ 全新的分层架构
- ✨ 统一的 API 入口
- ✨ 支持订阅链接管理
- ✨ 支持域名竞速
- ✨ 完善的文档

### v1.x.x
- 旧版配置模块（已废弃）

## 🤝 贡献指南

1. 遵循现有的代码风格
2. 添加必要的注释和文档
3. 确保所有测试通过
4. 提交前运行 `flutter analyze`

## 📞 相关文档

- [XBoard 主文档](../README.md)
- [架构设计](../ARCHITECTURE.md)
- [Domain Service 文档](../domain_service/README.md)

---

**维护者**: FlClash Team  
**最后更新**: 2025-10-12  
**版本**: 2.0.0

