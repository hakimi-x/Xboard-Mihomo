# 生产环境配置示例

适合生产环境使用的完整配置方案，包含高可用性和容错机制。

## 配置文件

### config.json
```json
{
    "panels": {
        "mihomo": [
            {
                "url": "https://panel1.example.com",
                "description": "主面板-香港"
            },
            {
                "url": "https://panel2.example.com",
                "description": "备用面板-新加坡"
            },
            {
                "url": "https://panel3.example.com",
                "description": "备用面板-日本"
            }
        ]
    },
    "proxy": [
        {
            "url": "username:password@proxy1.example.com:8080",
            "description": "主代理服务器",
            "protocol": "http"
        },
        {
            "url": "username:password@proxy2.example.com:8080",
            "description": "备用代理服务器",
            "protocol": "http"
        }
    ],
    "ws": [
        {
            "url": "wss://ws1.example.com/ws/",
            "description": "主WebSocket服务器"
        },
        {
            "url": "wss://ws2.example.com/ws/",
            "description": "备用WebSocket服务器"
        }
    ],
    "update": [
        {
            "url": "https://update1.example.com",
            "description": "主更新服务器"
        },
        {
            "url": "https://update2.example.com",
            "description": "备用更新服务器"
        }
    ],
    "onlineSupport": [
        {
            "url": "https://chat.example.com",
            "description": "在线客服服务",
            "apiBaseUrl": "https://chat.example.com",
            "wsBaseUrl": "wss://chat.example.com"
        }
    ],
    "subscription": {
        "urls": [
            {
                "url": "https://sub1.example.com",
                "description": "主订阅服务器",
                "endpoints": {
                    "v2": {
                        "path": "/api/v2/subscription-encrypt/{token}",
                        "requiresToken": true,
                        "method": "GET",
                        "description": "V2 加密订阅接口"
                    }
                }
            },
            {
                "url": "https://sub2.example.com",
                "description": "备用订阅服务器",
                "endpoints": {
                    "v2": {
                        "path": "/api/v2/subscription-encrypt/{token}",
                        "requiresToken": true,
                        "method": "GET",
                        "description": "V2 加密订阅接口"
                    }
                }
            }
        ]
    }
}
```

### xboard.config.yaml
```yaml
xboard:
  provider: mihomo
  
  remote_config:
    sources:
      # CDN 加速的主源
      - name: cdn_source
        url: https://cdn.example.com/config.json
        priority: 100
      
      # GitHub 备用源
      - name: github_backup
        url: https://raw.githubusercontent.com/username/repo/main/config.json
        priority: 90
      
      # Gitee 备用源
      - name: gitee_backup
        url: https://gitee.com/username/repo/raw/main/config.json
        priority: 80
        encryption_key: your_encryption_key_here
    
    timeout_seconds: 15
    max_retries: 5
    retry_delay_seconds: 3
  
  domain_service:
    enable: true
    cache_minutes: 5
    max_retries: 3
    test_timeout_seconds: 5
    max_concurrent_tests: 10
  
  sdk:
    timeout_milliseconds: 8000
    enable_debug_log: false
    strategy: race_fastest
  
  subscription:
    prefer_encrypt: true
  
  log:
    enabled: true
    level: info
    prefix: "[XBoard-Prod]"
  
  app:
    title: Your App Name
    website: example.com
  
  security:
    decrypt_key: your_production_decrypt_key_here
    obfuscation_prefix: YOUR_OBFS_PREFIX_
    
    user_agents:
      api_encrypted: Mozilla/5.0 (compatible; YOUR_ENCRYPTED_TOKEN)
      domain_racing_test: YourApp/1.0 (Domain Racing Test)
    
    certificate:
      path: flutter_xboard_sdk/assets/cer/client-cert.crt
      enabled: true
```

## 配置特点

### 1. 多节点容错
- ✅ 3个面板服务器（不同地域）
- ✅ 2个代理服务器
- ✅ 2个WebSocket服务器
- ✅ 2个更新服务器
- ✅ 自动竞速选择最快节点

### 2. 多源配置
- ✅ CDN 加速的主源（最高优先级）
- ✅ GitHub 备用源
- ✅ Gitee 备用源（支持加密）
- ✅ 自动降级机制

### 3. 安全加固
- ✅ 加密订阅
- ✅ 响应混淆
- ✅ TLS 证书验证
- ✅ 自定义 User-Agent

### 4. 性能优化
- ✅ 域名竞速服务
- ✅ 5分钟配置缓存
- ✅ 竞速模式初始化
- ✅ 8秒超时保护

## 部署建议

### 1. 主源托管
推荐使用 CDN 加速：
```
源站: https://your-server.com/config.json
CDN: https://cdn.example.com/config.json
```

### 2. 备用源配置
- GitHub：全球访问良好
- Gitee：国内访问优化
- 自建服务器：完全可控

### 3. 地域分布
建议面板服务器分布在不同地域：
- 亚太：香港、新加坡、日本
- 欧洲：德国、英国
- 美洲：美东、美西

## 监控建议

### 1. 日志监控
定期检查日志，关注：
- 主源加载失败次数
- 节点竞速结果
- 订阅更新状态

### 2. 性能指标
- 主源响应时间
- 面板连接成功率
- 订阅更新成功率

### 3. 告警设置
- 所有主源失败
- 所有面板不可用
- 订阅解密失败

## 维护建议

### 1. 定期更新
- 每月更新配置文件
- 检查过期的服务器地址
- 优化节点分布

### 2. 灰度发布
更新 `config.json` 时：
1. 先更新 CDN 源（优先级100）
2. 观察1-2小时
3. 再更新备用源

### 3. 回滚机制
出现问题时：
1. 立即回滚 CDN 源
2. 保留备用源作为降级方案
3. 修复问题后再次发布

## 适用场景

✅ 生产环境  
✅ 大规模用户  
✅ 高可用性要求  
✅ 多地域部署  
✅ 企业级应用  

## 下一步

- 配置监控系统
- 设置告警规则
- 准备灰度发布流程
- 建立应急响应预案

