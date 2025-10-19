# UI 分离实现逻辑详解

## 🎯 核心思想

**一句话总结**：业务层不直接创建 UI Widget，而是通过"契约"向 UI 层传递数据和回调，UI 层根据当前选择的主题包来渲染不同的界面。

---

## 📊 流程图

### 完整数据流

```
┌─────────────────────────────────────────────────────────┐
│ 1. 用户打开首页                                          │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│ 2. 业务层获取数据                                        │
│    • ref.watch(userNameProvider) → "张三"               │
│    • ref.watch(isConnectedProvider) → true             │
│    • ref.watch(proxyGroupsProvider) → [HK, US, JP]    │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│ 3. 业务层准备契约数据                                    │
│    data = HomePageData(                                 │
│      userName: "张三",                                   │
│      isConnected: true,                                 │
│      proxyGroups: [HK, US, JP],                        │
│    )                                                    │
│                                                         │
│    callbacks = HomePageCallbacks(                       │
│      onConnect: () { /* 业务逻辑 */ },                  │
│      onProxyTap: (group) { /* 业务逻辑 */ },           │
│    )                                                    │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│ 4. 查询 UI 注册中心                                      │
│    UIRegistry.buildPage<HomePageContract>(              │
│      data: data,                                        │
│      callbacks: callbacks,                              │
│    )                                                    │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│ 5. UI 注册中心根据当前主题选择构建器                      │
│                                                         │
│    if (当前主题 == "default") {                         │
│      return DefaultHomePage(data, callbacks)            │
│    }                                                    │
│    else if (当前主题 == "modern") {                     │
│      return ModernHomePage(data, callbacks)             │
│    }                                                    │
│    else if (当前主题 == "minimal") {                    │
│      return MinimalHomePage(data, callbacks)            │
│    }                                                    │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│ 6. 对应的 UI 实现渲染界面                                │
│                                                         │
│ DefaultHomePage:                    ModernHomePage:    │
│  ┌──────────────┐                  ┌──────────────┐   │
│  │ 欢迎, 张三    │                  │  Hi 张三 😊   │   │
│  │ [已连接]      │                  │  ●●●●●        │   │
│  │              │                  │              │   │
│  │ □ HK 节点    │                  │  ┏━━━━━━┓    │   │
│  │ □ US 节点    │                  │  ┃ HK   ┃    │   │
│  │ □ JP 节点    │                  │  ┗━━━━━━┛    │   │
│  │              │                  │              │   │
│  └──────────────┘                  └──────────────┘   │
│  (列表式)                           (卡片式)           │
└─────────────────────────────────────────────────────────┘
```

---

## 🔧 核心实现机制

### 机制 1: 契约（Contract）

**作用**：定义业务层和 UI 层的通信协议

```dart
// ═══════════════════════════════════════════════════
// lib/ui/contracts/pages/home_page_contract.dart
// ═══════════════════════════════════════════════════

/// 📝 契约：首页需要什么数据、有什么交互
abstract class HomePageContract extends StatelessWidget {
  final HomePageData data;       // 数据（Props）
  final HomePageCallbacks callbacks;  // 回调（Events）
  
  const HomePageContract({
    super.key,
    required this.data,
    required this.callbacks,
  });
}

/// 📦 数据模型（类似前端的 interface）
class HomePageData {
  final String userName;
  final bool isConnected;
  final int uploadSpeed;
  final int downloadSpeed;
  final List<ProxyGroup> proxyGroups;
  
  const HomePageData({
    required this.userName,
    required this.isConnected,
    required this.uploadSpeed,
    required this.downloadSpeed,
    required this.proxyGroups,
  });
}

/// 🎯 回调模型
class HomePageCallbacks {
  final VoidCallback onConnectToggle;
  final Function(ProxyGroup) onProxyGroupTap;
  final VoidCallback onSettingsTap;
  
  const HomePageCallbacks({
    required this.onConnectToggle,
    required this.onProxyGroupTap,
    required this.onSettingsTap,
  });
}
```

**类比前端**：

```typescript
// TypeScript 版本
interface HomePageProps {
  userName: string;
  isConnected: boolean;
  uploadSpeed: number;
  downloadSpeed: number;
  proxyGroups: ProxyGroup[];
  
  onConnectToggle: () => void;
  onProxyGroupTap: (group: ProxyGroup) => void;
  onSettingsTap: () => void;
}

// React 组件
const HomePage: React.FC<HomePageProps> = (props) => {
  // UI 实现
};
```

---

### 机制 2: UI 注册中心（Registry）

**作用**：管理所有 UI 构建器，根据主题选择返回对应的 Widget

