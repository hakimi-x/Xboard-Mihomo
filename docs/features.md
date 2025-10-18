# 核心特性详解

XBoard Mihomo 的完整功能说明和使用方法。

---

## 📋 目录

- [入口域名防封锁机制](#入口域名防封锁机制)
- [高可用性保障](#高可用性保障)
- [配置文件托管方案](#配置文件托管方案)
- [应用生命周期](#应用生命周期)
- [扩展功能](#扩展功能)

---

## 🛡️ 入口域名防封锁机制

针对面板主域名可能被封锁的场景，提供了多层防护策略。

### 方案一：内置代理访问（规划中）

- **功能说明**：通过客户端内置代理直接访问被封锁的主域名
- **当前状态**：待实现
- **存在问题**：HTTP/SOCKS5 代理是明文传输，存在代理泄漏和滥用风险

### 方案二：国内中转服务器

提供两种国内可直接访问的方式：

**方式 A：国内服务器 IP + 端口**

```yaml
panels:
  mihomo:
    - url: https://10.0.0.1:8888
      description: "国内中转服务器"
```

**配置要求：**
- 在国内服务器上部署 Caddy 或其他反向代理工具
- 使用 IP+端口方式需生成私有证书
- 证书文件放置路径：`flutter_xboard_sdk/assets/cer/`
- 提供 HTTPS 访问能力

⚠️ **安全提示**：
- 可以在配置中关闭证书验证，但**极其不推荐**
- 关闭证书验证后，HTTP 数据将明文传输在互联网中

**方式 B：已备案域名**

```yaml
panels:
  mihomo:
    - url: https://your-domain.com
      description: "已备案域名"
```

### 方案三：直接访问国外未被墙域名

如果你的面板域名托管在国外，且未被封锁，可以直接配置访问：

```yaml
panels:
  mihomo:
    - url: https://api-overseas.example.com
      description: "国外未被墙域名"
```

**适用场景：**
- 域名托管在海外云服务商（Cloudflare、AWS 等）
- 域名尚未被列入封锁名单
- 使用 CDN 加速服务，IP 分散

**优势：**
- ✅ 无需额外部署中转服务器
- ✅ 直连访问，延迟最低
- ✅ 配置简单，维护成本低
- ✅ HTTPS 证书由正规 CA 签发

### 数据混淆与加密

**第一层：UA 对等密钥验证**

```yaml
security:
  user_agents:
    api_encrypted: Mozilla/5.0 (compatible; RmxDbGFzaC1XdWppZS1BUEkvMS4w)
```

- `RmxDbGFzaC1XdWppZS1BUEkvMS4w` 即为 Base64 编码的对等密钥
- 请求 UA 中必须携带此密钥才能被反向代理服务器认可
- 与后端 Caddy 配置约定一致

**第二层：API 响应混淆**

- 使用 Caddy 对 API 响应数据包进行混淆处理
- 基于 API 的自定义特性实现
- 产生与开源 XBoard 方案不同的数据特征

---

## 🚀 高可用性保障

### 域名竞速策略

```yaml
domain_service:
  enable: true                    # 启用域名竞速
  cache_minutes: 5                # 缓存 5 分钟
  max_concurrent_tests: 10        # 最大并发测试数
```

**工作原理：**
1. 并发请求配置文件中的所有域名
2. 返回响应最快的域名作为活跃入口
3. 立即终止对其他域名的请求
4. 最快域名响应即作为当前会话的入口域名

**应用场景：**
- ✅ 主站点入口域名竞速
- ✅ 订阅地址竞速获取
- ✅ 配置文件源竞速加载

**优势：**
- 确保始终使用最快的可用域名
- 提升用户体验
- 自动容灾切换

---

## 📁 配置文件托管方案

为确保配置文件的高可用性和安全性，支持双通道配置源。

### 方案一：GitHub 私有仓库 + 代理服务器

**配置示例：**

```yaml
remote_config:
  sources:
    - name: github_proxy
      url: https://your-proxy.com/config.json
      priority: 100
```

**工作流程：**
1. 配置文件存储在 GitHub 私有仓库
2. 代理服务器从 GitHub 拉取配置
3. 客户端从代理服务器获取配置
4. 代理服务器可部署在国内，提供加速访问

**优势：**
- ✅ 配置文件安全存储在 GitHub
- ✅ 国内代理服务器提供快速访问
- ✅ 支持版本控制和历史回溯
- ✅ 灵活的访问控制

### 方案二：Gitee 公开仓库 + 客户端解密

**配置示例：**

```yaml
remote_config:
  sources:
    - name: gitee_encrypted
      url: https://gitee.com/user/repo/raw/main/config.json.encrypted
      priority: 90
      encryption_key: your_encryption_key_here
```

**工作流程：**
1. 配置文件加密后存储在 Gitee 公开仓库
2. 客户端下载加密的配置文件
3. 使用内置密钥解密配置
4. 即使配置文件公开，内容也无法被读取

**优势：**
- ✅ 国内直接访问，无需代理
- ✅ 加密保护，安全性高
- ✅ 公开仓库，无需担心访问限制
- ✅ 支持多客户端共享配置

---

## 🔄 应用生命周期

### 启动流程

```
应用启动
  ↓
加载本地配置 (xboard.config.yaml)
  ↓
获取远程配置源地址
  ↓
[并发] 请求所有配置源
  ↓
选择最快响应的配置
  ↓
解析配置 (config.json)
  ↓
[并发] 域名竞速选择最快面板
  ↓
连接面板服务器
  ↓
✅ 应用就绪
```

### 配置更新策略

- **缓存时间**：默认 5 分钟
- **更新触发**：缓存过期或用户手动刷新
- **降级策略**：主源失败自动切换备用源
- **容错机制**：配置解析失败使用默认值

---

## 🌟 扩展功能

### 在线客服系统

**配置示例：**

```yaml
onlineSupport:
  - url: https://chat.example.com
    description: "在线客服API服务"
    apiBaseUrl: https://chat.example.com
    wsBaseUrl: wss://chat.example.com
```

**功能特性：**
- 实时聊天支持
- WebSocket 长连接
- 消息推送通知
- 客服工单系统

### 设备上报与远程任务（实验性功能）

**配置示例：**

```yaml
ws:
  - url: wss://ws.example.com/ws/
    description: "WebSocket服务器"
```

**功能说明：**
- **设备上报**：定期上报设备信息和运行状态
- **远程任务**：接收服务端下发的控制指令
- **实时同步**：配置变更实时推送

⚠️ **隐私提示：**
- 该功能会收集设备信息
- 可能存在隐私和安全风险
- 使用前请充分评估风险

### 自动更新检查

**配置示例：**

```yaml
update:
  - url: https://update.example.com
    description: "更新服务器"
```

**更新流程：**
1. 定期检查更新接口
2. 对比版本号
3. 提示用户更新
4. 下载并安装新版本

**更新信息格式：**

```json
{
  "version": "1.0.5",
  "buildNumber": 105,
  "downloadUrl": "https://update.example.com/app-v1.0.5.apk",
  "changelog": "修复已知问题，优化性能",
  "forceUpdate": false
}
```

---

## 📚 相关文档

- [配置文档](./configuration.md)
- [安全配置](./security.md)
- [服务端部署](./server-deployment.md)
- [快速开始](./quick-start.md)

---

**需要帮助？** 提交 [Issue](https://github.com/hakimi-x/Xboard-Mihomo/issues)

