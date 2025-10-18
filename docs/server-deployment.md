# 服务端部署指南

XBoard Mihomo 服务端组件部署说明。

---

## 📋 目录

- [必需组件](#必需组件)
- [可选组件](#可选组件)
- [部署架构](#部署架构)

---

## 必需组件

### 1. XBoard 面板 (v20250905-b144770)

**基本要求：**
- 部署 XBoard 面板主站点
- 配置订阅接口
- 确保版本匹配：v20250905-b144770

**部署文档：**
参考 [XBoard 官方文档](https://github.com/xboard)

### 2. Caddy 反向代理（推荐）

Caddy 用于国内中转、UA 验证和响应混淆。

#### 基础反向代理配置

```caddyfile
# 国内中转服务器配置
:8888 {
  # 反向代理到真实面板域名
  reverse_proxy https://real-panel-domain.com {
    # 透传 User-Agent
    header_up User-Agent {http.request.header.User-Agent}
  }
  
  # 数据混淆
  encode gzip
  
  # 自定义响应头
  header / {
    -Server
    X-Custom-Header "random-value"
  }
}
```

#### 带 UA 验证的配置

```caddyfile
:8888 {
  # UA 验证：只允许携带特定密钥的请求
  @authorized {
    header User-Agent *RmxDbGFzaC1XdWppZS1BUEkvMS4w*
  }
  
  handle @authorized {
    reverse_proxy https://real-panel-domain.com
  }
  
  handle {
    respond "Unauthorized" 403
  }
}
```

**说明：**
- `RmxDbGFzaC1XdWppZS1BUEkvMS4w` 是 Base64 编码的密钥
- 需要与客户端配置中的 `api_encrypted` UA 一致
- 不匹配的请求返回 403

#### 订阅中转配置

```caddyfile
:7880 {
  reverse_proxy https://real-subscription-domain.com {
    header_up Host {http.reverse_proxy.upstream.hostport}
  }
  
  encode gzip
}
```

#### 响应混淆配置

```caddyfile
:8888 {
  reverse_proxy https://real-panel-domain.com
  
  # 响应混淆：在响应前添加混淆前缀
  replace {
    "{\"status\"" "OBFS_PREFIX_{\"status\""
  }
  
  encode gzip
}
```

**注意：**
- 混淆前缀需与客户端配置的 `obfuscation_prefix` 一致
- 客户端会自动检测并移除前缀

#### 完整配置示例

```caddyfile
# 面板服务（带 UA 验证和响应混淆）
:8888 {
  @authorized {
    header User-Agent *RmxDbGFzaC1XdWppZS1BUEkvMS4w*
  }
  
  handle @authorized {
    reverse_proxy https://real-panel-domain.com {
      header_up User-Agent {http.request.header.User-Agent}
    }
    
    # 响应混淆
    replace {
      "{\"status\"" "OBFS_PREFIX_{\"status\""
    }
  }
  
  handle {
    respond "Unauthorized" 403
  }
  
  encode gzip
  
  header / {
    -Server
    X-Powered-By "CustomServer/1.0"
  }
}

# 订阅服务
:7880 {
  reverse_proxy https://real-subscription-domain.com {
    header_up Host {http.reverse_proxy.upstream.hostport}
  }
  
  encode gzip
}
```

### 私有证书配置

如果使用 IP+端口方式部署，需要生成私有证书：

```bash
# 生成自签名证书
openssl req -x509 -newkey rsa:4096 \
  -keyout key.pem -out cert.pem \
  -days 365 -nodes \
  -subj "/CN=your-ip-address"
```

**Caddy 配置：**

```caddyfile
https://your-ip:8888 {
  tls /path/to/cert.pem /path/to/key.pem
  
  reverse_proxy https://real-panel-domain.com
}
```

**客户端配置：**

将 `cert.pem` 文件复制到客户端：
```
lib/sdk/flutter_xboard_sdk/assets/cer/client-cert.crt
```

---

## 可选组件

### 3. WebSocket 上报服务

**功能：**
- 接收客户端上报数据
- 任务下发（谨慎使用）
- 设备统计分析

**技术栈建议：**
- Node.js + Socket.io
- Python + WebSockets
- Go + Gorilla WebSocket

**简单示例（Node.js）：**

```javascript
const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 8080 });

wss.on('connection', (ws) => {
  console.log('Client connected');
  
  ws.on('message', (message) => {
    const data = JSON.parse(message);
    console.log('Received:', data);
    
    // 处理上报数据
    // ...
  });
  
  ws.on('close', () => {
    console.log('Client disconnected');
  });
});
```

### 4. 在线客服后端

**功能：**
- WebSocket 实时消息
- Telegram Bot 集成
- 消息转发和通知

**部署要点：**
- 配置 Telegram Bot Token
- 设置 WebSocket 端点
- API 接口对接

**Telegram Bot 示例：**

```python
from telegram import Bot
from telegram.ext import Updater, MessageHandler, Filters

def handle_message(update, context):
    # 转发消息到客户端
    message = update.message.text
    # WebSocket 推送...
    
updater = Updater("YOUR_BOT_TOKEN")
updater.dispatcher.add_handler(MessageHandler(Filters.text, handle_message))
updater.start_polling()
```

### 5. 更新检查服务

**功能：**
- 版本更新通知
- APK/安装包分发
- 更新日志展示

**API 格式：**

```json
{
  "version": "1.0.5",
  "buildNumber": 105,
  "downloadUrl": "https://update.example.com/app-v1.0.5.apk",
  "changelog": "修复已知问题，优化性能",
  "forceUpdate": false
}
```

**简单实现（静态文件）：**

直接托管一个 JSON 文件：
```bash
https://update.example.com/version.json
```

**动态实现（Node.js）：**

```javascript
const express = require('express');
const app = express();

app.get('/version', (req, res) => {
  const platform = req.query.platform;
  
  res.json({
    version: "1.0.5",
    buildNumber: 105,
    downloadUrl: `https://update.example.com/app-${platform}-v1.0.5.apk`,
    changelog: "修复已知问题，优化性能",
    forceUpdate: false
  });
});