```dart
// ═══════════════════════════════════════════════════
// lib/ui/registry/ui_registry.dart
// ═══════════════════════════════════════════════════

class UIRegistry {
  // 单例
  static final UIRegistry _instance = UIRegistry._internal();
  factory UIRegistry() => _instance;
  UIRegistry._internal();

  // 📚 页面构建器注册表
  // Key: 页面类型 (如 HomePageContract)
  // Value: 构建函数
  final Map<Type, Function> _pageBuilders = {};
  
  // 当前激活的主题包ID
  String _currentTheme = 'default';

  /// 注册页面构建器
  void registerPage<T>({
    required String themeId,
    required Widget Function(dynamic data, dynamic callbacks) builder,
  }) {
    final key = '${themeId}_$T';
    _pageBuilders[key] = builder;
    debugPrint('[UIRegistry] 已注册: $key');
  }

  /// 设置当前主题
  void setTheme(String themeId) {
    _currentTheme = themeId;
    debugPrint('[UIRegistry] 切换主题: $themeId');
  }

  /// 构建页面
  Widget buildPage<T>({
    required dynamic data,
    required dynamic callbacks,
  }) {
    // 1. 根据当前主题和页面类型查找构建器
    final key = '${_currentTheme}_$T';
    final builder = _pageBuilders[key];
    
    if (builder == null) {
      // 2. 如果没找到，降级到默认主题
      final defaultKey = 'default_$T';
      final defaultBuilder = _pageBuilders[defaultKey];
      
      if (defaultBuilder == null) {
        throw Exception('❌ 页面 $T 未注册');
      }
      
      return defaultBuilder(data, callbacks);
    }
    
    // 3. 调用构建器创建 Widget
    return builder(data, callbacks);
  }
}
```

**运行时示例**：

```dart
// 注册表内容（启动时填充）
{
  'default_HomePageContract': (data, callbacks) => DefaultHomePage(...),
  'modern_HomePageContract': (data, callbacks) => ModernHomePage(...),
  'minimal_HomePageContract': (data, callbacks) => MinimalHomePage(...),
  
  'default_ProfilePageContract': (data, callbacks) => DefaultProfilePage(...),
  'modern_ProfilePageContract': (data, callbacks) => ModernProfilePage(...),
  // ...
}

// 当前主题
_currentTheme = 'modern';

// 查询过程
buildPage<HomePageContract>()
  → key = 'modern_HomePageContract'
  → builder = (data, callbacks) => ModernHomePage(...)
  → return ModernHomePage(data, callbacks)
```

---

### 机制 3: 主题包注册

**作用**：在应用启动时，将所有 UI 实现注册到注册中心

```dart
// ═══════════════════════════════════════════════════
// packages/ui_themes/default_ui/lib/default_ui_theme.dart
// ═══════════════════════════════════════════════════

class DefaultUITheme {
  static void register() {
    final registry = UIRegistry();
    
    // 📄 注册所有页面
    registry.registerPage<HomePageContract>(
      themeId: 'default',
      builder: (data, callbacks) => DefaultHomePage(
        data: data as HomePageData,
        callbacks: callbacks as HomePageCallbacks,
      ),
    );
    
    registry.registerPage<ProfilePageContract>(
      themeId: 'default',
      builder: (data, callbacks) => DefaultProfilePage(
        data: data as ProfilePageData,
        callbacks: callbacks as ProfilePageCallbacks,
      ),
    );
    
    registry.registerPage<ProxyPageContract>(
      themeId: 'default',
      builder: (data, callbacks) => DefaultProxyPage(
        data: data as ProxyPageData,
        callbacks: callbacks as ProxyPageCallbacks,
      ),
    );
    
    // ... 注册其他页面
  }
}
```

```dart
// ═══════════════════════════════════════════════════
// packages/ui_themes/modern_ui/lib/modern_ui_theme.dart
// ═══════════════════════════════════════════════════

class ModernUITheme {
  static void register() {
    final registry = UIRegistry();
    
    // 📄 注册现代风格的页面实现
    registry.registerPage<HomePageContract>(
      themeId: 'modern',
      builder: (data, callbacks) => ModernHomePage(
        data: data as HomePageData,
        callbacks: callbacks as HomePageCallbacks,
      ),
    );
    
    registry.registerPage<ProfilePageContract>(
      themeId: 'modern',
      builder: (data, callbacks) => ModernProfilePage(
        data: data as ProfilePageData,
        callbacks: callbacks as ProfilePageCallbacks,
      ),
    );
    
    // ... 注册其他页面
  }
}
```

---

### 机制 4: 业务层使用

