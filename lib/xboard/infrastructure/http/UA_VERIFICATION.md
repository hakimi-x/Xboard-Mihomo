# User-Agent 字符串验证

> ⚠️ 重要：所有 UA 字符串必须和原始代码**完全一致**，不能有任何修改！
> 特别是加密部分（`RmxDbGFzaC1XdWppZS1BUEkvMS4w`）是用于 Caddy 反代认证的。

## UA 字符串对照表

| 常量名 | UA 字符串值 | 原始代码位置 | 状态 |
|--------|-----------|------------|------|
| `UserAgentConfig.subscription` | `'FlClash'` | `encrypted_subscription_service.dart:197` | ✅ 已验证 |
| `UserAgentConfig.apiEncrypted` | `'Mozilla/5.0 (compatible; RmxDbGFzaC1XdWppZS1BUEkvMS4w)'` | `domain_racing_service.dart:183`<br>`user_agent_encoder.dart:6` | ✅ 已验证 |
| `UserAgentConfig.subscriptionRacing` | `'FlClash/1.0 (XBoard Race Subscription Client)'` | `concurrent_subscription_service.dart:308` | ✅ 已验证 |
| `UserAgentConfig.domainRacingTest` | `'FlClash/1.0 (Domain Racing Test)'` | `domain_racing_service.dart:188` | ✅ 已验证 |
| `UserAgentConfig.attachment` | `'FlClash/1.0'` | `message_attachment_widget.dart:88` | ✅ 已验证 |

---

## 验证清单

### ✅ 已完成验证

- [x] **订阅下载 UA** - 精确匹配 `'FlClash'`（固定字符串）
- [x] **加密 UA** - 精确匹配 `'Mozilla/5.0 (compatible; RmxDbGFzaC1XdWppZS1BUEkvMS4w)'`
  - ✅ 加密部分 `RmxDbGFzaC1XdWppZS1BUEkvMS4w` 完全一致
  - ✅ 用于 Caddy 反代认证
- [x] **并发订阅竞速 UA** - 精确匹配 `'FlClash/1.0 (XBoard Race Subscription Client)'`
  - ✅ 版本号 `1.0` 保持不变
- [x] **域名竞速测试 UA** - 精确匹配 `'FlClash/1.0 (Domain Racing Test)'`
  - ✅ 版本号 `1.0` 保持不变
- [x] **消息附件 UA** - 精确匹配 `'FlClash/1.0'`
  - ✅ 版本号 `1.0` 保持不变

---

## 原始代码引用

### 1. 订阅下载 UA

**文件**: `encrypted_subscription_service.dart:197`
```dart
// 设置请求头（服务端需要FlClash标识配合密钥获取Clash配置格式）
request.headers.set(HttpHeaders.userAgentHeader, 'FlClash');
```

**新配置**:
```dart
UserAgentConfig.subscription  // 'FlClash'
```

---

### 2. 加密 UA（Caddy 认证）

**文件**: `user_agent_encoder.dart:6`
```dart
/// API请求专用User-Agent - 加密字符串
static const String api = 'Mozilla/5.0 (compatible; RmxDbGFzaC1XdWppZS1BUEkvMS4w)';
```

**文件**: `domain_racing_service.dart:182-183`
```dart
// IP+端口：使用特殊User-Agent
request.headers.set(HttpHeaders.userAgentHeader,
    'Mozilla/5.0 (compatible; RmxDbGFzaC1XdWppZS1BUEkvMS4w)');
```

**新配置**:
```dart
UserAgentConfig.apiEncrypted  // 'Mozilla/5.0 (compatible; RmxDbGFzaC1XdWppZS1BUEkvMS4w)'
```

---

### 3. 并发订阅竞速 UA

**文件**: `concurrent_subscription_service.dart:307-308`
```dart
// 设置请求头
request.headers.set(HttpHeaders.userAgentHeader, 
  'FlClash/1.0 (XBoard Race Subscription Client)');
```

**新配置**:
```dart
UserAgentConfig.subscriptionRacing  // 'FlClash/1.0 (XBoard Race Subscription Client)'
```

---

### 4. 域名竞速测试 UA

**文件**: `domain_racing_service.dart:187-188`
```dart
// 域名：使用默认User-Agent
request.headers.set(
    HttpHeaders.userAgentHeader, 'FlClash/1.0 (Domain Racing Test)');
```

**新配置**:
```dart
UserAgentConfig.domainRacingTest  // 'FlClash/1.0 (Domain Racing Test)'
```

---

### 5. 消息附件 UA

**文件**: `message_attachment_widget.dart:88`
```dart
headers: {
  'Authorization': token,
  'User-Agent': 'FlClash/1.0',
},
```

**新配置**:
```dart
UserAgentConfig.attachment  // 'FlClash/1.0'
```

---

## 迁移验证步骤

### 迁移前必做的检查

1. **逐字符对比**：确保 UA 字符串每个字符都完全一致
2. **版本号检查**：所有 `1.0` 版本号保持不变
3. **加密字符串检查**：`RmxDbGFzaC1XdWppZS1BUEkvMS4w` 必须完全一致

### 迁移后必做的测试

1. **订阅下载测试**：验证能正常下载并解析订阅
2. **Caddy 认证测试**：验证加密 UA 能通过 Caddy 反代
3. **域名竞速测试**：验证域名竞速功能正常
4. **消息附件测试**：验证附件下载正常

---

## 常见问题

### Q: 为什么不能修改版本号？
A: 服务端可能依赖这些特定的版本号来识别客户端。任意修改可能导致服务端拒绝请求。

### Q: 加密字符串是什么意思？
A: `RmxDbGFzaC1XdWppZS1BUEkvMS4w` 是 Base64 编码的字符串，用于 Caddy 反代识别合法请求。

### Q: 能统一成一个 UA 吗？
A: 不能！不同的 UA 是有意设计的，服务端根据 UA 返回不同格式的数据。

### Q: 如果不小心改了怎么办？
A: 立即恢复原始值！否则可能导致订阅下载失败、API 认证失败等问题。

---

## 迁移示例

### 错误的迁移 ❌

```dart
// ❌ 错误：修改了版本号
'FlClash/2.0'  // 原始是 1.0

// ❌ 错误：修改了加密字符串
'Mozilla/5.0 (compatible; FlClash-API)'  // 原始是加密字符串

// ❌ 错误：修改了描述文本
'FlClash/1.0 (Domain Test)'  // 原始是 'Domain Racing Test'
```

### 正确的迁移 ✅

```dart
// ✅ 正确：完全一致
UserAgentConfig.subscription          // 'FlClash'
UserAgentConfig.apiEncrypted          // 完整的加密字符串
UserAgentConfig.subscriptionRacing    // 'FlClash/1.0 (XBoard Race Subscription Client)'
UserAgentConfig.domainRacingTest      // 'FlClash/1.0 (Domain Racing Test)'
UserAgentConfig.attachment            // 'FlClash/1.0'
```

---

## 验证状态

| 项目 | 状态 | 验证时间 |
|-----|------|---------|
| 字符串精确匹配 | ✅ 通过 | 2025-01-15 |
| 版本号一致性 | ✅ 通过 | 2025-01-15 |
| 加密字符串完整性 | ✅ 通过 | 2025-01-15 |
| 代码引用正确性 | ✅ 通过 | 2025-01-15 |

**总结**: ✅ 所有 UA 字符串已验证，与原始代码完全一致。

