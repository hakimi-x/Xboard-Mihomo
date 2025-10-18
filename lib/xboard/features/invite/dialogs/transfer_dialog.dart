import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/xboard/features/invite/providers/invite_provider.dart';

class TransferDialog extends ConsumerStatefulWidget {
  const TransferDialog({super.key});

  @override
  ConsumerState<TransferDialog> createState() => _TransferDialogState();
}

class _TransferDialogState extends ConsumerState<TransferDialog> {
  final TextEditingController _amountController = TextEditingController();
  bool _isTransferring = false;
  bool _isSuccess = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inviteState = ref.read(inviteProvider);
    final double maxAmount = inviteState.totalCommission / 100.0;

    return AlertDialog(
      title: Text(appLocalizations.transferToWallet),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isSuccess
                ? const Icon(
                    Icons.check_circle,
                    size: 48,
                    color: Colors.green,
                    key: ValueKey('success'),
                  )
                : _isTransferring
                    ? const SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(
                          key: ValueKey('loading'),
                        ),
                      )
                    : const Icon(
                        Icons.account_balance_wallet,
                        size: 48,
                        color: Colors.blue,
                        key: ValueKey('wallet'),
                      ),
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isSuccess
                ? Text(
                    appLocalizations.transferSuccess,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    key: const ValueKey('success-text'),
                  )
                : _isTransferring
                    ? Text(
                        appLocalizations.transferring,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        key: const ValueKey('loading-text'),
                      )
                    : Text(
                        appLocalizations.maxTransferable((inviteState.totalCommission / 100.0).toStringAsFixed(2)),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        key: const ValueKey('balance-text'),
                      ),
          ),
          const SizedBox(height: 16),
          if (!_isTransferring && !_isSuccess) ...[
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: appLocalizations.transferAmount,
                hintText: appLocalizations.enterTransferAmount,
                border: const OutlineInputBorder(),
                suffixText: '¥',
                helperText: appLocalizations.maxTransferable(maxAmount.toStringAsFixed(2)),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 12),
            Text(
              appLocalizations.transferNote,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
      actions: [
        if (!_isTransferring) ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(_isSuccess ? appLocalizations.complete : appLocalizations.cancel),
          ),
          if (!_isSuccess)
            ElevatedButton(
              onPressed: () => _performTransfer(maxAmount),
              child: Text(appLocalizations.confirmTransfer),
            ),
        ],
      ],
    );
  }

  Future<void> _performTransfer(double maxAmount) async {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.enterTransferAmountError)),
        );
      }
      return;
    }
    
    final amount = int.tryParse(amountText);
    if (amount == null || amount <= 0) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.invalidTransferAmount)),
        );
      }
      return;
    }
    
    if (amount > maxAmount) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.transferAmountExceeded(maxAmount.toStringAsFixed(2)))),
        );
      }
      return;
    }
    
    setState(() {
      _isTransferring = true;
    });
    
    try {
      final result = await ref.read(inviteProvider.notifier).transferCommission(amount);
      
      if (mounted) {
        setState(() {
          _isTransferring = false;
          _isSuccess = result != null && result.success;
        });
        
        if (result != null && result.success) {
          await Future.delayed(const Duration(milliseconds: 1500));
          if (mounted) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(appLocalizations.transferSuccessMsg(amount.toStringAsFixed(2)))),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(appLocalizations.transferFailed(result?.message ?? "未知错误"))),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isTransferring = false;
          _isSuccess = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.transferFailed(e.toString()))),
        );
      }
    }
  }
}