**作用**：业务层通过契约与 UI 层交互，不直接依赖具体的 UI 实现

```dart
// ═══════════════════════════════════════════════════
// lib/pages/home.dart (业务层)
// ═══════════════════════════════════════════════════

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 📊 1. 获取数据（从 Provider）
    final userName = ref.watch(userNameProvider);
    final isConnected = ref.watch(connectionStatusProvider);
    final uploadSpeed = ref.watch(uploadSpeedProvider);
    final downloadSpeed = ref.watch(downloadSpeedProvider);
    final proxyGroups = ref.watch(proxyGroupsProvider);

    // 📦 2. 准备契约数据
    final data = HomePageData(
      userName: userName,
      isConnected: isConnected,
      uploadSpeed: uploadSpeed,
      downloadSpeed: downloadSpeed,
      proxyGroups: proxyGroups,
    );

    // 🎯 3. 准备回调
    final callbacks = HomePageCallbacks(
      onConnectToggle: () {
        // 业务逻辑
        if (isConnected) {
          ref.read(connectionController).disconnect();
        } else {
          ref.read(connectionController).connect();
        }
      },
      onProxyGroupTap: (group) {
        // 业务逻辑 + 导航
        ref.read(proxyController).selectGroup(group);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProxyDetailPage(group: group),
          ),
        );
      },
      onSettingsTap: () {
        // 导航逻辑
        Navigator.of(context).pushNamed('/settings');
      },
    );

    // 🎨 4. 使用 UI 注册中心构建页面
    // 注意：这里不知道也不关心最终会渲染成什么样
    return UIRegistry().buildPage<HomePageContract>(
      data: data,
      callbacks: callbacks,
    );
  }
}
```

**关键点**：
- ❌ **不写** `return Scaffold(...)` 
- ❌ **不写** `return Column(...)`
- ✅ **只写** `return UIRegistry().buildPage(...)`

---

### 机制 5: UI 实现

**作用**：不同主题包提供不同的 UI 实现

#### 默认 UI 实现

```dart
// ═══════════════════════════════════════════════════
// packages/ui_themes/default_ui/lib/pages/default_home_page.dart
// ═══════════════════════════════════════════════════

class DefaultHomePage extends HomePageContract {
  const DefaultHomePage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 传统的 AppBar
      appBar: AppBar(
        title: Text('欢迎, ${data.userName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: callbacks.onSettingsTap,
          ),
        ],
      ),
      
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // 连接状态卡片
          Card(
            child: ListTile(
              leading: Icon(
                data.isConnected ? Icons.check_circle : Icons.cancel,
                color: data.isConnected ? Colors.green : Colors.red,
              ),
              title: Text(data.isConnected ? '已连接' : '未连接'),
              trailing: Switch(
                value: data.isConnected,
                onChanged: (_) => callbacks.onConnectToggle(),
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // 流量统计
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.upload),
                      Text('上传: ${data.uploadSpeed} KB/s'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.download),
                      Text('下载: ${data.downloadSpeed} KB/s'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // 代理组列表
          Text('代理组', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          
          ...data.proxyGroups.map((group) => Card(
            child: ListTile(
              leading: Icon(Icons.language),
              title: Text(group.name),
              subtitle: Text('${group.proxies.length} 个节点'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => callbacks.onProxyGroupTap(group),
            ),
          )),
        ],
      ),
    );
  }
}
```

#### 现代 UI 实现（完全不同！）