app.listen(3000);
```

---

## 部署架构

### 推荐架构

```
┌─────────────────┐
│   用户客户端     │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  国内 Caddy 反代 │ ← IP+端口 或 已备案域名
│   (UA 验证)      │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  国外 XBoard面板 │ ← 真实面板域名
│  (可能被墙)      │
└─────────────────┘
```

### 多节点架构

```
                ┌─────────────────┐
                │   用户客户端     │
                │  (域名竞速)      │
                └────────┬────────┘
                         │
         ┌───────────────┼───────────────┐
         │               │               │
         ↓               ↓               ↓
┌────────────┐  ┌────────────┐  ┌────────────┐
│ 中转节点1   │  │ 中转节点2   │  │ 中转节点3   │
│ (香港)      │  │ (新加坡)    │  │ (日本)      │
└─────┬──────┘  └─────┬──────┘  └─────┬──────┘
      │               │               │
      └───────────────┼───────────────┘
                      │
                      ↓
              ┌───────────────┐
              │  XBoard 面板   │
              └───────────────┘
```

### 配置文件分发架构

```
┌─────────────────┐
│   开发者本地     │
└────────┬────────┘
         │ git push
         ↓
┌─────────────────┐
│  GitHub/Gitee   │ ← config.json (可加密)
└────────┬────────┘
         │
         ├──→ CDN 加速 (可选)
         │
         ↓
┌─────────────────┐
│   用户客户端     │
│  (配置竞速)      │
└─────────────────┘
```

---

## 安全建议

### 1. 证书配置
- ✅ 生产环境必须启用 HTTPS
- ✅ 使用正规 CA 签发的证书
- ⚠️ 私有证书仅用于 IP+端口场景
- ❌ 不要在生产环境禁用证书验证

### 2. UA 验证
- ✅ 使用强密钥（建议32位以上）
- ✅ 定期更换密钥
- ✅ 与客户端配置保持同步
- ⚠️ 密钥不要在公开渠道泄露

### 3. 访问控制
- ✅ 限制来源 IP（如果可行）
- ✅ 配置速率限制
- ✅ 启用访问日志
- ⚠️ 监控异常流量

### 4. 数据保护
- ✅ 配置文件加密存储
- ✅ 敏感信息脱敏
- ✅ 定期备份数据
- ⚠️ 谨慎使用设备上报功能

---

## 📚 相关文档

- [配置文档](./configuration.md)
- [安全配置](./security.md)
- [核心特性](./features.md)
- [快速开始](./quick-start.md)

---

**需要帮助？** 提交 [Issue](https://github.com/hakimi-x/Xboard-Mihomo/issues)

