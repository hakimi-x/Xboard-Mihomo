# Xboard-Mihomo 文档中心

欢迎使用 Xboard-Mihomo！这里是完整的配置和使用文档。

## 📖 文档导航

### 🚀 快速开始
- **[最小可用性配置](./quick-start.md)** - 5分钟快速上手，只需配置一个主源地址
- **[构建指南](./build-guide.md)** - 完整的构建和运行环境配置指南

### 📖 详细文档
- **[核心特性](./features.md)** - 详细的功能说明和使用方法
- **[服务端部署](./server-deployment.md)** - XBoard 面板和 Caddy 反代配置
- **[配置示例](./examples/)** - 各种配置场景的完整示例

### 📋 核心概念

#### 什么是主源配置？
Xboard-Mihomo 使用**主源配置**模式，将所有服务器信息集中在一个 `config.json` 文件中：

```
┌─────────────────┐
│  客户端应用      │
└────────┬────────┘
         │ 读取配置
         ↓
┌─────────────────┐
│ xboard.config   │ ← 指向主源地址
│     .yaml       │
└────────┬────────┘
         │ 下载主源
         ↓
┌─────────────────┐
│  config.json    │ ← 主源配置（面板、代理、订阅等）
│  (托管在远程)    │
└────────┬────────┘
         │ 连接服务
         ↓
┌─────────────────┐
│   面板服务器     │
└─────────────────┘
```

**优势：**
- ✅ 集中管理所有服务器配置
- ✅ 更新配置无需重新发布客户端
- ✅ 支持多节点自动竞速
- ✅ 灵活的配置策略

## 🎯 配置文件说明

### config.json - 主源配置文件
存储所有服务器信息，包括：
- `panels` - 面板服务器地址（必填）
- `proxy` - 代理服务器（可选）
- `ws` - WebSocket 服务器（可选）
- `update` - 更新服务器（可选）
- `onlineSupport` - 在线客服（可选）
- `subscription` - 订阅服务（可选）

**托管位置**：GitHub/Gitee/自建服务器/CDN

### xboard.config.yaml - 客户端配置文件
客户端本地配置，主要包括：
- `provider` - 提供商名称
- `remote_config` - 主源地址
- `log` - 日志配置
- `sdk` - SDK 配置
- `security` - 安全配置

**文件位置**：`assets/config/xboard.config.yaml`

## 📝 最小配置示例

### 1. config.json（主源）
```json
{
    "panels": {
        "mihomo": [
            {
                "url": "https://your-panel.com",
                "description": "主面板"
            }
        ]
    }
}
```

### 2. xboard.config.yaml（客户端）
```yaml
xboard:
  provider: mihomo
  remote_config:
    sources:
      - name: main_source
        url: https://your-domain.com/config.json
        priority: 100
```

完整教程请查看 **[快速开始](./quick-start.md)**

## 🔧 配置场景

根据您的需求选择合适的配置方案：

| 场景 | 配置方案 | 文档链接 |
|------|---------|---------|
| 🚀 快速开始 | 只配置一个面板地址 | [快速开始](./quick-start.md) |
| 🛠️ 构建应用 | 环境准备和编译打包 | [构建指南](./build-guide.md) |
| 🌟 核心特性 | 功能说明和使用方法 | [核心特性](./features.md) |
| 🔒 服务端部署 | XBoard 面板和 Caddy 配置 | [服务端部署](./server-deployment.md) |
| 🏢 生产环境 | 多面板 + 备用节点 | [生产配置](./examples/production.md) |

## 💡 配置技巧

### 1. 只需配置必要的内容
最小配置只需要 `panels` 部分，其他都是可选的：
```json
{
    "panels": { "mihomo": [{ "url": "https://panel.com" }] }
}
```

### 2. 使用多节点提高可用性
配置多个面板地址，客户端会自动竞速选择最快的：
```json
{
    "panels": {
        "mihomo": [
            { "url": "https://panel1.com", "description": "主节点" },
            { "url": "https://panel2.com", "description": "备用节点" }
        ]
    }
}
```

### 3. provider 名称保持一致
确保两个配置文件中的 provider 名称一致：
- `config.json`: `"panels": { "mihomo": [...] }`
- `xboard.config.yaml`: `provider: mihomo`

## 📚 更多资源

- [完整配置参数说明](./config-reference.md)
- [常见问题解答](./faq.md)
- [故障排查指南](./troubleshooting.md)

## 🆘 获取帮助

如果遇到问题：
1. 查看 [常见问题](./faq.md)
2. 检查 [故障排查指南](./troubleshooting.md)
3. 提交 [Issue](https://github.com/hakimi-x/Xboard-Mihomo/issues)

---

**开始使用** → [快速开始教程](./quick-start.md)

