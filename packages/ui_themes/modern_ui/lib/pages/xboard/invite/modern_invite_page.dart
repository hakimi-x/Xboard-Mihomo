// ═══════════════════════════════════════════════════════
// 🆕 新UI实现 - ModernUI 邀请页面
// ═══════════════════════════════════════════════════════

import 'dart:ui';
import 'package:fl_clash/ui/contracts/pages/pages_contracts.dart';
import 'package:flutter/material.dart';

class ModernInvitePage extends InvitePageContract {
  const ModernInvitePage({super.key, required super.data, required super.callbacks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text('邀请好友'), actions: [IconButton(icon: const Icon(Icons.help_outline), onPressed: callbacks.onViewInviteRules)]),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Theme.of(context).colorScheme.primary.withOpacity(0.1), Theme.of(context).colorScheme.tertiary.withOpacity(0.1)])),
        child: RefreshIndicator(
          onRefresh: callbacks.onRefresh,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary.withOpacity(0.3), Theme.of(context).colorScheme.secondary.withOpacity(0.3)]), borderRadius: BorderRadius.circular(32)),
                    child: Column(
                      children: [
                        Text('可用佣金', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
                        const SizedBox(height: 8),
                        Text(data.commissionStats.formatAmount(data.commissionStats.availableCommission), style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 16),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                          _buildStatItem('总邀请', '${data.commissionStats.totalInvites}人'),
                          _buildStatItem('有效邀请', '${data.commissionStats.activeInvites}人'),
                        ]),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.white, Colors.white70]), borderRadius: BorderRadius.circular(20)),
                          child: ElevatedButton(onPressed: callbacks.onWithdraw, style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: Text('申请提现', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface.withOpacity(0.7), borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('邀请方式', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        TextField(readOnly: true, controller: TextEditingController(text: data.inviteCode), decoration: InputDecoration(labelText: '邀请码', filled: true, fillColor: Colors.white.withOpacity(0.1), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none), suffixIcon: IconButton(icon: const Icon(Icons.copy), onPressed: callbacks.onCopyInviteCode))),
                        const SizedBox(height: 12),
                        Row(children: [
                          Expanded(child: OutlinedButton.icon(onPressed: callbacks.onGenerateQrCode, icon: const Icon(Icons.qr_code), label: const Text('二维码'), style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))))),
                          const SizedBox(width: 8),
                          Expanded(child: ElevatedButton.icon(onPressed: callbacks.onShareInvite, icon: const Icon(Icons.share), label: const Text('分享'), style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))))),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(children: [Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)), const SizedBox(height: 4), Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))]);
  }
}

