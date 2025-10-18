# XBoard Domain Service - 中间层架构说明

## 📖 概述

`xboard/domain_service` 是 FlClash 应用中 XBoard 功能的统一访问层（Facade 模式），它封装了底层的 `flutter_xboard_sdk`，为上层业务代码提供简洁、统一的 API。

## 🎯 设计目标

1. **单一入口**：所有 XBoard 功能只通过 `XBoardDomainService` 访问
2. **简化调用**：隐藏 SDK 的复杂性，提供开箱即用的便捷方法
3. **类型安全**：使用强类型接口，减少运行时错误
4. **易于维护**：集中管理 SDK 调用，方便未来升级和修改
5. **向后兼容**：通过类型别名保持与旧代码的兼容性

## 📂 目录结构

```
lib/xboard/domain_service/
├── domain_service.dart          # 主入口文件 + XBoardDomainService 类
├── src/
│   ├── xboard_client.dart       # SDK 客户端封装（底层）
│   ├── config/
│   │   └── service_configs.dart # 服务配置
│   ├── utils/
│   │   └── subscription_url_transformer.dart  # 订阅链接转换工具
│   └── exceptions/
│       ├── domain_exceptions.dart            # 领域异常
│       └── domain_service_exceptions.dart    # 服务异常
└── README.md                    # 本文档
```

## 🏗️ 架构层次

```
┌─────────────────────────────────────────┐
│   业务层 (Features)                      │
│   - auth/                                │
│   - payment/                             │
│   - invite/                              │
│   - subscription/                        │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│   中间层 (Domain Service)                │  ← 你在这里！
│   XBoardDomainService                   │
│   - 统一 API                             │
│   - 便捷方法                             │
│   - 错误处理                             │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│   客户端层 (Client)                      │
│   XBoardClient                          │
│   - SDK 生命周期管理                     │
│   - 多域名竞速                           │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│   SDK 层 (flutter_xboard_sdk)           │
│   - HTTP 请求                            │
│   - Token 管理                           │
│   - API 定义                             │
└─────────────────────────────────────────┘
```

## 📚 核心组件

### 1. XBoardDomainService

**职责**：
- 提供统一的静态方法访问 XBoard 功能
- 封装 SDK 调用细节
- 统一错误处理
- 简化常见操作

**关键方法**：

```dart
// 初始化
await XBoardDomainService.initialize(null);

// 认证
await XBoardDomainService.login(email, password);
await XBoardDomainService.logout();

// 用户信息
final userInfo = await XBoardDomainService.getUserInfo();

// 套餐和订阅
final plans = await XBoardDomainService.getPlans();
final subscription = await XBoardDomainService.getSubscription();

// 订单
final tradeNo = await XBoardDomainService.createOrder(request);
final orders = await XBoardDomainService.getOrders();

// 支付
final methods = await XBoardDomainService.getPaymentMethods();
final result = await XBoardDomainService.submitPayment(request);

// 邀请佣金
final inviteInfo = await XBoardDomainService.getInviteInfo();
await XBoardDomainService.withdrawCommission(amount: 100, withdrawAccount: 'xxx');

// 工单
final tickets = await XBoardDomainService.getTickets();
await XBoardDomainService.createTicket(subject: 'Help', message: '...', level: 1);

// 公告
final notices = await XBoardDomainService.getNotices();
```

### 2. XBoardClient

**职责**：
- SDK 实例管理
- 多域名竞速选择
- SDK 初始化配置

**使用场景**：
- 通常不需要直接调用
- 由 `XBoardDomainService` 内部使用

### 3. 类型别名（向后兼容）

为了保持与旧代码的兼容性，提供了以下类型别名：

```dart
typedef UserInfoData = UserInfo;
typedef SubscriptionData = SubscriptionInfo;
typedef PlanData = Plan;
typedef OrderData = Order;
typedef PaymentMethodData = PaymentMethod;
typedef NoticeData = Notice;
typedef TicketData = Ticket;
// ... 等等
```

## 🔧 使用指南

### ✅ 正确用法

```dart
// 1. 应用启动时初始化（只需一次）
await XBoardDomainService.initialize(null);

// 2. 在任何地方直接调用
final userInfo = await XBoardDomainService.getUserInfo();
final plans = await XBoardDomainService.getPlans();

// 3. 使用请求模型
final orderRequest = CreateOrderRequestData(
  planId: 1,
  period: 'month_price',
  couponCode: 'DISCOUNT2024',
);
final tradeNo = await XBoardDomainService.createOrder(orderRequest);
```

### ❌ 错误用法

```dart
// ❌ 不要直接访问 SDK
final sdk = XBoardClient.instance.sdk;
final userInfo = await sdk.userInfo.getUserInfo();

// ❌ 不要绕过 DomainService
final client = XBoardClient.instance;
await client.sdk.login.login(email, password);
```

## 🔄 数据流

```
用户操作
  ↓
UI Layer (页面/组件)
  ↓
Provider Layer (状态管理)
  ↓
XBoardDomainService (中间层) ← 统一入口
  ↓
XBoardClient (客户端封装)
  ↓
XBoardSDK (底层 SDK)
  ↓
HTTP API (后端服务)
```

