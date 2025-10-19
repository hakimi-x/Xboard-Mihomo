# 如何添加新的主题页面

## 📁 文件组织结构

```
lib/
├── ui/contracts/pages/xboard/          # 1️⃣ 定义契约接口
│   └── [模块名]/
│       └── xxx_page_contract.dart
│
├── core/controllers/xboard/             # 2️⃣ 业务逻辑控制器
│   └── xxx_page_controller.dart
│
packages/ui_themes/
├── default_ui/lib/pages/xboard/        # 3️⃣ DefaultUI 实现
│   └── [模块名]/
│       └── default_xxx_page.dart
│
└── modern_ui/lib/pages/xboard/         # 4️⃣ ModernUI 实现
    └── [模块名]/
        └── modern_xxx_page.dart
```

---

## 🔧 开发新页面的完整流程

### 步骤 1: 定义契约接口

**位置**: `lib/ui/contracts/pages/xboard/[模块名]/xxx_page_contract.dart`

```dart
import 'package:fl_clash/ui/contracts/contract_base.dart';

/// 数据模型 - 定义页面需要的数据
class XxxPageData implements DataModel {
  final String title;
  final List<Item> items;
  final bool isLoading;

  const XxxPageData({
    required this.title,
    required this.items,
    this.isLoading = false,
  });

  @override
  Map<String, dynamic> toMap() => {
    'title': title,
    'items': items.map((e) => e.toMap()).toList(),
    'isLoading': isLoading,
  };
}

/// 回调接口 - 定义用户交互事件
class XxxPageCallbacks implements CallbackModel {
  final VoidCallback? onRefresh;
  final Function(Item)? onItemTap;
  final VoidCallback? onBackPressed;

  const XxxPageCallbacks({
    this.onRefresh,
    this.onItemTap,
    this.onBackPressed,
  });
}

/// 页面契约 - UI 组件的抽象
abstract class XxxPageContract extends PageContract {
  const XxxPageContract({
    required XxxPageData data,
    required XxxPageCallbacks callbacks,
  }) : super(data: data, callbacks: callbacks);
}
```

**记得导出**: 在 `lib/ui/contracts/pages/pages_contracts.dart` 中添加：
```dart
export 'xboard/[模块名]/xxx_page_contract.dart';
```

---

### 步骤 2: 创建业务逻辑控制器

**位置**: `lib/core/controllers/xboard/xxx_page_controller.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:fl_clash/ui/registry/ui_registry.dart';

class XxxPageController extends ConsumerStatefulWidget {
  const XxxPageController({super.key});

  @override
  ConsumerState<XxxPageController> createState() => _XxxPageControllerState();
}

class _XxxPageControllerState extends ConsumerState<XxxPageController> {
  bool _isLoading = false;
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // 调用业务服务获取数据
      final items = await ref.read(xxxServiceProvider).getItems();
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // 处理错误
    }
  }

  void _handleItemTap(Item item) {
    // 处理点击事件
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => ItemDetailPageController(item: item),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // 准备数据
    final data = XxxPageData(
      title: '页面标题',
      items: _items,
      isLoading: _isLoading,
    );

    // 准备回调
    final callbacks = XxxPageCallbacks(
      onRefresh: _loadData,
      onItemTap: _handleItemTap,
      onBackPressed: () => Navigator.of(context).pop(),
    );

    // 使用 UIRegistry 构建 UI
    return UIRegistry().buildPage<XxxPageContract>(
      data: data,
      callbacks: callbacks,
    );
  }
}
```

**记得导出**: 在 `lib/core/controllers/xboard/xboard_controllers.dart` 中添加：
```dart
export 'xxx_page_controller.dart';
```

---

### 步骤 3: 实现 DefaultUI 主题

**位置**: `packages/ui_themes/default_ui/lib/pages/xboard/[模块名]/default_xxx_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';

class DefaultXxxPage extends StatelessWidget implements XxxPageContract {
  @override
  final XxxPageData data;
  @override
  final XxxPageCallbacks callbacks;

  const DefaultXxxPage({
    super.key,
    required this.data,
    required this.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: callbacks.onBackPressed,
        ),
      ),
      body: data.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => callbacks.onRefresh?.call(),
              child: ListView.builder(
                itemCount: data.items.length,
                itemBuilder: (context, index) {
                  final item = data.items[index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.subtitle),
                    onTap: () => callbacks.onItemTap?.call(item),
                  );
                },
              ),
            ),
    );
  }
}
```

---

### 步骤 4: 实现 ModernUI 主题

**位置**: `packages/ui_themes/modern_ui/lib/pages/xboard/[模块名]/modern_xxx_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';

class ModernXxxPage extends StatelessWidget implements XxxPageContract {
  @override
  final XxxPageData data;
  @override
  final XxxPageCallbacks callbacks;

  const ModernXxxPage({
    super.key,
    required this.data,
    required this.callbacks,
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
            colors: [
              Colors.purple.shade400,
              Colors.blue.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 自定义 AppBar
              _buildModernAppBar(context),
              // 内容区域
              Expanded(
                child: data.isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : _buildModernContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // 大圆角返回按钮
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: callbacks.onBackPressed,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => callbacks.onRefresh?.call(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.items.length,
        itemBuilder: (context, index) {
          final item = data.items[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                item.subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              onTap: () => callbacks.onItemTap?.call(item),
            ),
          );
        },
      ),
    );
  }
}
```

---

### 步骤 5: 注册页面到主题包

**DefaultUI**: 在 `packages/ui_themes/default_ui/lib/default_ui_theme.dart` 中：

```dart
// 1. 导入页面
import 'package:default_ui/pages/xboard/[模块名]/default_xxx_page.dart';

// 2. 导出页面
export 'pages/xboard/[模块名]/default_xxx_page.dart';

// 3. 在 register() 方法中注册
@override
void register() {
  final registry = UIRegistry();
  
  // ... 其他页面注册 ...
  
  registry.registerPage<XxxPageContract>(
    themeId: metadata.id,
    pageType: XxxPageContract,
    builder: (data, callbacks) => DefaultXxxPage(
      data: data as XxxPageData,
      callbacks: callbacks as XxxPageCallbacks,
    ),
  );
}
```

**ModernUI**: 在 `packages/ui_themes/modern_ui/lib/modern_ui_theme.dart` 中做同样的操作。

---

## 🎯 使用新页面

在任何地方使用新页面：

```dart
import 'package:fl_clash/core/controllers/xboard/xboard_controllers.dart';

// 导航到新页面
Navigator.push(context, MaterialPageRoute(
  builder: (_) => const XxxPageController(),
));
```

---

## 📝 现有模块参考

可以参考已实现的页面作为模板：

| 模块 | 契约 | 控制器 | DefaultUI | ModernUI |
|-----|------|--------|-----------|----------|
| Auth/Login | `lib/ui/contracts/pages/xboard/auth/login_page_contract.dart` | `lib/core/controllers/xboard/login_page_controller.dart` | `packages/ui_themes/default_ui/lib/pages/xboard/auth/default_login_page.dart` | `packages/ui_themes/modern_ui/lib/pages/xboard/auth/modern_login_page.dart` |

---

## ✨ 最佳实践

1. **先写契约**: 明确定义数据结构和回调接口
2. **Controller 负责业务**: 所有数据获取、状态管理在 Controller 中
3. **UI 只负责展示**: 页面实现只处理 UI 展示和用户交互
4. **保持两个主题一致**: DefaultUI 和 ModernUI 功能要一致，只是视觉不同
5. **添加标记**: 在新 UI 实现顶部添加 `🆕 新UI实现` 注释

---

*更新时间: 2025-10-19*

