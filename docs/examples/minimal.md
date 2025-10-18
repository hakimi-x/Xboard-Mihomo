# 最小配置示例

这是最简单的配置方案，适合快速测试和个人使用。

## 配置文件

### config.json
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

### xboard.config.yaml
```yaml
xboard:
  provider: mihomo
  
  remote_config:
    sources:
      - name: main
        url: https://raw.githubusercontent.com/username/repo/main/config.json
        priority: 100
    timeout_seconds: 10
    max_retries: 3
  
  log:
    enabled: true
    level: info
```

## 配置说明

- **panels.mihomo** - 面板地址（必填）
- **onlineSupport** - 在线客服地址（必填）
- **remote_config.sources** - 指向托管的 config.json
- **log** - 基础日志配置

## 适用场景

✅ 快速测试  
✅ 个人使用  
✅ 单一服务器环境  
✅ 学习和开发  

## 下一步

配置完成后：
1. 将 `config.json` 上传到 GitHub/Gitee
2. 修改 `xboard.config.yaml` 中的 URL 为实际地址
3. 运行客户端测试

