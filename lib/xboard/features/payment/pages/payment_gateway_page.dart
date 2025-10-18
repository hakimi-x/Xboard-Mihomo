import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/xboard/sdk/xboard_sdk.dart';
class PaymentGatewayPage extends ConsumerStatefulWidget {
  final String paymentUrl;
  final String tradeNo;
  const PaymentGatewayPage({
    super.key,
    required this.paymentUrl,
    required this.tradeNo,
  });
  @override
  ConsumerState<PaymentGatewayPage> createState() => _PaymentGatewayPageState();
}
class _PaymentGatewayPageState extends ConsumerState<PaymentGatewayPage> {
  bool _isLoading = true;
  String? _errorMessage;
  bool _isCheckingPayment = false;
  bool _autoPollingEnabled = false;
  @override
  void initState() {
    super.initState();
    _openPaymentUrl();
    _startPaymentStatusCheck();
  }
  @override
  void dispose() {
    _stopAutoPolling();
    super.dispose();
  }
  Future<void> _openPaymentUrl() async {
    try {
      setState(() {
        _isLoading = false;
      });
      await _launchPaymentUrl(isAutomatic: true);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }
  Future<void> _launchPaymentUrl({bool isAutomatic = false}) async {
    try {
      final uri = Uri.parse(widget.paymentUrl);
      if (!await canLaunchUrl(uri)) {
        throw Exception('无法打开支付链接: ${widget.paymentUrl}');
      }
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // 强制在外部浏览器打开
      );
      if (!launched) {
        throw Exception('无法启动外部浏览器');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isAutomatic 
              ? '🚀 正在自动打开支付页面，完成支付后请返回应用'
              : '已在浏览器中打开支付页面，完成支付后请返回应用'),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: isAutomatic ? 3 : 4),
          ),
        );
        _startAutoPolling();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('打开支付链接失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  Future<void> _copyPaymentUrl() async {
    try {
      await Clipboard.setData(ClipboardData(text: widget.paymentUrl));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('支付链接已复制到剪贴板'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('复制失败: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  Future<void> _startPaymentStatusCheck() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      _checkPaymentStatus();
    }
  }
  void _startAutoPolling() {
    if (_autoPollingEnabled) return;
    setState(() {
      _autoPollingEnabled = true;
    });
    _pollPaymentStatus();
  }
  void _stopAutoPolling() {
    setState(() {
      _autoPollingEnabled = false;
    });
  }
  Future<void> _pollPaymentStatus() async {
    if (!_autoPollingEnabled || !mounted) return;
    await Future.delayed(const Duration(seconds: 5));
    if (!_autoPollingEnabled || !mounted) return;
    await _checkPaymentStatus(silent: true);
    if (_autoPollingEnabled && mounted) {
      _pollPaymentStatus();
    }
  }
  Future<void> _checkPaymentStatus({bool silent = false}) async {
    if (_isCheckingPayment) return;
    setState(() {
      _isCheckingPayment = true;
    });
    try {
      final order = await XBoardSDK.getOrderByTradeNo(widget.tradeNo);
      if (mounted) {
        setState(() {
          _isCheckingPayment = false;
        });
        if (order != null) {
          if (order.status == 2) {
            _stopAutoPolling();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🎉 支付成功！'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            });
          } else if (order.status == 3) {
            _stopAutoPolling();
            if (!silent) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('支付已取消'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          } else if (order.status == 1) {
            if (!silent) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_autoPollingEnabled ? '正在等待支付...' : '订单状态：待支付'),
                  backgroundColor: Colors.blue,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          }
        } else {
          if (!silent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('未找到订单信息')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCheckingPayment = false;
        });
        if (!silent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('检查支付状态失败: $e')),
          );
        }
      }
    }
  }
  void _completePayment() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('支付完成！')),
    );
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
  void _cancelPayment() {
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: '支付网关',
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(_errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('返回'),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '支付信息',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Text('订单号: '),
                                  Expanded(
                                    child: Text(
                                      widget.tradeNo,
                                      style: const TextStyle(fontFamily: 'monospace'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              InkWell(
                                onTap: _copyPaymentUrl,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.blue.shade200),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.info, color: Colors.blue),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  '支付链接',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  Icons.copy,
                                                  size: 16,
                                                  color: Colors.blue.shade600,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '点击复制',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.blue.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              widget.paymentUrl,
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_autoPollingEnabled)
                        Card(
                          color: Colors.green.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '自动检测支付状态',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade800,
                                        ),
                                      ),
                                      Text(
                                        '系统每5秒自动检查一次，支付完成后会自动跳转',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.green.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: _stopAutoPolling,
                                  child: Text(
                                    '停止',
                                    style: TextStyle(color: Colors.green.shade700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (_autoPollingEnabled) const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '操作提示',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text('1. 系统已自动为您打开支付页面'),
                              const Text('2. 请在浏览器中完成支付操作'),
                              const Text('3. 支付完成后返回应用，系统将自动检测'),
                              const Text('4. 如需重新打开，可点击下方"重新打开"按钮'),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade50,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.amber.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outline, size: 16, color: Colors.amber.shade700),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '提示：如果浏览器未自动打开，可以点击"重新打开"或复制链接手动打开',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.amber.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _launchPaymentUrl(isAutomatic: false),
                              icon: const Icon(Icons.open_in_browser),
                              label: const Text('重新打开'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _copyPaymentUrl,
                              icon: const Icon(Icons.copy),
                              label: const Text('复制链接'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _isCheckingPayment ? null : _checkPaymentStatus,
                              icon: _isCheckingPayment
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Icon(Icons.refresh),
                              label: Text(_isCheckingPayment ? '检查中...' : '检查状态'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _completePayment,
                              icon: const Icon(Icons.check_circle),
                              label: const Text('支付完成'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _cancelPayment,
                              icon: const Icon(Icons.cancel),
                              label: const Text('取消支付'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
} 