## 🚀 最佳实践

### 1. 始终使用 DomainService

```dart
// ✅ 好
final plans = await XBoardDomainService.getPlans();

// ❌ 差
final sdk = XBoardClient.instance.sdk;
final plans = await sdk.plan.fetchPlans();
```

### 2. 使用类型别名保持兼容性

```dart
// 旧代码可以继续使用
UserInfoData userInfo = await XBoardDomainService.getUserInfo();

// 新代码推荐直接使用 SDK 类型
UserInfo userInfo = await XBoardDomainService.getUserInfo();
```

### 3. 错误处理

```dart
try {
  final userInfo = await XBoardDomainService.getUserInfo();
  if (userInfo != null) {
    // 处理用户信息
  }
} catch (e) {
  // 处理错误
  print('获取用户信息失败: $e');
}
```

### 4. Provider 中使用

```dart
@riverpod
class UserInfoNotifier extends _$UserInfoNotifier {
  @override
  Future<UserInfo?> build() async {
    return await XBoardDomainService.getUserInfo();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await XBoardDomainService.getUserInfo();
    });
  }
}
```

## 📝 API 分类

### 认证相关
- `login()` - 登录
- `register()` - 注册
- `logout()` - 登出
- `resetPassword()` - 重置密码
- `sendVerificationCode()` - 发送验证码
- `isLoggedIn()` - 检查登录状态

### 用户相关
- `getUserInfo()` - 获取用户信息

### 套餐与订阅
- `getPlans()` - 获取套餐列表
- `getSubscription()` - 获取订阅信息

### 订单相关
- `createOrder()` - 创建订单
- `getOrders()` - 获取订单列表
- `getOrderByTradeNo()` - 根据订单号获取详情
- `cancelOrder()` - 取消订单
- `getPaymentMethods()` - 获取支付方式

### 支付相关
- `submitPayment()` - 提交支付
- `checkPaymentStatus()` - 查询支付状态
- `checkOrderStatus()` - 检查订单状态
- `cancelPayment()` - 取消支付
- `getPaymentHistory()` - 获取支付历史
- `getPaymentStats()` - 获取支付统计

### 邀请佣金
- `getInviteInfo()` - 获取邀请信息
- `generateInviteCode()` - 生成邀请码
- `getCommissionHistory()` - 获取佣金历史
- `withdrawCommission()` - 提现佣金
- `transferCommissionToBalance()` - 划转佣金到余额

### 优惠券
- `checkCoupon()` - 验证优惠券

### 工单
- `getTickets()` - 获取工单列表
- `createTicket()` - 创建工单
- `getTicketDetail()` - 获取工单详情
- `replyTicket()` - 回复工单
- `closeTicket()` - 关闭工单

### 公告
- `getNotices()` - 获取公告列表

### 配置
- `getConfig()` - 获取应用配置
- `getAppInfo()` - 获取应用信息

### 工具方法
- `initialize()` - 初始化服务
- `dispose()` - 释放资源
- `getCurrentDomain()` - 获取当前域名
- `switchToFastestDomain()` - 切换到最快域名

## 🔍 常见问题

### Q: 为什么要有中间层？

**A**:
1. **解耦**：业务代码不直接依赖 SDK 实现
2. **简化**：隐藏 SDK 的复杂性
3. **标准化**：统一的调用方式和错误处理
4. **灵活**：方便未来切换或升级底层 SDK

### Q: 什么时候需要直接访问 SDK？

**A**: 通常不需要。如果 `XBoardDomainService` 没有提供你需要的方法，请：
1. 先检查是否可以添加到 `XBoardDomainService`
2. 如果是通用功能，应该添加到中间层
3. 只有在极特殊情况下才考虑绕过中间层

### Q: 如何扩展新功能？

**A**:
1. 确认 SDK 支持该功能
2. 在 `XBoardDomainService` 中添加对应的静态方法
3. 按照现有模式进行封装（try-catch，返回值处理等）
4. 更新本文档的 API 分类

## 🔗 相关文档

- [flutter_xboard_sdk 文档](../../../sdk/flutter_xboard_sdk/README.md)
- [XBoard 配置说明](../config_v2/README.md)
- [认证功能说明](../features/auth/README.md)

## 📌 维护说明

### 添加新 API 的步骤

1. **确认 SDK 支持**
   ```dart
   // 检查 flutter_xboard_sdk 是否有对应 API
   final result = await XBoardSDK.instance.someApi.someMethod();
   ```

2. **在 XBoardDomainService 中添加方法**
   ```dart
   /// 获取某个数据
   static Future<SomeData?> getSomeData() async {
     try {
       final result = await _sdk.someApi.someMethod();
       return result.data;
     } catch (e) {
       return null; // 或者重新抛出异常，根据业务需求
     }
   }
   ```

3. **添加文档注释**
   - 说明方法用途
   - 参数说明
   - 返回值说明
   - 使用示例

4. **更新本 README**
   - 在对应的 API 分类中添加
   - 如果是新分类，创建新的章节

5. **添加类型别名（如需要）**
   ```dart
   typedef SomeData = SomeSDKModel;
   ```

---

**最后更新**: 2025-01-12
**维护者**: FlClash Team
