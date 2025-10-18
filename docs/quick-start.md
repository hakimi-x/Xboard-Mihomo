# 快速开始 - 最小可用性配置

本教程将指导您用最简单的方式配置 Xboard-Mihomo 客户端，只需要两步即可完成！

## 📋 概述

Xboard-Mihomo 采用**主源配置**的方式管理服务器信息：
- **主源配置文件**：`config.json`（放在项目根目录）
- **客户端配置**：`assets/config/xboard.config.yaml`

客户端只需要配置一个主源地址，然后从主源读取所有服务器信息，实现集中管理。

## 🚀 最小配置步骤

### 第一步：配置主源文件 `config.json`

在项目根目录创建 `config.json` 文件，**只需要配置一个面板地址**：

```json
{
    "panels": {
        "mihomo": [
            {
                "url": "https://your-panel.com",
                "description": "主面板"
            }
        ]
    },
    "onlineSupport": [
        {
            "url": "https://chat.example.com",
            "description": "在线客服",
            "apiBaseUrl": "https://chat.example.com",
            "wsBaseUrl": "wss://chat.example.com"
        }
    ]
}
```

**说明：**
- `panels.mihomo` - 面板列表（mihomo 是提供商名称，必填）
- `panels[].url` - 您的面板地址（必填）
- `panels[].description` - 面板描述（可选，方便识别）
- `onlineSupport` - 在线客服配置（必填）
- `onlineSupport[].url` - 在线客服地址（必填）
- `onlineSupport[].apiBaseUrl` - API 基础地址（必填）
- `onlineSupport[].wsBaseUrl` - WebSocket 地址（必填）

> 💡 **最小必填字段**：`panels` 和 `onlineSupport` 是客户端正常运行的最小必填配置。
> 
> ✅ **容错机制**：其他配置项（proxy、ws、update、subscription等）都是可选的，缺失的字段会使用空值，不会导致程序崩溃。

### 第二步：配置客户端 `xboard.config.yaml`

编辑 `assets/config/xboard.config.yaml` 文件，**只需配置主源地址**：

```yaml
xboard:
  # 提供商名称（与 config.json 中的 panels 键对应）
  provider: mihomo
  
  # 远程配置源 - 指向 config.json 的托管地址
  remote_config:
    sources:
      - name: main_source
        url: https://your-domain.com/config.json
        priority: 100
```

**说明：**
- `provider` - 必须与 `config.json` 中的 `panels` 键名一致（这里是 `mihomo`）
- `remote_config.sources[0].url` - 主源地址，指向您托管的 `config.json` 文件
- `priority` - 优先级（数字越大越优先）

> 💡 **主源托管方式**：
> - 可以放在 GitHub、Gitee 等代码托管平台（使用 raw 文件地址）
> - 可以放在自己的服务器上
> - 可以使用 CDN 加速

## ✅ 完整的最小配置示例

### config.json（主源配置）
```json
{
    "panels": {
        "mihomo": [
            {
                "url": "https://panel.example.com",
                "description": "主面板"
            }
        ]
    },
    "onlineSupport": [
        {
            "url": "https://chat.example.com",
            "description": "在线客服",
            "apiBaseUrl": "https://chat.example.com",
            "wsBaseUrl": "wss://chat.example.com"
        }
    ]
}
```

### xboard.config.yaml（客户端配置）
```yaml
xboard:
  provider: mihomo
  
  remote_config:
    sources:
      - name: main_source
        url: https://raw.githubusercontent.com/username/repo/main/config.json
        priority: 100
    timeout_seconds: 10
    max_retries: 3
  
  log:
    enabled: true
    level: info
```

## 🎯 工作原理

```
客户端启动
    ↓
读取 xboard.config.yaml
    ↓
获取主源地址: https://your-domain.com/config.json
    ↓
下载 config.json
    ↓
解析面板地址: https://panel.example.com
    ↓
连接到面板服务器
    ↓
✅ 开始使用
```

## 📝 配置提示

### 1. 最小必填字段
最小配置下，`config.json` 中必须包含以下两个部分：
- ✅ 必填：`panels` - 面板地址列表
- ✅ 必填：`onlineSupport` - 在线客服配置
- ❌ 可选：`proxy`、`ws`、`update`、`subscription` 等

**容错保证：**
- 所有可选字段缺失时，会使用空值（空对象 `{}` 或空数组 `[]`）
- 不会因为缺少可选字段而导致程序崩溃或报错
- 配置 `panels` 和 `onlineSupport` 两个字段，程序即可完全正常运行

### 2. 支持多个面板地址（可选）
如果需要高可用性，可以配置多个面板地址：

```json
{
    "panels": {
        "mihomo": [
            {
                "url": "https://panel1.example.com",
                "description": "主面板"
            },
            {
                "url": "https://panel2.example.com",
                "description": "备用面板"
            }
        ]
    }
}
```

客户端会自动竞速选择最快的面板。

### 3. 主源文件托管建议

**GitHub 示例：**
```
原始文件: https://github.com/username/repo/blob/main/config.json
Raw 地址: https://raw.githubusercontent.com/username/repo/main/config.json
```

**Gitee 示例：**
```
原始文件: https://gitee.com/username/repo/blob/main/config.json
Raw 地址: https://gitee.com/username/repo/raw/main/config.json
```

## 🔧 高级配置（可选）

如果需要更多功能，可以在 `config.json` 中添加其他配置项：

```json
{
    "panels": {
        "mihomo": [
            {
                "url": "https://panel.example.com",
                "description": "主面板"
            }
        ]
    },
    "proxy": [
        {
            "url": "username:password@proxy.example.com:8080",
            "description": "代理服务器",
            "protocol": "http"
        }
    ],
    "ws": [
        {
            "url": "wss://ws.example.com/ws/",
            "description": "WebSocket 服务器"
        }
    ],
    "update": [
        {
            "url": "https://update.example.com",
            "description": "更新服务器"
        }
    ]
}
```

## ❓ 常见问题

### Q1: 为什么使用主源配置？
**A:** 主源配置实现了配置的集中管理：
- ✅ 更新服务器地址时，只需修改 `config.json`，客户端自动获取最新配置
- ✅ 无需发布新版本客户端
- ✅ 支持灰度发布和 A/B 测试
- ✅ 降低客户端配置复杂度

### Q2: config.json 必须放在哪里？
**A:** `config.json` 需要托管在一个可访问的 HTTP/HTTPS 地址上，例如：
- GitHub/Gitee 仓库
- 自己的服务器
- CDN 服务
- 对象存储（OSS/S3）

### Q3: 如何更新配置？
**A:** 只需修改并上传新的 `config.json` 文件，客户端会自动获取最新配置（根据缓存策略）。

### Q4: provider 名称能自定义吗？
**A:** 可以！但必须保持一致：
- `config.json` 中使用 `"panels": { "your_name": [...] }`
- `xboard.config.yaml` 中使用 `provider: your_name`

## 📚 下一步

配置完成后，您可以：
1. 运行客户端测试连接
2. 查看日志确认配置加载是否成功
3. 根据需要添加更多高级配置

---

**需要帮助？** 查看完整文档或提交 Issue

