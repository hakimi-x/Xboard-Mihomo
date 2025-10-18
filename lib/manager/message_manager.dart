import 'dart:async';
import 'dart:math';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/widgets/fade_box.dart';
import 'package:flutter/material.dart';

class MessageManager extends StatefulWidget {
  final Widget child;

  const MessageManager({
    super.key,
    required this.child,
  });

  @override
  State<MessageManager> createState() => MessageManagerState();
}

class MessageManagerState extends State<MessageManager> {
  final _messagesNotifier = ValueNotifier<List<CommonMessage>>([]);
  final List<CommonMessage> _bufferMessages = [];
  bool _pushing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messagesNotifier.dispose();
    super.dispose();
  }

  Future<void> message(String text, {VoidCallback? onTap}) async {
    final commonMessage = CommonMessage(
      id: utils.uuidV4,
      text: text,
      onTap: onTap,
    );
    commonPrint.log(text);
    _bufferMessages.add(commonMessage);
    await _showMessage();
  }

  _showMessage() async {
    if (_pushing == true) {
      return;
    }
    _pushing = true;
    while (_bufferMessages.isNotEmpty) {
      final commonMessage = _bufferMessages.removeAt(0);
      _messagesNotifier.value = List.from(_messagesNotifier.value)
        ..add(
          commonMessage,
        );
      await Future.delayed(Duration(seconds: 1));
      Future.delayed(commonMessage.duration, () {
        _handleRemove(commonMessage);
      });
      if (_bufferMessages.isEmpty) {
        _pushing = false;
      }
    }
  }

  _handleRemove(CommonMessage commonMessage) async {
    _messagesNotifier.value = List<CommonMessage>.from(_messagesNotifier.value)
      ..remove(commonMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ValueListenableBuilder(
          valueListenable: _messagesNotifier,
          builder: (_, messages, __) {
            return FadeThroughBox(
              margin: EdgeInsets.only(
                top: kToolbarHeight + 8,
                left: 12,
                right: 12,
              ),
              alignment: Alignment.topRight,
              child: messages.isEmpty
                  ? SizedBox()
                  : LayoutBuilder(
                      key: Key(messages.last.id),
                      builder: (_, constraints) {
                        final message = messages.last;

                        // 构建卡片内容
                        final cardContent = Container(
                          width: min(
                            constraints.maxWidth,
                            500,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          child: Text(
                            message.text,
                          ),
                        );

                        // 如果有点击回调，整个卡片都可点击
                        if (message.onTap != null) {
                          return GestureDetector(
                            onTap: () {
                              message.onTap?.call();
                              _handleRemove(message);
                            },
                            behavior: HitTestBehavior.opaque, // 整个区域可点击，包括空白处
                            child: Card(
                              shape: const RoundedSuperellipseBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              elevation: 10,
                              color: context.colorScheme.surfaceContainerHigh,
                              child: cardContent,
                            ),
                          );
                        }

                        // 没有点击回调的普通卡片
                        return Card(
                          shape: const RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          elevation: 10,
                          color: context.colorScheme.surfaceContainerHigh,
                          child: cardContent,
                        );
                      },
                    ),
            );
          },
        ),
      ],
    );
  }
}
