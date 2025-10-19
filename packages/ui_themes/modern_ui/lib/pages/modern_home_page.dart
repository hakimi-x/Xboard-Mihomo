// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 首页
// ═══════════════════════════════════════════════════════
// 这是UI分离重构后的现代风格实现
// 特点：大圆角、毛玻璃效果、渐变背景、卡片布局
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/home_page_contract.dart';
import 'package:flutter/material.dart';

/// ModernUI 首页实现
/// 
/// 采用现代化设计风格
/// 特点：
/// - CustomScrollView + Sliver 布局
/// - 大圆角（20px）
/// - 毛玻璃效果（BackdropFilter）
/// - 渐变背景
/// - 浮动操作按钮
class ModernHomePage extends HomePageContract {
  const ModernHomePage({
    super.key,
    required super.data,
    required super.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primaryContainer.withOpacity(0.3),
              colorScheme.secondaryContainer.withOpacity(0.3),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // 大标题栏
            _buildAppBar(context),
            
            // 内容区域
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // 连接卡片（毛玻璃效果）
                  _buildGlassConnectionCard(context),
                  
                  const SizedBox(height: 24),
                  
                  // 流量图表
                  _buildTrafficChart(context),
                  
                  const SizedBox(height: 24),
                  
                  // 快速操作网格
                  _buildQuickActionsGrid(context),
                  
                  const SizedBox(height: 100), // 底部padding
                ]),
              ),
            ),
          ],
        ),
      ),
      
      // 浮动操作按钮
      floatingActionButton: FloatingActionButton.extended(
        onPressed: callbacks.onSettingsTap,
        icon: const Icon(Icons.tune),
        label: const Text('设置'),
        elevation: 8,
      ),
    );
  }

  /// 大标题栏
  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${data.userName} 👋',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (data.currentProfileName != null)
              Text(
                data.currentProfileName!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
                Theme.of(context).colorScheme.secondary.withOpacity(0.6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 毛玻璃连接卡片
  Widget _buildGlassConnectionCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isConnected = data.isConnected;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: isConnected
                ? colorScheme.primary.withOpacity(0.15)
                : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isConnected ? Colors.green : Colors.red,
                              boxShadow: [
                                BoxShadow(
                                  color: (isConnected ? Colors.green : Colors.red)
                                      .withOpacity(0.5),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isConnected ? '已连接' : '未连接',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (isConnected && data.currentDelay != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          '延迟 ${data.currentDelay}ms',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  // 圆形切换按钮
                  GestureDetector(
                    onTap: callbacks.onConnectToggle,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isConnected
                              ? [colorScheme.primary, colorScheme.secondary]
                              : [Colors.grey.shade400, Colors.grey.shade600],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (isConnected ? colorScheme.primary : Colors.grey)
                                .withOpacity(0.5),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        isConnected ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // 流量速率显示
              Row(
                children: [
                  Expanded(
                    child: _buildSpeedIndicator(
                      context,
                      icon: Icons.arrow_upward,
                      label: '上传',
                      value: data.formatSpeed(data.uploadSpeed),
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSpeedIndicator(
                      context,
                      icon: Icons.arrow_downward,
                      label: '下载',
                      value: data.formatSpeed(data.downloadSpeed),
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 速率指示器
  Widget _buildSpeedIndicator(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontSize: 10,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 流量图表卡片
  Widget _buildTrafficChart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '流量统计',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: callbacks.onConnectionsTap,
                icon: const Icon(Icons.link, size: 16),
                label: Text('${data.activeConnections} 连接'),
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // 总流量显示
          Row(
            children: [
              Expanded(
                child: _buildTrafficStat(
                  context,
                  label: '总上传',
                  value: data.formatTraffic(data.totalUpload),
                  icon: Icons.upload,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTrafficStat(
                  context,
                  label: '总下载',
                  value: data.formatTraffic(data.totalDownload),
                  icon: Icons.download,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 流量统计项
  Widget _buildTrafficStat(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// 快速操作网格
  Widget _buildQuickActionsGrid(BuildContext context) {
    final actions = [
      _ActionItem(
        icon: Icons.folder_outlined,
        label: '配置文件',
        color: Colors.purple,
        onTap: callbacks.onProfilesTap,
      ),
      _ActionItem(
        icon: Icons.language,
        label: '代理节点',
        color: Colors.blue,
        onTap: callbacks.onProxiesTap,
      ),
      _ActionItem(
        icon: Icons.article_outlined,
        label: '运行日志',
        color: Colors.orange,
        onTap: callbacks.onLogsTap,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return _buildActionCard(context, action);
      },
    );
  }

  /// 操作卡片
  Widget _buildActionCard(BuildContext context, _ActionItem action) {
    return InkWell(
      onTap: action.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              action.color.withOpacity(0.15),
              action.color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: action.color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: action.color.withOpacity(0.2),
              ),
              child: Icon(
                action.icon,
                size: 28,
                color: action.color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              action.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// 操作项数据模型
class _ActionItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

