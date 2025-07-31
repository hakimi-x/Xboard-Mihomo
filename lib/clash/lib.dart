import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';

import 'interface.dart';

class ClashLib extends ClashHandlerInterface {
  static ClashLib? _instance;

  ClashLib._internal();

  @override
  preload() async {
    return true;
  }

  factory ClashLib() {
    _instance ??= ClashLib._internal();
    return _instance!;
  }

  @override
  destroy() async {
    return true;
  }

  @override
  Future<bool> shutdown() async {
    await super.shutdown();
    destroy();
    return true;
  }

  @override
  Future<T?> invoke<T>({
    required ActionMethod method,
    String? data,
    Duration? timeout,
  }) async {
    return null;
    // final id = '${method.name}#${utils.id}';
    // final result = await service?.invokeAction(Action(
    //   id: id,
    //   method: method,
    //   data: data,
    // ));
    // if (result == null) {
    //   return null;
    // }
    // if (result.method == ActionMethod.getConfig) {
    //   return result.toResult as T?;
    // }
    // return result.data as T?;
  }
}

ClashLib? get clashLib => system.isAndroid ? ClashLib() : null;
