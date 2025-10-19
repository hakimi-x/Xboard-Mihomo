// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - DefaultUI 首页
// ═══════════════════════════════════════════════════════
// 这是UI分离重构后的新实现
// 基于原有UI风格，采用契约模式
// ═══════════════════════════════════════════════════════

import 'package:fl_clash/ui/contracts/pages/home_page_contract.dart';
import 'package:flutter/material.dart';

/// DefaultUI 首页实现
/// 
/// 采用传统的Material Design风格
/// 布局：AppBar + ListView
class DefaultHomePage extends HomePageContract {
  const DefaultHomePage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XBoard Mihomo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: callbacks.onSettingsTap,
            tooltip: '设置',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: callbacks.onRefresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 欢迎卡片
            _buildWelcomeCard(context),
            
            const SizedBox(height: 16),
            
            // 连接状态卡片
            _buildConnectionCard(context),
            
            const SizedBox(height: 16),
            
            // 流量统计卡片
            _buildTrafficCard(context),
            
            const SizedBox(height: 16),
            
            // 快速操作卡片
            _buildQuickActionsCard(context),
          ],
        ),
      ),
    );
  }

  /// 欢迎卡片
  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 32,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '欢迎回来',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.userName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (data.currentProfileName != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '当前配置: ${data.currentProfileName}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 连接状态卡片
  Widget _buildConnectionCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isConnected = data.isConnected;

    return Card(
      color: isConnected
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerHighest,
      child: InkWell(
        onTap: callbacks.onConnectToggle,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isConnected
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHigh,
                ),
                child: Icon(
                  isConnected ? Icons.check_circle : Icons.power_settings_new,
                  size: 32,
                  color: isConnected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isConnected ? '已连接' : '未连接',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: isConnected
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isConnected ? '点击断开连接' : '点击开始连接',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isConnected
                            ? colorScheme.onPrimaryContainer.withOpacity(0.7)
                            : colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    if (isConnected && data.currentDelay != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '延迟: ${data.currentDelay}ms',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isConnected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 流量统计卡片
  Widget _buildTrafficCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '实时速率',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSpeedItem(
                    context,
                    icon: Icons.upload,
                    label: '上传',
                    speed: data.formatSpeed(data.uploadSpeed),
                    total: data.formatTraffic(data.totalUpload),
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSpeedItem(
                    context,
                    icon: Icons.download,
                    label: '下载',
                    speed: data.formatSpeed(data.downloadSpeed),
                    total: data.formatTraffic(data.totalDownload),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: Theme.of(context).dividerColor),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '活跃连接',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton.icon(
                  onPressed: callbacks.onConnectionsTap,
                  icon: const Icon(Icons.link, size: 18),
                  label: Text('${data.activeConnections}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 速率显示项
  Widget _buildSpeedItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String speed,
    required String total,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            speed,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '总计: $total',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  /// 快速操作卡片
  Widget _buildQuickActionsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '快速操作',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.folder,
                  label: '配置',
                  onTap: callbacks.onProfilesTap,
                ),
                _buildActionButton(
                  context,
                  icon: Icons.language,
                  label: '代理',
                  onTap: callbacks.onProxiesTap,
                ),
                _buildActionButton(
                  context,
                  icon: Icons.article,
                  label: '日志',
                  onTap: callbacks.onLogsTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 操作按钮
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