```dart
// ═══════════════════════════════════════════════════
// packages/ui_themes/modern_ui/lib/pages/modern_home_page.dart
// ═══════════════════════════════════════════════════

class ModernHomePage extends HomePageContract {
  const ModernHomePage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 渐变背景
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade400, Colors.blue.shade600],
          ),
        ),
        
        child: CustomScrollView(
          slivers: [
            // 大标题
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Hi, ${data.userName} 👋'),
                background: _AnimatedBackground(),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.tune, color: Colors.white),
                  onPressed: callbacks.onSettingsTap,
                ),
              ],
            ),
            
            SliverPadding(
              padding: EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // 浮动的连接卡片（毛玻璃效果）
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.isConnected ? '🟢 已连接' : '🔴 未连接',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '点击切换',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: callbacks.onConnectToggle,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  data.isConnected ? Icons.pause : Icons.play_arrow,
                                  color: Colors.purple,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  // 动画流量图表
                  _AnimatedTrafficChart(
                    upload: data.uploadSpeed,
                    download: data.downloadSpeed,
                  ),
                  
                  SizedBox(height: 24),
                  
                  // 代理组网格（而不是列表！）
                  Text(
                    '代理节点',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: data.proxyGroups.length,
                    itemBuilder: (context, index) {
                      final group = data.proxyGroups[index];
                      return GestureDetector(
                        onTap: () => callbacks.onProxyGroupTap(group),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white24, Colors.white12],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white30),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                group.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${group.proxies.length} 节点',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**关键区别**：

| 元素 | 默认 UI | 现代 UI |
|------|---------|---------|
| 布局 | ListView | CustomScrollView |
| 标题 | AppBar | SliverAppBar |
| 背景 | 纯色 | 渐变 + 动画 |
| 连接卡片 | 普通 Card | 毛玻璃卡片 |
| 代理列表 | ListTile | GridView |
| 交互 | 点击 | 手势 + 动画 |

---

## 🚀 启动流程

```dart
// ═══════════════════════════════════════════════════
// lib/main.dart
// ═══════════════════════════════════════════════════

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1️⃣ 读取用户上次选择的主题
  final prefs = await SharedPreferences.getInstance();
  final selectedTheme = prefs.getString('selected_ui_theme') ?? 'default';
  
  // 2️⃣ 根据选择注册对应的 UI 实现
  switch (selectedTheme) {
    case 'default':
      DefaultUITheme.register();
      break;
    case 'modern':
      ModernUITheme.register();
      break;
    case 'minimal':
      MinimalUITheme.register();
      break;
  }
  
  // 3️⃣ 设置当前主题
  UIRegistry().setTheme(selectedTheme);
  
  // 4️⃣ 启动应用
  runApp(const MyApp());
}
```

---

## 🔄 切换主题流程

```dart
// ═══════════════════════════════════════════════════
// lib/views/settings/ui_theme_selector.dart
// ═══════════════════════════════════════════════════

Future<void> switchUITheme(String newTheme) async {
  // 1️⃣ 保存用户选择
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('selected_ui_theme', newTheme);
  
  // 2️⃣ 清空旧的注册
  UIRegistry().clear();
  
  // 3️⃣ 注册新的 UI 实现
  switch (newTheme) {
    case 'default':
      DefaultUITheme.register();
      break;
    case 'modern':
      ModernUITheme.register();
      break;
    case 'minimal':
      MinimalUITheme.register();
      break;
  }
  
  // 4️⃣ 设置当前主题
  UIRegistry().setTheme(newTheme);
  
  // 5️⃣ 重启应用以应用新 UI
  // 使用 Phoenix 或 RestartWidget
  Phoenix.rebirth(context);
}
```

---

## 📝 总结

### 核心机制

1. **契约（Contract）**：定义数据和回调接口
2. **注册中心（Registry）**：管理 UI 构建器
3. **主题包（Theme Package）**：提供具体的 UI 实现
4. **业务层（Controller）**：准备数据和回调，不直接创建 UI
5. **动态构建**：运行时根据选择的主题构建对应的 UI

### 数据流向

```
Provider (数据源)
    ↓
Controller (业务逻辑)
    ↓
Contract (数据 + 回调)
    ↓
Registry (查找构建器)
    ↓
UI Implementation (渲染界面)
```

### 类比前端

```
Redux Store (数据源)
    ↓
React Component (业务逻辑)
    ↓
Props (数据 + 回调)
    ↓
UI Library (Ant Design / Material UI)
    ↓
DOM (渲染界面)
```

---

## ❓ 常见问题

### Q1: 性能如何？

**A**: 几乎无影响
- 注册在启动时完成（一次性）
- buildPage 只是一个 Map 查找（O(1)）
- Widget 构建和正常写法一样

### Q2: 如何共享公共组件？

**A**: 创建共享组件库

```dart
// lib/ui/shared/
export 'loading_indicator.dart';
export 'empty_state.dart';

// 所有主题包都可以使用
import 'package:fl_clash/ui/shared/loading_indicator.dart';
```

### Q3: 能否部分页面使用新架构，部分保持旧架构？

**A**: 可以！渐进式迁移

```dart
// 新页面
return UIRegistry().buildPage<HomePageContract>(...);

// 旧页面（保持不变）
return Scaffold(...);  // 直接写 UI
```

### Q4: 主题包可以独立发布吗？

**A**: 可以！

```yaml
# pubspec.yaml
dependencies:
  fl_clash_default_ui:
    git:
      url: https://github.com/xxx/fl_clash_default_ui
  
  fl_clash_modern_ui:
    git:
      url: https://github.com/xxx/fl_clash_modern_ui
```

---

这就是完整的实现逻辑！简单来说就是**把 UI 的创建过程延迟到运行时，通过注册中心动态选择**。

还有什么不清楚的地方吗？🤔

